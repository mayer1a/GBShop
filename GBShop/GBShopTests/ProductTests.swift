//
//  GettingProductTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 16.02.2023.
//

import XCTest
@testable import GBShop

final class ProductTests: XCTestCase {

    // MARK: - Properties

    var requestFactory: RequestFactory!

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }

    // MARK: - Functions

    func testGetProductCorrectInput() {
        let product = requestFactory.makeProductRequestFactory()
        let exp = expectation(description: "correctInput")
        let productId = 23019
        var productResult: ProductResult? = nil

        product.getProduct(productId: productId) { response in
            switch response.result {
            case .success(let response):
                productResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        let expectedImages = [
            "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17618_1675935990.webp",
            "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17618_1675935989.webp"
        ]

        XCTAssertEqual(productResult?.result, 1)
        XCTAssertEqual(productResult?.product?.description, productDescription)
        XCTAssertEqual(productResult?.product?.images, expectedImages)
    }

    func testGetProductIncorrectProductId() {
        let product = requestFactory.makeProductRequestFactory()
        let exp = expectation(description: "incorrectProductId")
        let productId = 1
        var productResult: ProductResult? = nil

        product.getProduct(productId: productId) { response in
            switch response.result {
            case .success(let response):
                productResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(productResult?.result, 0)
        XCTAssertNil(productResult?.product)
        XCTAssertEqual(productResult?.errorMessage, "Товар не найден. Неверный id!")
    }
}

let productDescription = """
    Сухой корм для кошек с проблемной кожей и шерстью или склонных к аллергии

    Достоинства:
    • профилактика мочекаменной болезни
    • обеспечение отличного состояния кожного покрова и шерсти
    • противодействие возникновению аллергических реакций
    • препятствие старению клеток
    • усиление естественной защиты животного
    • забота об физическом самочувствии

    Состав:
    Дегидрированное мясо трески, Дегидрированное мясо сельди, Цельный бурый рис, Дегидрированное мясо индейки, Свежее мясо индейки, Жир индейки, Антарктический Криль (естественный источник EPA и DHA), Сушеный цикорий, (естественный источник FOS и инулина), Сушеное яблоко, Пивные дрожжи (естественный источник MOS), Сушеная морковь, Сушеный шпинат, Семена льна, Таурин, Сушеная клюква, Юкка Шидигера. Сохранено витамином С, розмарином и смесью природных токоферолов.

    Пищевая ценность %:
    Протеин: 33,0; Жир:16,0; Omega-6: 3,5; Omega-3: 0,8; Зола: 7,5; Клетчатка: 2,5; Влажность: 6,0; Кальций (Са): 1,2; Фосфор (P): 1,0; Магний (Mg): 0,09; pH: 6-6,5

    Витамины (мг/кг):
    Витамин A (МЕ/кг): 20.000; Витамин D3 (МЕ/кг): 1.500; Витамин E (a-токоферол): 600; Витамин В1: 10.0; B2:8.0; B6: 8.0; B12: 180.0; Пантотеновая кислота: 50.0; Холин: 1250.0; Фолиевая кислота: 4,0; Биотин (мкг/кг): 250,0; Никотиновая кислота: 180,0
    """
