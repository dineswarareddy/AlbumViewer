//
//  AlbumListFactory.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation

enum AlbumListViewFactory {
    static func createAlbumsViewFactory(view: AlbumListViewPresenterOutput?) -> AlbumListViewInteractorInput {
        let networkController = AlbumsNetworkController()
        let presenter = AlbumListViewPresenter(view: view)
        let interactor = AlbumListInteractor(presenter: presenter, networkController: networkController)
        let router = AlbumListRouter()
        presenter.router = router
        return interactor
    }
}
