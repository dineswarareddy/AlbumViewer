//
//  AlbumPhotosInteractorBoundaries.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import Foundation

protocol PhotosListInteractorInput {
    func fetchPhots(of album: Album)
}

protocol PhotosListInteractorOutput {
    func updatePhotosList(photos: [Photo]?)
    func updateError(error: Error)
}
