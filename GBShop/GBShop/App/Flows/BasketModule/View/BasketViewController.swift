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
    private var basket: BasketModel?

    // MARK: - Lifecycle

    override func loadView() {
        view = BasketView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
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

    private func setupTargets() {
        basketView?.tableView.delegate = self
        basketView?.tableView.dataSource = self
        basketView?.placeOrderButton.addTarget(self, action: #selector(placeOrderButtonDidTap), for: .touchUpInside)
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
    }

    func removeWarning() {
        // TODO: call the warning remove method when it's ready
    }

    func basketDidFetch(_ basket: BasketModel) {
        self.basket = basket
        basketView?.tableView.reloadData()
    }

    func insertProductRows(at indexes: [Int], basket: BasketModel) {
        self.basket = basket
        let indexPath = indexes.compactMap { index -> IndexPath in IndexPath(row: index, section: 0) }
        basketView?.tableView.beginUpdates()
        basketView?.tableView.insertRows(at: indexPath, with: .automatic)
        basketView?.tableView.endUpdates()
    }

    func updateProductRows(at indexes: [Int], basket: BasketModel) {
        self.basket = basket
        let indexPath = indexes.compactMap { index -> IndexPath in IndexPath(row: index, section: 0) }
        basketView?.tableView.beginUpdates()
        basketView?.tableView.reloadRows(at: indexPath, with: .automatic)
        basketView?.tableView.endUpdates()
    }

    func deleteProductRows(at indexes: [Int], basket: BasketModel) {
        self.basket = basket
        let indexPath = indexes.compactMap { index -> IndexPath in IndexPath(row: index, section: 0) }
        basketView?.tableView.beginUpdates()
        basketView?.tableView.deleteRows(at: indexPath, with: .automatic)
        basketView?.tableView.endUpdates()
    }

    func basketDidPay() {
        basket = nil
        basketView?.tableView.reloadData()
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

        basketCell.setupData(cellModels[indexPath.row])

        return basketCell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
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

        guard let basketHeaderView = headerView as? BasketHeaderView, let quantity = basket?.productsQuantity else {
            return nil
        }

        basketHeaderView.setupQuantity(quantity)

        return basketHeaderView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        ProductConstants.buttonsHeight
    }
}
