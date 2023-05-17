//
//  ReviewsViewCell.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class ReviewsViewCell: UITableViewCell {

    // MARK: - Properties

    static let cellIdentifier = "ReviewsCell"

    // MARK: - Private properties

    private var avatar = UIImageView()
    private var starsStackView = UIStackView()
    private var userLabel = UILabel()
    private var dateLabel = UILabel()
    private var reviewBodyLabel = UILabel()

    // MARK: - Constructions

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViewComponents()
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        reviewBodyLabel.text = nil
        userLabel.text = nil
        dateLabel.text = nil
        fillStars(for: 0)
    }

    // MARK: - Functions

    func setupData(_ reviewModel: ReviewCellModel) {
        userLabel.text = reviewModel.userId
        dateLabel.text = reviewModel.date
        reviewBodyLabel.text = reviewModel.body
        fillStars(for: reviewModel.reviewStars)
    }

    // MARK: - Private functions

    private func configureViewComponents() {
        selectionStyle = .none

        configureAvatarView()
        configureUserLabel()
        configureDateLabel()
        configureStarsView()
        configureBodyLabel()
    }

    private func configureAvatarView() {
        contentView.addSubview(avatar)

        avatar.backgroundColor = .lightGray
        avatar.tintColor = .white
        avatar.image = .init(systemName: "person.fill")
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.borderWidth = ReviewsConstants.avatarBorderWidth
        avatar.layer.cornerRadius =  ReviewsConstants.avatarHeight / 2
        avatar.layer.masksToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: ProductConstants.sideIndent),
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ProductConstants.interitemSpacing),
            avatar.heightAnchor.constraint(equalToConstant: ReviewsConstants.avatarHeight),
            avatar.widthAnchor.constraint(equalTo: avatar.heightAnchor)
        ])
    }

    private func configureUserLabel() {
        contentView.addSubview(userLabel)

        userLabel.lineBreakMode = .byTruncatingTail
        setupLabel(userLabel, weight: .semibold, textColor: .black, lines: 1)

        NSLayoutConstraint.activate([
            userLabel.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: ProductConstants.sideIndent),
            userLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -ProductConstants.sideIndent),
            userLabel.bottomAnchor.constraint(equalTo: avatar.centerYAnchor, constant: -ReviewsConstants.userDateIndent)
        ])
    }

    private func configureDateLabel() {
        contentView.addSubview(dateLabel)

        dateLabel.lineBreakMode = .byTruncatingTail
        setupLabel(dateLabel, weight: .regular, textColor: .gray, lines: 1)

        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: ProductConstants.sideIndent),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -ProductConstants.sideIndent),
            dateLabel.topAnchor.constraint(equalTo: avatar.centerYAnchor, constant: ReviewsConstants.userDateIndent)
        ])
    }

    private func configureStarsView() {
        contentView.addSubview(starsStackView)
        addStarsImageView()

        starsStackView.contentMode = .center
        starsStackView.backgroundColor = .white
        starsStackView.alignment = .center
        starsStackView.distribution = .equalSpacing
        starsStackView.axis = .horizontal
        starsStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            starsStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: ProductConstants.sideIndent),
            starsStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: ProductConstants.sideIndent)
        ])
    }

    private func addStarsImageView() {
        (0..<ReviewsConstants.reviewStarsNumber).forEach { index in
            let starView = UIImageView(image: .init(systemName: "star.fill"))
            starView.tintColor = .lightGray
            starView.backgroundColor = .white

            starsStackView.addArrangedSubview(starView)
        }
    }

    private func configureBodyLabel() {
        contentView.addSubview(reviewBodyLabel)

        reviewBodyLabel.lineBreakMode = .byWordWrapping
        setupLabel(reviewBodyLabel, weight: .regular, textColor: .black, lines: 0)

        NSLayoutConstraint.activate([
            reviewBodyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: ProductConstants.sideIndent),
            reviewBodyLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -ProductConstants.sideIndent),
            reviewBodyLabel.topAnchor.constraint(equalTo: starsStackView.bottomAnchor, constant: ProductConstants.sideIndent),
            reviewBodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ProductConstants.sideIndent)
        ])
    }

    private func setupLabel(_ label: UILabel, weight: UIFont.Weight, textColor: UIColor, lines: Int) {
        label.font = .systemFont(ofSize: 16.0, weight: weight)
        label.backgroundColor = .white
        label.textColor = textColor
        label.numberOfLines = lines
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    private func fillStars(for starsNumber: Int) {
        starsStackView.arrangedSubviews.enumerated().forEach { (index, star) in
            if index < starsNumber {
                star.tintColor = .orange
            } else {
                star.tintColor = .lightGray
            }
        }
    }
}
