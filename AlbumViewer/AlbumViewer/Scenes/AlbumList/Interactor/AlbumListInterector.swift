//
//  AlbumListInterector.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation
import UIKit

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
    func albumSelected(dataToPass: Any?, segue: UIStoryboardSegue?) {
        output.displayAlbumDetails(dataToPass: dataToPass, segue: segue)
    }
    
    func fetchAlbumList() {
        output.showActivityIndicator()
        network?.fetchAlbums(completionHandler: { [weak self] (response) -> (Void) in
            self?.output.hideActivityIndicator()
            switch response{
            case .success(let albums):
                self?.albumsArray = albums
                self?.updateAlbumListToPresent(albumList: albums)
            case .failure(let error):
                self?.output.updateError(error: error)
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
