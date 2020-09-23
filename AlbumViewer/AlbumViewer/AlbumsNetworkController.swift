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

final class AlbumsNetworkController {
    private let networkUtility: AlbumsNetworkUtilities
    init(networkUtility: AlbumsNetworkUtilities) {
        self.networkUtility = networkUtility
    }
    
    private func initiateAlbumListAPICall(requestURL: URL, completionHandler: @escaping(Result<[Album], Error>) -> (Void)) {
        APIHandler.initiateAPICall(requestURL: requestURL) { [weak self] (response) -> (Void) in
            switch response {
            case .success(let responseData):
                do {
                    if let albums: [Album] = try self?.networkUtility.prepareModelFromData(responseData) {
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
    
    private func initiatePhotosListAPICall(requestURL: URL, completionHandler: @escaping(Result<[Photo], Error>) -> (Void)) {
        APIHandler.initiateAPICall(requestURL: requestURL, completion: { [weak self] (response) -> (Void) in
            switch response {
            case .success(let responseData):
                do {
                    if let photos: [Photo] = try self?.networkUtility.prepareModelFromData(responseData) {
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

extension AlbumsNetworkController: AlbumsNetworkDelegate {
    func fetchAlbums(completionHandler: @escaping(Result<[Album], Error>) -> (Void)) {
        if let requestURL = networkUtility.constructRequestBasedURL(dynamicPathComponent: nil) {
            initiateAlbumListAPICall(requestURL: requestURL) { (response) -> (Void) in
                completionHandler(response)
            }
        }
    }
    
    func fetchPhotos(of albumId: Int, completionHandler: @escaping(Result<[Photo], Error>) -> (Void)) {
        let albumIdString = String(albumId)
        if let requestURL = networkUtility.constructRequestBasedURL(dynamicPathComponent: [albumIdString]) {
            initiatePhotosListAPICall(requestURL: requestURL) { (response) -> (Void) in
                completionHandler(response)
            }
        }
    }
}

