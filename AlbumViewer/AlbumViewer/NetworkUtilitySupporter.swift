//
//  NetworkUtilitySupporter.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 23/09/20.
//

import Foundation


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

protocol AlbumsNetworkUtilities {
    var requestType: RequestType { get set }
    func prepareModelFromData<T: Decodable>(_ responseData: Data) throws -> T
    func constructRequestBasedURL(dynamicPathComponent:[String]?) -> URL?
}

class NetworkUtilitySupporter: AlbumsNetworkUtilities {
    var requestType: RequestType
    init(requestType: RequestType) {
        self.requestType = requestType
    }
    
    func prepareModelFromData<T: Decodable>(_ responseData: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: responseData)
    }
    
    func constructRequestBasedURL(dynamicPathComponent:[String]?) -> URL? {
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
