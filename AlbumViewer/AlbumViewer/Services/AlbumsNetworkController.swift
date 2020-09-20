//
//  AlbumsNetworkController.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation

class AlbumsListNetworkController {
    private struct Constants {
        static let albumRequestURL = "https://jsonplaceholder.typicode.com/photos"
    }

    class func fetchAlbums(completionHandler: @escaping(_ albums: [Album]?, _ error: Error?) -> (Void)) {
        if let requestURL = URL(string: Constants.albumRequestURL) {
            APIHandler.initiateAPICall(requestURL: requestURL, completion: { (responseData, error) -> (Void) in
                if let responseData = responseData as? Data {
                    do {
                        if let albums: [Album] = try self.prepareModelFromData(responseData) {
                            completionHandler(albums, nil)
                        }
                    }
                    catch let error { completionHandler(nil, error) }
                } else {
                    completionHandler(nil, error)
                }
            })
        }
    }

    private class func prepareModelFromData<T: Decodable>(_ responseData: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: responseData)
    }
}
