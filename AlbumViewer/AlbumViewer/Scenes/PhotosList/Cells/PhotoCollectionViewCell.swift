//
//  PhotoCollectionViewCell.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: AlbumImageView?
    
    func setupPhotoView(photo: Photo) {
        if let thumbNailURLString = photo.thumbnailUrl, let thumbNailURL = URL(string: thumbNailURLString) {
            photoImageView?.imageFromServerURL(thumbNailURL, useCache: true)
        }
    }
}
