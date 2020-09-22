//
//  AlbumListInterector.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation

class AlbumListInteractor {
    let output: AlbumListViewInteractorOutput
    let network: AlbumsNetworkDelegate?
    var albumsArray: [Album]? = []
    
    init(presenter: AlbumListViewInteractorOutput, networkController: AlbumsNetworkDelegate?) {
        self.output = presenter
        self.network = networkController
    }
    
    private func updateAlbumListToPresent(albumList: [Album]?) {
        if let albums = albumList {
            self.output.updateAlbumList(albums: albums)
        }
    }
}

extension AlbumListInteractor: AlbumListViewInteractorInput {
    func fetchAlbumList() {
        network?.fetchAlbums(completionHandler: { [weak self] (albumList, error) -> (Void) in
            if let albums = albumList {
                self?.albumsArray = albums
                self?.updateAlbumListToPresent(albumList: albums)
            }
        })
    }
    
    func fetchAlbumListContainsText(searchedText: String) {
        if searchedText.count > 0 {
            if let filterAlbums = albumsArray?.filter({ $0.title?.range(of:  searchedText, options: .caseInsensitive) != nil }) {
                updateAlbumListToPresent(albumList: filterAlbums)
            }
        } else {
            updateAlbumListToPresent(albumList: albumsArray)
        }
    }
}
