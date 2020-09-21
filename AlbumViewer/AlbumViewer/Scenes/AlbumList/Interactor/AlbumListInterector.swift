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
    
//    private func groupAlbumsById(_ albumArray: [Album]) {
//        var groupedarray: [[Album]]? = []
//        let uniqueIdSet = Set(albumArray.map{ $0.albumId}).sorted(by: {$0 < $1})
//        uniqueIdSet.forEach{ id in
//            groupedarray?.append(albumArray.filter{ $0.albumId == id })
//        }
//        if let groupByAlbumIdArray = groupedarray {
//            output.updateAlbumList(albums: groupByAlbumIdArray)
//        }
//    }
    
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
