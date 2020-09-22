//
//  PhotosListRouter.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import Foundation
import UIKit


protocol PhotosListRouterDelegate {
    func passDataToNextScene(segue: UIStoryboardSegue?, dataToPass: Any?)
}

class PhotosListRouter
{
    // MARK: - Life cycle
    
    public init() { }
}

// MARK: - Router Interface

extension PhotosListRouter: PhotosListRouterDelegate
{
    func passDataToNextScene(segue: UIStoryboardSegue?, dataToPass: Any?) {
        // NOTE: Teach the router which scenes it can communicate with
        if let photoPreviewView = segue?.destination as? PhotoPreviewViewController, let selectedPhoto = dataToPass as? Photo {
            photoPreviewView.photoToPreview = selectedPhoto
        }
    }
}
