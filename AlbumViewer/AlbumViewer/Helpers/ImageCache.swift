//
//  ImageCache.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation
import UIKit

class ImageCache {
    private struct Constants {
        static let imageCacheKey = "ImageCache"
    }
    
    class func storeImageToCache(urlString: String, imageToSave: UIImage) {
        let path = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString)")
        let filePathUrl = path
        let imageData = imageToSave.pngData()
        try? imageData?.write(to: filePathUrl)
        if let pathComponent = path.pathComponents.last {
            saveImagePathToUserDefaults(imagePathComponent: pathComponent, imageURL: urlString)
        }
    }
    
    class func getCacheImage(urlString: String) -> UIImage? {
        if let imageDict = UserDefaults.standard.dictionary(forKey: Constants.imageCacheKey) as? [String: String] {
            if let imagePath = imageDict[urlString] {
                let path = FileManager.default.temporaryDirectory.appendingPathComponent("\(imagePath)")
                if let imageData = try? Data(contentsOf: path) {
                    let imageToDisplay = UIImage(data: imageData)
                    return imageToDisplay
                }
            }
        }
        return nil
    }
    
    private class func saveImagePathToUserDefaults(imagePathComponent: String, imageURL: String) {
        var imageDict = UserDefaults.standard.object(forKey: Constants.imageCacheKey) as? [String: String]
        if imageDict == nil {
            imageDict = [String : String]()
        }
        imageDict?[imageURL] = imagePathComponent
        UserDefaults.standard.setValue(imageDict, forKey: Constants.imageCacheKey)
    }
}
