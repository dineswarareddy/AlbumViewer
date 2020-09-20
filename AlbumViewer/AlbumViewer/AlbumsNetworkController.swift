//
//  AlbumsNetworkController.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation


class AlbumsNetworkController {
    private let requestType: RequestType
    required init(requestType: RequestType) {
        self.requestType = requestType
    }
    
    enum RequestType {
        case album
        var requestPathComponent: String {
            switch self {
            case .album:
                return "users/1/albums"
            }
        }
    }

    func fetchAlbums(completionHandler: @escaping(_ albums: [Album]?, _ error: Error?) -> (Void)) {
        if let requestURL = constructAlbumListURL(requestType: requestType) {
            APIHandler.initiateAPICall(requestURL: requestURL, completion: { [weak self] (responseData, error) -> (Void) in
                if let responseData = responseData as? Data {
                    do {
                        if let albums: [Album] = try self?.prepareModelFromData(responseData) {
                            completionHandler(albums, nil)
                        }
                    }
                    catch let error {
                        print(error)
                        completionHandler(nil, error) }
                } else {
                    completionHandler(nil, error)
                }
            })
        }
    }

    private func prepareModelFromData<T: Decodable>(_ responseData: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: responseData)
    }
    
    private func constructAlbumListURL(requestType: RequestType) -> URL? {
        if let baseURL: String = PListAccessor.getBaseURL() {
            return URL(string: "\(baseURL)\(requestType.requestPathComponent)")
        } else {
            return nil
        }
   }
}
