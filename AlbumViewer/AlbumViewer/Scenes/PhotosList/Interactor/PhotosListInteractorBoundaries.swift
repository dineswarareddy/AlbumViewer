//
//  AlbumPhotosInteractorBoundaries.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import Foundation
import UIKit

protocol PhotosListInteractorInput {
    func fetchPhots(of album: Album)
    func photoSelected(dataToPass: Any?, segue: UIStoryboardSegue?)
}

protocol PhotosListInteractorOutput {
    func updatePhotosList(photos: [Photo])
    func updateError(error: Error)
    func displayPhotoDetails(dataToPass: Any?, segue: UIStoryboardSegue?)
    func showActivityIndicator()
    func hideActivityIndicator()
}
