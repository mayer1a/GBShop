//
//  BasketViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 31.03.2023.
//

import UIKit

final class BasketViewController: UIViewController {

    // MARK: - Properties

    var basketView: BasketView? {
        isViewLoaded ? view as? BasketView : nil
    }

    // MARK: - Private properties

    private var presenter: BasketPresenterProtocol!
    private var quantityAction: ((Int) -> Void)?
    private var basket: BasketModel? {
        didSet { setupTitle() }
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = BasketView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewWillAppear()
    }

    // MARK: - Functions

    func setPresenter(_ presenter: BasketPresenterProtocol) {
        self.presenter = presenter
    }

    // MARK: - Private functions

    private func setupComponents() {
        basketView?.tableView.delegate = self
        basketView?.tableView.dataSource = self
        basketView?.placeOrderButton.addTarget(self, action: #selector(placeOrderButtonDidTap), for: .touchUpInside)
        navigationItem.largeTitleDisplayMode = .never
    }

    private func stepperAction(indexPath: IndexPath) -> ((Int) -> Void)? {
        quantityAction = { [weak self] value in
            guard let self, let cellModel = self.basket?.cellModels[indexPath.row] else {
                return
            }

            self.presenter.productQuantityDidChange(cellModel, quantity: value, index: indexPath.row)
        }

        return quantityAction
    }

    private func reloadTable(indexes: [IndexPath], with animation: UITableView.RowAnimation, _ completion: ReloadCompletion) {
        basketView?.tableView.beginUpdates()
        completion?(indexes, animation)
        basketView?.tableView.endUpdates()
        setEnabledView()
    }

    private func setEnabledView() {
        guard let basket else { return }

        basketView?.placeOrderButton.isEnabled = true
        basketView?.isHiddenBottomView = basket.productsQuantity < 1
        basketView?.setupPrice(basket.amount)
    }

    @objc private func placeOrderButtonDidTap(_ sender: UIButton) {
        presenter.placeOrderButtonDidTap()
    }
}

// MARK: - BasketViewProtocol

extension BasketViewController: BasketViewProtocol {

    // MARK: - Functions
    
    func showFailure(with message: String?) {
        // TODO: call the alert display method when it's ready
        basketView?.isHiddenBottomView = basket == nil
    }

    func removeWarning() {
        // TODO: call the warning remove method when it's ready
    }

    func basketDidFetch(_ basket: BasketModel) {
        self.basket = basket
        basketView?.tableView.reloadData()
        setEnabledView()
    }

    func insertProductRows(at indexes: [IndexPath], basket: BasketModel) {
        self.basket = basket
        reloadTable(indexes: indexes, with: .automatic, basketView?.tableView.insertRows)
    }

    func updateProductRows(at indexes: [IndexPath], basket: BasketModel) {
        self.basket = basket
        reloadTable(indexes: indexes, with: .none, basketView?.tableView.reloadRows)
    }

    func deleteProductRows(at indexes: [IndexPath], basket: BasketModel) {
        self.basket = basket
        reloadTable(indexes: indexes, with: .automatic, basketView?.tableView.deleteRows)
    }

    func basketDidPay() {
        basket = nil
        basketView?.tableView.reloadData()
    }

    func setDisabledWhileSending(at index: Int?) {
        guard let index else { return }

        let cell = basketView?.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? BasketProductCell
        cell?.quantityStepper.isEnabled = false
        basketView?.placeOrderButton.isEnabled = false
    }
}

// MARK: - UITableViewDataSource

extension BasketViewController: UITableViewDataSource {

    // MARK: - Functions

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketProductCell.cellIdentifier, for: indexPath)

        guard let basketCell = cell as? BasketProductCell, let cellModels = basket?.cellModels else {
            return UITableViewCell()
        }

        basketCell.resetData()
        presenter.getImage(from: cellModels[indexPath.row].imageUrl) { image in
            basketCell.setupImage(image)
        }

        basketCell.setupData(cellModels[indexPath.row])
        basketCell.quantityStepper.stepperAction = stepperAction(indexPath: indexPath)

        return basketCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basket?.cellModels.count ?? 0
    }
}

// MARK: - UITableViewDelegate

extension BasketViewController: UITableViewDelegate {

    // MARK: - Functions

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: BasketHeaderView.reuseIdentifier)

        if let quantity = basket?.productsQuantity, quantity > 0 {
            (headerView as? BasketHeaderView)?.setupQuantity(quantity)
        } else {
            (headerView as? BasketHeaderView)?.setupEmpty()
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        ProductConstants.buttonsHeight
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerHeight = basketView?.tableView.headerView(forSection: 0)?.bounds.height else {
            return
        }

        let titleHeight = headerHeight - ProductConstants.sideIndent
        let scrollOffset = scrollView.contentOffset.y + view.safeAreaInsets.top

        if scrollOffset > titleHeight {
            setupScreenTitile()
        } else {
            setupHeaderTitle()
        }
    }
}

// MARK: - Setup titles extension

extension BasketViewController {

    // MARK: - Private functions

    private func setupTitle() {
        if navigationItem.title != nil && navigationItem.title != "" {
            setupScreenTitile()
        } else {
            setupHeaderTitle()
        }
    }

    private func setupScreenTitile() {
        guard let value = basket?.productsQuantity, value > 0 else {
            navigationItem.title = "в вашей корзине пока ничего нет ..."
            (basketView?.tableView.headerView(forSection: 0) as? BasketHeaderView)?.setupEmpty()
            return
        }

        navigationItem.title = "корзина / \(value) шт."
        (basketView?.tableView.headerView(forSection: 0) as? BasketHeaderView)?.setupQuantity(value)
    }

    private func setupHeaderTitle() {
        guard let value = basket?.productsQuantity, value > 0 else {
            (basketView?.tableView.headerView(forSection: 0) as? BasketHeaderView)?.setupEmpty()
            navigationItem.title = ""
            return
        }

        (basketView?.tableView.headerView(forSection: 0) as? BasketHeaderView)?.setupQuantity(value)
        navigationItem.title = ""
    }
}
