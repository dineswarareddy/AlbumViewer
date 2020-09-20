//
//  AlbumListInteractorBoundaries.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation

protocol AlbumListViewInteractorInput {
    func fetchAlbumList()
}

protocol AlbumListViewInteractorOutput {
    func updateAlbumList(albums: [Album])
}
