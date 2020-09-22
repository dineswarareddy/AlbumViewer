//
//  AlbumPhotosViewController.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import UIKit

class PhotosListViewController: BaseViewController {
    var selectedAlbum: Album?
    let photoCellIdentifier = "PhotoCollectionViewCell"
    @IBOutlet weak var photosCollectionView: UICollectionView?
    var interactor: PhotosListInteractorInput?
    private var photosToPresent: [Photo] = [] {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
                self?.photosCollectionView?.reloadData()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPhotosListInteractor()
        fetchPhotos(of: selectedAlbum)
    }
    
    private func setupUI() {
        if let pageTitle = selectedAlbum?.title {
            self.title = pageTitle
        }
    }
    
    private func setupPhotosListInteractor() {
        interactor = PhotosListViewFactory.createPhotosViewFactory(view: self)
    }
    
    private func fetchPhotos(of album: Album?) {
        if let selectedAlbum = album {
            interactor?.fetchPhots(of: selectedAlbum)
        }
    }
    
    private func showNoContentsAvailable(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            guard let `self` = self else { return }
            let noDataLabel: UILabel = UILabel(frame: self.view.frame)
            noDataLabel.text = message
            noDataLabel.textColor = UIColor.gray
            noDataLabel.font = .boldSystemFont(ofSize: 14)
            noDataLabel.textAlignment = .center
            self.photosCollectionView?.backgroundView = noDataLabel
            self.photosCollectionView?.backgroundColor = .white
        }
    }
    
    private func removeNoContentsAvailableLabel() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            self?.photosCollectionView?.backgroundView = nil
        })
    }
}

extension PhotosListViewController: UICollectionViewDelegate {
    
}

extension PhotosListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosToPresent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoDisplayCell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        photoDisplayCell.setupPhotoView(photo: photosToPresent[indexPath.item])
        return photoDisplayCell
    }    
}

extension PhotosListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - 30) * 0.5
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension PhotosListViewController: PhotosListPresenterOutput {
    func removeNoPhotosMessageLabel() {
        removeNoContentsAvailableLabel()
    }
    
    func displaActivityIndicator() {
        self.showActivityIndicator()
    }
    
    func removeActivityIndicator() {
        self.hideActivityIndicator()
    }
    
    func displayError(message: String) {
        // Show error in view
    }
    
    func displayPhotos(photos: [Photo]) {
        photosToPresent = photos
    }
    
    func displayNoPhotosMessage(_ message: String) {
        // Show some message to display when there is no photos to dsisplay
        showNoContentsAvailable(message: message)
    }
    
}
