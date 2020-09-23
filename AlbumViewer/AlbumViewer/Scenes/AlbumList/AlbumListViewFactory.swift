//
//  AlbumListFactory.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation
import UIKit

enum AlbumListViewFactory {
    static func createAlbumsViewFactory(view: AlbumListViewPresenterOutput?) -> AlbumListViewInteractorInput {
        let networkController = AlbumsNetworkController(networkUtility: NetworkUtilitySupporter(requestType: .album))
        let presenter = AlbumListViewPresenter(view: view)
        let interactor = AlbumListInteractor(presenter: presenter, networkController: networkController)
        let router = AlbumListRouter()
        presenter.router = router
        return interactor
    }
}

extension AlbumListViewController {
    private struct Constants {
        static let photosSegue = "AlbumPhotosSegue"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.photosSegue {
            interactor?.albumSelected(dataToPass: sender, segue: segue)
        }
    }
}
