//
//  AlbumListRouter.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import Foundation
import UIKit

protocol AlbumListRouterDelegate {
    func passDataToNextScene(segue: UIStoryboardSegue?, dataToPass: Any?)
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
    func passDataToNextScene(segue: UIStoryboardSegue?, dataToPass: Any?) {
        // NOTE: Teach the router which scenes it can communicate with
        if let photoListView = segue?.destination as? PhotosListViewController, let selectedAlbum = dataToPass as? Album {
            photoListView.selectedAlbum = selectedAlbum
        }
    }
}
