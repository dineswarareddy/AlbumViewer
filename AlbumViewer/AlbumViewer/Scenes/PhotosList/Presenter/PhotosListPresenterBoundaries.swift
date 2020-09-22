//
//  AlbumPhotosPresenterBoundaries.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import Foundation

protocol PhotosListPresenterOutput {
    func displayPhotos(photos: [Photo])
    func displayNoPhotosMessage(_ message: String)
    func displayError(message: String)
}
