//
//  AlbumPhotosPresenter.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import Foundation

class PhotosListPresenter {
    let noPhotosMessage = "No photos under this album"
    var view: PhotosListPresenterOutput?
//    var router: PhotosListRouterDelegate?
    
    init(view: PhotosListPresenterOutput?) {
        self.view = view
//        self.router = AlbumListRouter()
    }
}

extension PhotosListPresenter: PhotosListInteractorOutput {
    func showActivityIndicator() {
        view?.displaActivityIndicator()
    }
    
    func hideActivityIndicator() {
        view?.removeActivityIndicator()
    }
    
    func updatePhotosList(photos: [Photo]) {
        if photos.isEmpty == true {
            view?.displayNoPhotosMessage(noPhotosMessage)
        } else {
            view?.removeNoPhotosMessageLabel()
        }
        view?.displayPhotos(photos: photos)
    }
    
    func updateError(error: Error) {
        // Handle error here and pass error based message to view
        view?.displayError(message: error.localizedDescription)
    }
}
