//
//  PhotoPreviewViewController.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 22/09/20.
//

import UIKit

class PhotoPreviewViewController: UIViewController {
    var photoToPreview: Photo?
    @IBOutlet weak var previewImageView: AlbumImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPreviewImage()
    }
    
    private func setupPreviewImage() {
        if let imageURLString = photoToPreview?.url, let imagURL = URL(string: imageURLString) {
            previewImageView?.imageFromServerURL(imagURL, useCache: true)
        }
    }
}
