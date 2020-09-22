//
//  AlbumPhotosInteractor.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import Foundation

class PhotosListInteractor {
    
    let output: PhotosListInteractorOutput
    let network: AlbumsNetworkDelegate?
    var photosArray: [Photo]? = []
    
    init(presenter: PhotosListInteractorOutput, networkController: AlbumsNetworkDelegate?) {
        self.output = presenter
        self.network = networkController
    }
}

extension PhotosListInteractor: PhotosListInteractorInput {
    func fetchPhots(of album: Album) {
        network?.fetchPhotos(of: album.id, completionHandler: { [weak self] (photos, error) -> (Void) in
            guard let error = error else {
                self?.output.updatePhotosList(photos: photos)
                return
            }
            self?.output.updateError(error: error)
        })
    }
}
