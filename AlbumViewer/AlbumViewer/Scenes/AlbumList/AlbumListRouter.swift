//
//  AlbumListRouter.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import Foundation
import UIKit

protocol AlbumListRouterDelegate {
    func passDataToNextScene(segue: UIStoryboardSegue?)
}

protocol AlbumDetailsDataStore
{
  var selectedAlbum: Album? { get set }
}


class AlbumListRouter
{
    // MARK: - Life cycle
    
    public init() { }
}

// MARK: - Router Interface

extension AlbumListRouter: AlbumListRouterDelegate
{
//    weak var viewController: AlbumViewController?
    func passDataToNextScene(segue: UIStoryboardSegue?) {
        // NOTE: Teach the router which scenes it can communicate with
        
        if let segueToPerform = segue, segueToPerform.identifier == "AlbumDetailViewController" {
            passDataToAlbumDetailsScene(segue: segueToPerform)
        }
    }
    private func passDataToAlbumDetailsScene(segue: UIStoryboardSegue) {
        // NOTE: Teach the router how to pass data to the next scene
        
        if let albumDetailsViewController = segue.destination as? PhotosListViewController {
//            albumDetailsViewController.selectedAlbum = viewController?.selectedAlbumToDisplay
        }
    }
}
