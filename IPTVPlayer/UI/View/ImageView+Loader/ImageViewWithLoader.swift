//
//  ImageViewWithLoader.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//
import UIKit

/// Image view with functionality to download image from network or cache
final class ImageViewWithLoader: UIImageView {
    // MARK: - Properties
    let imageCache = NSCache<AnyObject, AnyObject>()
    let activityIndicator = UIActivityIndicatorView()
    var imageURL: URL?
    
    /// Download image from url or cache if available
    /// - Parameter url: Image url
    func loadImageWithUrl(_ url: URL) {
        // Activity indicator
        activityIndicator.color = .darkGray
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        imageURL = url
        image = nil
        // If image available in cache just show it
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }
        // Download image from web
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                debugPrint(error as Any)
                DispatchQueue.main.async(execute: { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.activityIndicator.stopAnimating()
                })
                return
            }

            DispatchQueue.main.async(execute: { [weak self] in
                guard let weakSelf = self else { return }
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if weakSelf.imageURL == url {
                        weakSelf.image = imageToCache
                    }
                    // Save image to cache
                    weakSelf.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                weakSelf.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
