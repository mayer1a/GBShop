//
//  ReviewsSubmodulePresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class ReviewsSubmodulePresenter {

    // MARK: - Private roperties

    private weak var view: ReviewsViewProtocol!
    private let requestFactory: ReviewsRequestFactory
    private let productId: Int?

    // MARK: - Constructions

    init(
        view: ReviewsViewProtocol,
        requestFactory: ReviewsRequestFactory,
        coordinator: CatalogBaseCoordinator,
        productId: Int?
    ) {
        self.view = view
        self.requestFactory = requestFactory
        self.productId = productId
    }

    // MARK: - Private functions

    private func serverDidResponded(_ response: AFReviewsResult) {
        switch response.result {
        case .success(let reviewsResult):
            if reviewsResult.result == 0 {
                self.view.showFailure(with: nil)
                return
            }

            guard let reviews = reviewsResult.reviews else { return }

            let reviewsViewModel = ReviewCellModelFactory.construct(from: reviews)
            self.view.reviewsDidFetch(reviewsViewModel)
            // TODO: Save fetched result to realm
        case .failure(_):
            self.view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

    private func fetchProduct() {
        guard let productId else { return }

        requestFactory.getReviews(productId: productId, pageNumber: 0) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.serverDidResponded(response)
            }
        }
    }

}

// MARK: - Extensions

extension ReviewsSubmodulePresenter: ReviewsPresenterProtocol {

    // MARK: - Functions

    func onViewDidLoad() {
        fetchProduct()
    }

    func uploadReview(review: ReviewCellModel) {}
    func scrollWillEnd() {}
}
