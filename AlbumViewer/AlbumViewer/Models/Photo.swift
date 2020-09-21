//
//  Photo.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 20/09/20.
//

import Foundation

struct Photo: Decodable {
    let albumId: Int
    let id: Int
    let title: String?
    let url: String?
    let thumbnailUrl: String?
    
    internal init(albumId: Int, id: Int, title: String?, url: String?, thumbnailUrl: String?) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}
