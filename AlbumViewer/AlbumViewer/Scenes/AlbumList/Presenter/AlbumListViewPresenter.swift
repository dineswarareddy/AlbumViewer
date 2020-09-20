//
//  AlbumListViewPresenter.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation

class AlbumListViewPresenter {
    var view: AlbumListViewPresenterOutput?
    
    init(view: AlbumListViewPresenterOutput?) {
        self.view = view
    }
}

extension AlbumListViewPresenter: AlbumListViewPresenterInput {
    // Added presenter update required calls
}

extension AlbumListViewPresenter: AlbumListViewInteractorOutput {
    func updateAlbumList(albums: [Album]) {
        view?.displayAlbumList(albums: albums)
    }
}
