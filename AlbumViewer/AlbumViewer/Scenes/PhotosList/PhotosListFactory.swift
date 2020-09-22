//
//  PhotosListFactory.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import Foundation

enum PhotosListViewFactory {
    static func createPhotosViewFactory(view: PhotosListPresenterOutput?) -> PhotosListInteractorInput {
        let networkController = AlbumsNetworkController()
        let presenter = PhotosListPresenter(view: view)
        let interactor = PhotosListInteractor(presenter: presenter, networkController: networkController)
        let router = AlbumListRouter()
//        presenter.router = router
        return interactor
    }
}
