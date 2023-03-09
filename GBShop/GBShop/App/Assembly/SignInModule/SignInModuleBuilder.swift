//
//  SignInModuleBuilder.swift
//  GBShop
//
//  Created by Artem Mayer on 09.03.2023.
//

import UIKit

protocol ModuleBuilderProtocol {
    static func createSignInModule() -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {

    // MARK: - Functions
    
    static func createSignInModule() -> UIViewController {
        let signInView = SignInViewController()
        let signInReq = RequestFactory().makeSignInRequestFatory()
        let presenter = SignInPresenter(view: signInView, requestFactory: signInReq)
        signInView.presenter = presenter

        return signInView
    }
}
