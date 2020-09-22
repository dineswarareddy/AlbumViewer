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
    let noAlbumsMessage = "No albums found"
    
    init(view: AlbumListViewPresenterOutput?) {
        self.view = view
        self.router = AlbumListRouter()
    }
}

extension AlbumListViewPresenter: AlbumListViewInteractorOutput {
    func showActivityIndicator() {
        view?.displaActivityIndicator()
    }
    
    func hideActivityIndicator() {
        view?.removeActivityIndicator()
    }

    func updateAlbumList(albums: [Album]) {
        if albums.isEmpty == true {
            view?.displayNoAlbumsFoundMessage(message: noAlbumsMessage)
        } else {
            view?.removeNoAlbumsMessageLabel()
        }
        view?.displayAlbumList(albums: albums)
    }
    
    func displayAlbumDetails(dataToPass: Any?, segue: UIStoryboardSegue?) {
        router?.passDataToNextScene(segue: segue, dataToPass: dataToPass)
    }
}
