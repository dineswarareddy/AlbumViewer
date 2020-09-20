//
//  AlbumListTableViewCell.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import UIKit

class AlbumListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var albumTitleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupAlbumView(album: Album) {
        if let albumTitle = album.title {
            albumTitleLabel?.text = "Album: \(albumTitle)"
        }
    }

}
