//
//  Album.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation


struct Album: Decodable, Equatable {
    let userId: Int
    let id: Int
    let title: String?
    
    internal init(userId: Int, id: Int, title: String?) {
        self.userId = userId
        self.id = id
        self.title = title
    }
}
