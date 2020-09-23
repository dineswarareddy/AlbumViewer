//
//  AlbumsNetworkController.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation

protocol AlbumsNetworkDelegate {
    func fetchAlbums(completionHandler: @escaping(Result<[Album], Error>) -> (Void))
    func fetchPhotos(of albumId: Int, completionHandler: @escaping(Result<[Photo], Error>) -> (Void))
}

class AlbumsNetworkController {
    enum RequestType {
        case album
        case photos
        var requestPathComponent: String {
            switch self {
            case .album:
                return "users/1/albums"
            case .photos:
                return "albums/%@/photos"
            }
        }
    }
    
    private func prepareModelFromData<T: Decodable>(_ responseData: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: responseData)
    }
    
    private func constructAlbumListURL(requestType: RequestType, dynamicPathComponent:[String]?) -> URL? {
        var pathComponent = requestType.requestPathComponent
        if let pathVariables = dynamicPathComponent {
            pathComponent = pathComponent.insert(pathVariables)
        }
        if let baseURL: String = PListAccessor.getBaseURL() {
            return URL(string: "\(baseURL)\(pathComponent)")
        }
        return nil
    }
}

extension AlbumsNetworkController: AlbumsNetworkDelegate {
    func fetchAlbums(completionHandler: @escaping(Result<[Album], Error>) -> (Void)) {
        if let requestURL = constructAlbumListURL(requestType: .album, dynamicPathComponent: nil) {
            APIHandler.initiateAPICall(requestURL: requestURL) { [weak self] (response) -> (Void) in
                switch response {
                case .success(let responseData):
                    do {
                        if let albums: [Album] = try self?.prepareModelFromData(responseData) {
                            completionHandler(.success(albums))
                        }
                    }
                    catch let jsonError {
                        completionHandler(.failure(jsonError)) }
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    func fetchPhotos(of albumId: Int, completionHandler: @escaping(Result<[Photo], Error>) -> (Void)) {
        let albumIdString = String(albumId)
        if let requestURL = constructAlbumListURL(requestType: .photos, dynamicPathComponent: [albumIdString]) {
            APIHandler.initiateAPICall(requestURL: requestURL, completion: { [weak self] (response) -> (Void) in
                switch response {
                case .success(let responseData):
                    do {
                        if let photos: [Photo] = try self?.prepareModelFromData(responseData) {
                            completionHandler(.success(photos))
                        }
                    }
                    catch let jsonError {
                        completionHandler(.failure(jsonError)) }
                case .failure(let error):
                    completionHandler(.failure(error))
                    break
                }
            })
        }
    }
}

