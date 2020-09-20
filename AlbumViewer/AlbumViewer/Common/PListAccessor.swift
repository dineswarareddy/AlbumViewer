//
//  PListAccessor.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation

class PListAccessor {
    static func getBaseURL() -> String? {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let nsDictionary = NSDictionary(contentsOfFile: path)
            let baseURL = nsDictionary?["BaseURL"] as? String
            return baseURL
        } else {
            return nil
        }
    }
}
