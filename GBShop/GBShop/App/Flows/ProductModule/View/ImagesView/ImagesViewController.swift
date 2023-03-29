//
//  ImagesViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class ImagesViewController: UIViewController {

    // MARK: - Properties

    var imagesView: ImagesView? {
        isViewLoaded ? view as? ImagesView : nil
    }

    // MARK: - Private properties

    private var images: [UIImage?] = [] {
        didSet {
            imagesView?.collectionView.reloadData()
        }
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = ImagesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imagesView?.collectionView.delegate = self
        imagesView?.collectionView.dataSource = self
    }

    // MARK: - Functions

    func setupData(_ images: [UIImage?]) {
        self.images = images
    }

}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension ImagesViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Functions

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesViewCell.cellIdentifier, for: indexPath)

        guard let cell = cell as? ImagesViewCell else { return UICollectionViewCell() }

        cell.setupData(images[indexPath.item])

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ImagesViewController: UICollectionViewDelegateFlowLayout {

    // MARK: - Functions

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let cellWidth = collectionView.frame.width
        let cellHeight = cellWidth * ProductConstants.cellHeightMultiplier

        return CGSize(width: cellWidth, height: cellHeight)
    }
}
