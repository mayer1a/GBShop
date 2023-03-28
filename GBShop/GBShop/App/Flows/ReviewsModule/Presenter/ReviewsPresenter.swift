//
//  ReviewsPresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

protocol ReviewsViewProtocol: AnyObject {
    func showFailure(with message: String?)
    func removeWarning()
    func reviewsDidFetch(_ reviews: [ReviewCellModel])
}

protocol ReviewsPresenterProtocol: AnyObject {
    init(
        view: ReviewsViewProtocol,
        requestFactory: ReviewsRequestFactory,
        coordinator: CatalogBaseCoordinator,
        productId: Int)

    func onViewDidLoad()
    func uploadReview(review: ReviewCellModel)
    func scrollWillEnd()
}

// MARK: - ReviewsPresenter

final class ReviewsPresenter {

    // MARK: - Private roperties

    private weak var view: ReviewsViewProtocol!
    private let coordinator: CatalogBaseCoordinator
    private let requestFactory: ReviewsRequestFactory
    private var nextPage: Int?
    private let productId: Int

    // MARK: - Constructions

    init(
        view: ReviewsViewProtocol,
        requestFactory: ReviewsRequestFactory,
        coordinator: CatalogBaseCoordinator,
        productId: Int
    ) {
        self.view = view
        self.requestFactory = requestFactory
        self.coordinator = coordinator
        self.productId = productId
        nextPage = 1
    }

    // MARK: - Private functions

    private func serverDidResponded(_ response: AFReviewsResult) {
        switch response.result {
        case .success(let reviewsResult):
            if reviewsResult.result == 0 {
                self.view.showFailure(with: nil)
                return
            }

            nextPage = reviewsResult.nextPage

            guard let reviews = reviewsResult.reviews else { return }

            let reviewsViewModel = ReviewCellModelFactory.construct(from: reviews)
            self.view.reviewsDidFetch(reviewsViewModel)
            // TODO: Save fetched result to realm
        case .failure(_):
            self.view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

    private func fetchProduct(for pageNumber: Int?) {
        guard let pageNumber else { return }

        requestFactory.getReviews(productId: productId, pageNumber: pageNumber) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.serverDidResponded(response)
            }
        }
    }
}

// MARK: - Extensions

extension ReviewsPresenter: ReviewsPresenterProtocol {

    // MARK: - Functions

    func onViewDidLoad() {
        fetchProduct(for: nextPage)
    }

    func uploadReview(review: ReviewCellModel) {
        // TODO: send review to the server when it's ready
    }

    func scrollWillEnd() {
        fetchProduct(for: nextPage)
    }
}
