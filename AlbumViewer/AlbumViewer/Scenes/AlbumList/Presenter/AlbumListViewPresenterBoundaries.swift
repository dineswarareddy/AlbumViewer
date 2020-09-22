//
//  AlbumListViewPresenterBoundaries.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation

protocol AlbumListViewPresenterOutput {
    func displayAlbumList(albums: [Album])
    func displayNoAlbumsFoundMessage(message: String)
    func removeNoAlbumsMessageLabel()
    func displaActivityIndicator()
    func removeActivityIndicator()
}
