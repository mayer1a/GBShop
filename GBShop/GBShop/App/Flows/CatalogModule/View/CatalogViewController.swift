//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 25.03.2023.
//

import UIKit

final class CatalogViewController: UIViewController {

    // MARK: - Private properties

    private var presenter: CatalogPresenterProtocol!
    private var catalogView: CatalogView? {
        isViewLoaded ? view as? CatalogView : nil
    }

    private var products: [Product] = []
    private var productsIsLoading: Bool = false

    // MARK: - Lifecycle

    override func loadView() {
        view = CatalogView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
        presenter.onViewDidLoad()
    }

    // MARK: - Functions

    func setPresenter(_ presenter: CatalogPresenterProtocol) {
        self.presenter = presenter
    }

    // MARK: - Private functions

    private func setupTargets() {
        catalogView?.collectionView.delegate = self
        catalogView?.collectionView.dataSource = self
        catalogView?.collectionView.prefetchDataSource = self
    }

    private func basketAction(indexPath: IndexPath) -> ((Any) -> Void)? {
        buttonAction = { [weak self] _ in
            guard let self else { return }
            self.presenter.addToBasket(self.products[indexPath.item])
        }
        return buttonAction
    }

    private func favoriteAction(indexPath: IndexPath) -> ((Any) -> Void)? {
        buttonAction = { [weak self] _ in
            guard let self else { return }
            self.presenter.addToFavorite(self.products[indexPath.item])
        }
        return buttonAction
    }

    private var buttonAction: ((Any) -> Void)?
}

// MARK: - CatalogViewProtocol

extension CatalogViewController: CatalogViewProtocol {

    // MARK: - Functions

    func catalogPageDidFetch(_ products: [Product]) {
        let firstInsertIndex = self.products.count == 0 ? 0 : self.products.count - 1
        let lastInsertIndex = firstInsertIndex + (products.count - 1)

        self.products.append(contentsOf: products)

        let indexPaths = (firstInsertIndex...lastInsertIndex).map { index -> IndexPath in
            IndexPath(item: index, section: 0)
        }

        catalogView?.collectionView.performBatchUpdates {
            catalogView?.collectionView.insertItems(at: indexPaths)
        }

        productsIsLoading = false
    }

    func startLoadingSpinner() {
        // TODO: call the alert display method when it's ready
    }

    func stopLoadingSpinner() {
        // TODO: call the warning remove method when it's ready
    }

    func showFailure(with message: String?) {
        // TODO: call the alert display method when it's ready
    }

    func removeWarning() {
        // TODO: call the warning remove method when it's ready
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension CatalogViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Functions

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = ProductCellModelFactory.construct(from: products[indexPath.item])
        let cell = CollectionViewCellFactory.createCell(for: collectionView, indexPath: indexPath)
        cell.setupData(cellModel)
        presenter.getImage(from: cellModel.imageUrl) { image in
            cell.setupImage(image)
        }
        cell.basketButtonAction = basketAction(indexPath: indexPath)
        cell.favoriteButtonAction = favoriteAction(indexPath: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showProductDetail(for: products[indexPath.item])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CatalogViewController: UICollectionViewDelegateFlowLayout {

    // MARK: - Functions

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }

        let minimumSpacing = layout.minimumInteritemSpacing
        let screenWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
        let photosPerRow: CGFloat = 2
        let cellWidth = (screenWidth - minimumSpacing) / photosPerRow
        let cellHeight = cellWidth * 2

        return CGSize(width: cellWidth, height: cellHeight)
    }
}

// MARK: - UICollectionViewDataSourcePrefetching

extension CatalogViewController: UICollectionViewDataSourcePrefetching {

    // MARK: - Functions

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        DispatchQueue.global().async { [weak self] in
            guard
                let self,
                let maxRowToEnd = indexPaths.map({ $0.item }).max(),
                maxRowToEnd > self.products.count - 6
            else {
                return
            }

            self.presenter.scrollWillEnd()
        }
    }
}
