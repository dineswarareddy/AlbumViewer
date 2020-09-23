//
//  PhotosListFactory.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import Foundation
import UIKit

enum PhotosListViewFactory {
    static func createPhotosViewFactory(view: PhotosListPresenterOutput?) -> PhotosListInteractorInput {
        let networkController = AlbumsNetworkController(networkUtility: NetworkUtilitySupporter(requestType: .photos))
        let presenter = PhotosListPresenter(view: view)
        let interactor = PhotosListInteractor(presenter: presenter, networkController: networkController)
        let router = PhotosListRouter()
        presenter.router = router
        return interactor
    }
}

extension PhotosListViewController {
    private struct Constants {
        static let previewSegue = "PresentPhotoSegue"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.previewSegue {
            interactor?.photoSelected(dataToPass: sender, segue: segue)
        }
    }
}
