//
//  ResponseCodableTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 16.02.2023.
//

import XCTest
import Alamofire
@testable import GBShop

// MARK: - Codable

struct PostStub: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

// MARK: - Error

enum ApiErrorStub: Error {
    case fatalError
}

// MARK: - AbstractErrorParser

struct ErrorParserStub: AbstractErrorParser {

    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }

    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }

}

// MARK: - XCTestCase

final class ResponseCodableTests: XCTestCase {

    var errorParser: ErrorParserStub!

    override func setUpWithError() throws {
        super.setUp()
        errorParser = ErrorParserStub()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        errorParser = nil
    }

    func testShouldDownloadAndParse() {
        let download = expectation(description: "Download https://jsonplaceholder.typicode.com/posts/1")
        let errorParser = ErrorParserStub()

        AF
            .request("https://jsonplaceholder.typicode.com/posts/1")
            .responseCodable(errorParser: errorParser) { (response: AFDataResponse<PostStub>) in
                switch response.result {
                case .success(_):
                    break
                case .failure:
                    XCTFail()
                }

                download.fulfill()
            }

        waitForExpectations(timeout: 10)
    }

}
