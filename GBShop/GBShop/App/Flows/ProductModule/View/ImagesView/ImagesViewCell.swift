//
//  ImagesViewCell.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class ImagesViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let cellIdentifier = "ImageCell"

    // MARK: - Private properties

    private(set) var imageView = UIImageView()

    // MARK: - Constructions

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureComponents()
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        imageView.image = nil
    }

    // MARK: - Functions

    func setupData(_ image: UIImage?) {
        imageView.image = image
    }

    // MARK: - Private functions

    private func configureComponents() {
        contentView.addSubview(imageView)

        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
