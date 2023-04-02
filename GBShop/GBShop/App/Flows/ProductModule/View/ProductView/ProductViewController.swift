//
//  ProductViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class ProductViewController: UIViewController {

    // MARK: - Private properties

    private var presenter: ProductPresenterProtocol!
    private var productView: ProductView? {
        isViewLoaded ? view as? ProductView : nil
    }

    private(set) lazy var throbberViewController: ThrobberViewController? = ThrobberViewController()
    private(set) lazy var headerViewController = HeaderViewController()
    private(set) lazy var imagesViewController = ImagesViewController()
    private(set) lazy var descriptionViewController = DescriptionViewController()
    private(set) lazy var buttonsViewController = ButtonsViewController()
    private(set) var reviewsViewController: UIViewController?
    private(set) var screenTitle: String?

    // MARK: - Lifecycle

    override func loadView() {
        view = ProductView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewComponents()
        presenter.onViewDidLoad()
    }

    // MARK: - Functions

    func setPresenter(_ presenter: ProductPresenterProtocol) {
        self.presenter = presenter
    }

    func setReviewsController(_ reviewsViewController: UIViewController) {
        self.reviewsViewController = reviewsViewController
    }

    // MARK: - Private Functions

    private func setupViewComponents() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = ""

        addThrobberViewController()
        addHeaderViewController()
        addImagesViewController()
        addDescriptionViewController()
        addButtonsViewController()
        addReviewViewController()
    }

    private func addThrobberViewController() {
        guard let throbberViewController else { return }

        addChild(throbberViewController)
        view.addSubview(throbberViewController.view)
        throbberViewController.didMove(toParent: self)
        throbberViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            throbberViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            throbberViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            throbberViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            throbberViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func addHeaderViewController() {
        guard let productView else { return }

        productView.scrollView.delegate = self

        addChild(headerViewController)
        productView.contentView.addSubview(headerViewController.view)
        headerViewController.didMove(toParent: self)
        headerViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerViewController.view.topAnchor.constraint(equalTo: productView.contentView.topAnchor),
            headerViewController.view.leftAnchor.constraint(equalTo: productView.contentView.leftAnchor),
            headerViewController.view.rightAnchor.constraint(equalTo: productView.contentView.rightAnchor)
        ])
    }

    private func addImagesViewController() {
        guard let productView else { return }

        addChild(imagesViewController)
        productView.contentView.addSubview(imagesViewController.view)
        imagesViewController.didMove(toParent: self)
        imagesViewController.view.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            imagesViewController.view.topAnchor.constraint(equalTo: headerViewController.view.bottomAnchor),
            imagesViewController.view.leftAnchor.constraint(equalTo: productView.contentView.leftAnchor),
            imagesViewController.view.rightAnchor.constraint(equalTo: productView.contentView.rightAnchor),
            imagesViewController.view.heightAnchor.constraint(
                equalTo: imagesViewController.imagesView!.collectionView.widthAnchor,
                multiplier: ProductConstants.collectionHeightMultiplier)
        ])
    }

    private func addDescriptionViewController() {
        guard let productView else { return }

        addChild(descriptionViewController)
        productView.contentView.addSubview(descriptionViewController.view)
        descriptionViewController.didMove(toParent: self)
        descriptionViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            descriptionViewController.view.topAnchor.constraint(equalTo: imagesViewController.view.bottomAnchor),
            descriptionViewController.view.leftAnchor.constraint(equalTo: productView.contentView.leftAnchor),
            descriptionViewController.view.rightAnchor.constraint(equalTo: productView.contentView.rightAnchor)
        ])
    }

    private func addButtonsViewController() {
        guard let productView else { return }

        addChild(buttonsViewController)
        productView.mainView.addSubview(buttonsViewController.view)
        buttonsViewController.didMove(toParent: self)
        buttonsViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonsViewController.view.topAnchor.constraint(equalTo: productView.scrollView.bottomAnchor),
            buttonsViewController.view.bottomAnchor.constraint(equalTo: productView.mainView.bottomAnchor),
            buttonsViewController.view.leftAnchor.constraint(equalTo: productView.mainView.leftAnchor),
            buttonsViewController.view.rightAnchor.constraint(equalTo: productView.mainView.rightAnchor)
        ])
    }

    private func addReviewViewController() {
        guard let reviewsViewController, let productView else { return }

        addChild(reviewsViewController)
        productView.contentView.addSubview(reviewsViewController.view)
        reviewsViewController.didMove(toParent: self)
        reviewsViewController.view.translatesAutoresizingMaskIntoConstraints = false

        productView.showReviewsButton.addTarget(self, action: #selector(showAllButtonDidTap), for: .touchUpInside)
        productView.addReviewButton.addTarget(self, action: #selector(addReviewButtonDidTap), for: .touchUpInside)

        NSLayoutConstraint.activate([
            reviewsViewController.view.topAnchor.constraint(equalTo: descriptionViewController.view.bottomAnchor),
            reviewsViewController.view.bottomAnchor.constraint(equalTo: productView.addReviewButton.topAnchor),
            reviewsViewController.view.leftAnchor.constraint(equalTo: productView.contentView.leftAnchor),
            reviewsViewController.view.rightAnchor.constraint(equalTo: productView.contentView.rightAnchor)
        ])
    }

    @objc private func showAllButtonDidTap() {
        presenter.showAllReviews()
    }

    @objc private func addReviewButtonDidTap() {
        presenter.addReviewButtonDidTap()
    }
}

// MARK: - ProductButtonsParentProtocol

extension ProductViewController: ProductButtonsParentProtocol {

    // MARK: - Functions

    func basketButtonDidTap() {
        presenter.addToBasket()
    }

    func favoriteButtonDidTap() {
        presenter.addToFavorite()
    }
}

// MARK: - ProductViewProtocol

extension ProductViewController: ProductViewProtocol {

    // MARK: - Functions

    func showFailure(with message: String?) {
        // TODO: warning label will shown when label is ready
    }

    func removeWarning() {
        // TODO: warning label will hidden when label is ready
    }

    func productDidFetch(_ product: ProductViewModel) {
        headerViewController.setupData(product)
        descriptionViewController.setupData(product)
        screenTitle = product.name
    }

    func imagesDidFetch(_ images: [UIImage?]) {
        imagesViewController.setupData(images)

        throbberViewController?.willMove(toParent: nil)
        throbberViewController?.removeFromParent()
        throbberViewController?.view.removeFromSuperview()
        throbberViewController = nil
    }
}

// MARK: - UIScrollViewDelegate

extension ProductViewController: UIScrollViewDelegate {

    // MARK: - Functions

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let titleHeight = headerViewController.view.bounds.height - ProductConstants.sideIndent
        let scrollOffset = scrollView.contentOffset.y + productView!.safeAreaInsets.top

        guard scrollOffset > titleHeight else {
            navigationItem.title = ""
            return
        }

        navigationItem.title = screenTitle
    }
}
