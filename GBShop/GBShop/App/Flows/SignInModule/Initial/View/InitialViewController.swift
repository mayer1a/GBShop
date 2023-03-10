//
//  InitialViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import UIKit

final class InitialViewController: UIViewController {

    // MARK: - Private properties

    private var presenter: InitialPresenterProtocol!
    private let logoImage: UIImageView
    private let loadingSpinner: UIActivityIndicatorView
    private let imageSize: CGFloat

    // MARK: - Constructions

    required init() {
        logoImage = UIImageView()
        loadingSpinner = UIActivityIndicatorView(style: .large)
        imageSize = 64.0

        super.init(nibName: nil, bundle: nil)
        configureViewComponents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewWillAppear()
    }

    // MARK: - Functions

    func setPresenter(presenter: InitialPresenterProtocol) {
        self.presenter = presenter
    }

    // MARK: - Private functions

    private func configureViewComponents() {
        view.backgroundColor = .systemBackground
        view.addSubview(logoImage)
        view.addSubview(loadingSpinner)

        configureLogo()
        configureSpinner()
    }

    private func configureLogo() {
        logoImage.backgroundColor = .systemBackground
        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImage.widthAnchor.constraint(equalToConstant: imageSize),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
            logoImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    private func configureSpinner() {
        loadingSpinner.hidesWhenStopped = true
        loadingSpinner.color = .label
        loadingSpinner.tintColor = .label
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loadingSpinner.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20),
            loadingSpinner.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - Extension

extension InitialViewController: InitialViewProtocol {

    // MARK: - Properties

    var initialNavigationController: UINavigationController? {
        return navigationController
    }

    // MARK: - Functions

    func showLoadingSpinner() {
        loadingSpinner.startAnimating()
    }

    func hideLoadingSpinner() {
        loadingSpinner.stopAnimating()
    }
}
