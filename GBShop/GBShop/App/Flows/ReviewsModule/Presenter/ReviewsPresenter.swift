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
    func setupAddReviewButton()
}

protocol ReviewsPresenterProtocol: AnyObject {
    init(
        view: ReviewsViewProtocol,
        requestFactory: ReviewsRequestFactory,
        coordinator: CatalogBaseCoordinator,
        productId: Int?)

    func onViewDidLoad()
    func uploadReview(review: ReviewCellModel)
    func scrollWillEnd()
    func addReviewButtonDidTap()
}

// MARK: - ReviewsPresenter

final class ReviewsPresenter {

    // MARK: - Private roperties

    private weak var view: ReviewsViewProtocol!
    private let coordinator: CatalogBaseCoordinator
    private let requestFactory: ReviewsRequestFactory
    private var analyticsManager: AnalyticsManagerInterface!
    private var nextPage: Int?
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
        self.coordinator = coordinator
        self.productId = productId
        nextPage = 1
    }

    // MARK: - Functions

    func setupServices(analyticsManager: AnalyticsManagerInterface) {
        self.analyticsManager = analyticsManager
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
        guard let pageNumber, let productId else { return }

        requestFactory.getReviews(productId: productId, pageNumber: pageNumber) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.nextPage = nil
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
        view.setupAddReviewButton()
    }

    func uploadReview(review: ReviewCellModel) {
        // TODO: send review to the server when it's ready
    }

    func scrollWillEnd() {
        fetchProduct(for: nextPage)
    }

    func addReviewButtonDidTap() {
        // TODO: call coordinator moveTo method, on add review screen will call analyticsManager.log
    }
}
