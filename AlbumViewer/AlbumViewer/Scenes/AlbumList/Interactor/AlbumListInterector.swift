//
//  AlbumListInterector.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation

class AlbumListInteractor {
    let output: AlbumListViewInteractorOutput
    let network: AlbumsNetworkController?
    
    init(presenter: AlbumListViewInteractorOutput, networkController: AlbumsNetworkController?) {
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
}

extension AlbumListInteractor: AlbumListViewInteractorInput {
    func fetchAlbumList() {
        network?.fetchAlbums(completionHandler: { [weak self] (albumList, error) -> (Void) in
            if let albums = albumList {
                self?.output.updateAlbumList(albums: albums)
//                self?.groupAlbumsById(albums)
            }
        })
    }
}
