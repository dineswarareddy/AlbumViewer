//
//  AlbumListInteractorBoundaries.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation
import UIKit

protocol AlbumListViewInteractorInput {
    func fetchAlbumList()
    func fetchAlbumListContainsText(searchedText: String)
    func albumSelected(dataToPass: Any?, segue: UIStoryboardSegue?)
}

protocol AlbumListViewInteractorOutput {
    func updateAlbumList(albums: [Album])
    func displayAlbumDetails(dataToPass: Any?, segue: UIStoryboardSegue?)
    func showActivityIndicator()
    func hideActivityIndicator()
}
