//
//  ReviewsRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 26.02.2023.
//

import Alamofire

/// Server request factory contract for reviews actions
protocol ReviewsRequestFactory {

    // MARK: - Functions

    /// Get a list of reviews for a specific product
    /// - Parameters:
    ///   - productId: ID of the product to get reviews for.
    ///   - pageNumber: The page number of the review list for pagination.
    ///   - completionHandler: Received response from the server.
    func getReviews(
        productId: Int,
        pageNumber: Int,
        completionHandler: @escaping (AFDataResponse<ReviewsResult>) -> Void)


    /// You can add a review to a specific product openly or anonymously.
    /// - Parameters:
    ///   - userId: If you need to add a review not anonymously, otherwise nil.
    ///   - productId: ID of the product to get reviews for.
    ///   - description: Feedback text.
    ///   - completionHandler: Received response from the server.
    func addReview(
        userId: Int?,
        productId: Int,
        description: String,
        completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void)

    /// Only an administrator with rights can confirm the review.
    /// - Parameters:
    ///   - userId: ID of the user who checks the review (must be an administrator).
    ///   - reviewId: Review ID for admin confirmation.
    ///   - completionHandler: Received response from the server.
    func approveReview(
        userId: Int,
        reviewId: Int,
        completionHandler: @escaping (AFDataResponse<ApproveReviewResult>) -> Void)

    /// A review can be deleted by either the reviewer or an administrator.
    /// - Parameters:
    ///   - userId: Review owner or administrator ID.
    ///   - reviewId: The review ID to delete.
    ///   - completionHandler: Received response from the server.
    func removeReview(
        userId: Int,
        reviewId: Int,
        completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void)
}
