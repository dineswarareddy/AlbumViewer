//
//  AlbumPhotosViewController.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import UIKit

class PhotosListViewController: UIViewController {
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
        if let selectedAlbum = selectedAlbum {
            fetchPhotos(of: selectedAlbum)
        }
    }
    
    private func setupUI() {
        if let pageTitle = selectedAlbum?.title {
            self.title = pageTitle
        }
    }
    
    private func setupPhotosListInteractor() {
        interactor = PhotosListViewFactory.createPhotosViewFactory(view: self)
    }
    
    private func fetchPhotos(of album: Album) {
        interactor?.fetchPhots(of: album)
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
        return CGSize(width: (collectionView.frame.width - 30) * 0.5, height: 110)
    }
}

extension PhotosListViewController: PhotosListPresenterOutput {
    func displayError(message: String) {
        // Show error in view
    }
    
    func displayPhotos(photos: [Photo]) {
        photosToPresent = photos
    }
    
    func displayNoPhotosMessage(_ message: String) {
        // Show some message to display when there is no photos to dsisplay
    }
}
