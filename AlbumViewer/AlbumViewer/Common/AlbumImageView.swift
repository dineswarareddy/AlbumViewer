//
//  AlbumImageView.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import UIKit

class AlbumImageView: UIImageView {
    private let placeHolderImage = #imageLiteral(resourceName: "refresh")
    var requestedImageURLString: String?
    weak var animationLayer: CAGradientLayer?
    
    func imageFromServerURL(_ url: URL?, useCache: Bool? = true) {
        self.image = nil
        requestedImageURLString = url?.absoluteString
        guard let url = url else { return }
        
        if let cachedImage = ImageCache.getCacheImage(urlString: url.absoluteString), useCache == true {
            self.image = cachedImage
            return
        }
        addAnimationLayer()
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            self?.removeLoadingAnimation()
            if error != nil {
                DispatchQueue.main.async {
                    self?.image = self?.placeHolderImage
                }
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        if self?.requestedImageURLString == url.absoluteString {
                            self?.image = downloadedImage
                        }
                        ImageCache.storeImageToCache(urlString: url.absoluteString, imageToSave: downloadedImage)
                        return
                    }
                }
            }
        }).resume()
    }
    
    private func imageLoadingAnimation() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.lightText.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame =  self.bounds
        
        let loadingAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        loadingAnimation.duration = 1
        loadingAnimation.fromValue = -self.frame.width
        loadingAnimation.toValue = self.frame.width
        loadingAnimation.repeatCount = .infinity
        gradientLayer.add(loadingAnimation, forKey: "AnimationKey")
        return gradientLayer
    }
    
    private func addAnimationLayer() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            guard let `self` = self else { return }
            if self.animationLayer == nil {
                self.animationLayer = self.imageLoadingAnimation()
                self.layer.addSublayer(self.animationLayer!)
            }
        })
    }
    
    private func removeLoadingAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            self?.animationLayer?.removeFromSuperlayer()
            self?.animationLayer = nil
        })
    }
}
