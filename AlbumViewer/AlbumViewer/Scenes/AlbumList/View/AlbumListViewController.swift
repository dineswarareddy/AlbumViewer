//
//  ViewController.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import UIKit

class AlbumListViewController: BaseViewController {
    
    private struct Constants {
        static let albumListCellIdentifier = "AlbumListTableViewCell"
        static let photosSegue = "AlbumPhotosSegue"
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
    
    private func showNoContentsAvailable(message: String) {
        let noDataLabel: UILabel = UILabel(frame: self.view.frame)
        noDataLabel.text = message
        noDataLabel.textColor = UIColor.gray
        noDataLabel.font = .boldSystemFont(ofSize: 14)
        noDataLabel.textAlignment = .center
        self.albumListTableView?.backgroundView = noDataLabel
        self.albumListTableView?.backgroundColor = UIColor.white
    }
    
    private func removeNoContentsAvailableLabel() {
        self.albumListTableView?.backgroundView = nil
    }
}

extension AlbumListViewController: AlbumListViewPresenterOutput {
    func displayError(error: Error) {
        // Write logic to show error message here.
    }
    
    func displayNoAlbumsFoundMessage(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            self?.showNoContentsAvailable(message: message)
        })
    }
    
    func removeNoAlbumsMessageLabel() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            self?.removeNoContentsAvailableLabel()
        })
    }
    
    func displayAlbumList(albums: [Album]) {
        self.displayAlbums(albums: albums)
    }
    
    func displaActivityIndicator() {
        self.showActivityIndicator()
    }
    
    func removeActivityIndicator() {
        self.hideActivityIndicator()
    }
}

extension AlbumListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.photosSegue, sender: albumList[indexPath.row])
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

extension AlbumListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor?.fetchAlbumListContainsText(searchedText: searchText)
    }
}
