//
//  AlbumPhotosPresenter.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import Foundation

class PhotosListPresenter {
    var view: PhotosListPresenterOutput?
//    var router: PhotosListRouterDelegate?
    
    init(view: PhotosListPresenterOutput?) {
        self.view = view
//        self.router = AlbumListRouter()
    }
}

extension PhotosListPresenter: PhotosListInteractorOutput {
    func updatePhotosList(photos: [Photo]?) {
        if let photos = photos {
            view?.displayPhotos(photos: photos)
        }
    }
    
    func updateError(error: Error) {
        // Handle error here and pass error based message to view
        view?.displayError(message: error.localizedDescription)
    }
}
