//
//  ImageDownloader.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import Foundation
import Alamofire

/// Obliges to implement two methods of loading an image by link and a collection of links and pass the result to the closure
protocol ImageDownloaderProtocol: AnyObject {

    /// Allows you to download images from a link passed to a parameter using alamofire on a global stream
    ///  and passes the result to a closure of type ``URLConvertible``
    ///
    /// - Parameters:
    ///   - url: Link to images in a format that implements protocol ``URLConvertible``
    ///   - completion: Received response from the server.
    func getImage(fromUrl url: URLConvertible, completion: @escaping DownloadImageCompletion)

    /// Allows you to download images from a links passed to a parameter using alamofire on a global stream
    /// and passes the result to a closure of type ``URLConvertible``
    ///
    /// - Parameters:
    ///   - urls: Collection of links to images in the format that implements protocol ``URLConvertible``
    ///   - completion: Received response from the server.
    func getImages(from urls: [URLConvertible], completion: @escaping DownloadImagesCompletion)
}

final class ImageDownloader: ImageDownloaderProtocol {

    // MARK: - Private properties

    private let dispatchGroup = DispatchGroup()

    // MARK: - Functions

    func getImage(fromUrl url: URLConvertible, completion: @escaping DownloadImageCompletion) {
        AF.request(url).response(queue: .global()) { (dataResponse) in
            if let error = dataResponse.error {
                completion(nil, .afError(error.localizedDescription))
                return
            }

            guard let imageData = dataResponse.data else {
                completion(nil, .remoteServerError)
                return
            }

            guard let image = UIImage(data: imageData) else {
                completion(nil, .dataConvertingError)
                return
            }
            
            DispatchQueue.main.async {
                completion(image, nil)
            }
        }
    }

    func getImages(from urls: [URLConvertible], completion: @escaping DownloadImagesCompletion) {
        DispatchQueue.global().sync { [weak self] in
            var images: [UIImage?] = []

            urls.forEach {
                self?.dispatchGroup.enter()

                self?.getImage(fromUrl: $0) { (image, error) in
                    images.append(image)
                    self?.dispatchGroup.leave()
                }
            }

            self?.dispatchGroup.notify(queue: .main) {
                completion(images, nil)
            }
        }
    }
}

// MARK: - Extensions

extension ImageDownloader {

    /// Enumeration model of possible downloader errors with localization of description
    enum DownloadingError: Error, Equatable {
        case afError(String)
        case remoteServerError
        case dataConvertingError
        case unknown

        var localizedDescription: String {
            switch self {
            case .afError(let errorMessage):
                return errorMessage
            case .remoteServerError:
                return "Ошибка сервера. Данные не были получены."
            case .dataConvertingError:
                return "Ошибка конвертирования данных."
            default:
                return ErrorConstants.unknownErrorMessage
            }
        }

    }
}
