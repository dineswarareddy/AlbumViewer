//
//  String+AlbumViewer.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation

extension String {
    internal func insert(_ content: [String]) -> String {
        let stringArray = self.components(separatedBy: "%@")
        var dynamicString = ""
        for (index, string) in stringArray.enumerated() {
            if content.count > index {
                dynamicString += string + content[index]
            }
            else {
                dynamicString += string
            }
        }
        return dynamicString
    }
}

