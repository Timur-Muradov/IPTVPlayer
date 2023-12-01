//
//  ImageViewWithLoader.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//
import UIKit

final class ImageViewWithLoader: UIImageView {
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    var imageURL: URL?
    let activityIndicator = UIActivityIndicatorView()

    func loadImageWithUrl(_ url: URL) {
        activityIndicator.color = .darkGray

        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageURL = url

        image = nil
        activityIndicator.startAnimating()
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error as Any)
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
                return
            }

            DispatchQueue.main.async(execute: { [weak self] in
                guard let weakSelf = self else { return }
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if weakSelf.imageURL == url {
                        weakSelf.image = imageToCache
                    }

                    weakSelf.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                weakSelf.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
