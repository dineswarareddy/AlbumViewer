//
//  AlbumPhotosInteractor.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import Foundation
import UIKit

class PhotosListInteractor {
    
    let output: PhotosListInteractorOutput
    let network: AlbumsNetworkDelegate?
    var photosArray: [Photo]? = []
    
    init(presenter: PhotosListInteractorOutput, networkController: AlbumsNetworkDelegate?) {
        self.output = presenter
        self.network = networkController
    }
    
    private func updatePhotosListToPresent(photosList: [Photo]?) {
        if let photos = photosList {
            self.output.updatePhotosList(photos: photos)
        }
    }
}

extension PhotosListInteractor: PhotosListInteractorInput {
    func fetchPhots(of album: Album) {
        output.showActivityIndicator()
        network?.fetchPhotos(of: album.id, completionHandler: { [weak self] (photos, error) -> (Void) in
            self?.output.hideActivityIndicator()
            guard let error = error else {
                self?.updatePhotosListToPresent(photosList: photos)
                return
            }
            self?.output.updateError(error: error)
        })
    }
    
    func photoSelected(dataToPass: Any?, segue: UIStoryboardSegue?) {
        output.displayPhotoDetails(dataToPass: dataToPass, segue: segue)
    }
}
