//
//  AlbumListViewPresenter.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation
import UIKit

class AlbumListViewPresenter {
    var view: AlbumListViewPresenterOutput?
    var router: AlbumListRouterDelegate?
    
    init(view: AlbumListViewPresenterOutput?) {
        self.view = view
        self.router = AlbumListRouter()
    }
}

extension AlbumListViewPresenter: AlbumListViewInteractorOutput {
    func updateAlbumList(albums: [Album]) {
        view?.displayAlbumList(albums: albums)
    }
    
    func displayAlbumDetails(albumId: Int, segue: UIStoryboardSegue?) {
        router?.passDataToNextScene(segue: segue)
    }
}
