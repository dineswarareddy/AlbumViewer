//
//  ViewController.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import UIKit

class AlbumListViewController: UIViewController {
    
    private struct Constants {
        static let albumListCellIdentifier = "AlbumListTableViewCell"
    }
    
    var interactor: AlbumListViewInteractorInput?
    @IBOutlet weak var albumListTableView: UITableView?
    @IBOutlet weak var albumSearchBar: UISearchBar?
    
    private var albumList: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlbumListInteractor()
        fetchAlbumList()
    }
    
    private func setupAlbumListInteractor() {
        interactor = AlbumListViewFactory.createAlbumsViewFactory(view: self)
    }
    
    private func fetchAlbumList() {
        interactor?.fetchAlbumList()
    }
    
    private func displayAlbums(albums: [Album]) {
        albumList = albums
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            self?.albumListTableView?.reloadData()
        })
    }
}

extension AlbumListViewController: AlbumListViewPresenterOutput {
    func displayAlbumList(albums: [Album]) {
        self.displayAlbums(albums: albums)
    }
}

extension AlbumListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension AlbumListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let albumListCell = tableView.dequeueReusableCell(withIdentifier: Constants.albumListCellIdentifier, for: indexPath) as? AlbumListTableViewCell else {
            return UITableViewCell()
        }
        albumListCell.setupAlbumView(album: albumList[indexPath.row])
        return albumListCell
    }
}

