//
//  AlbumListFactory.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation

enum AlbumListViewFactory {
    static func createChannelsViewFactory(view: ChannelsListPresenterOutput?) -> ChannelsListInteractorInput {
        let networkController = ChannelsNetworkController()
        let presenter = ChannelsPresenter(view: view)
        let interactor = ChannelsListInteractor(presenter: presenter, networkController: networkController)
        return interactor
    }
}

