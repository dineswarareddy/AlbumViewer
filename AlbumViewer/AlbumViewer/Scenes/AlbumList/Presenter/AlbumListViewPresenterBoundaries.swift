//
//  AlbumListViewPresenterBoundaries.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation

protocol AlbumListViewPresenterInput {
}

protocol AlbumListViewPresenterOutput {
    func displayAlbumList(albums: [Album])
}
