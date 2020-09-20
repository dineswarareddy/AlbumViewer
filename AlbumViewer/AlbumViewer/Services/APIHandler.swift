//
//  APIHandler.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 19/09/20.
//

import Foundation

final class APIHandler {
    typealias ServiceCallBack = (_ response: Any?, _ error: Error?) -> (Void)

    private struct RequestConstants {
        static let timeoutInterval = 180
        static let httpMethod = "GET"
    }

    class func initiateAPICall(requestURL: URL, completion: @escaping ServiceCallBack) {
        var channelsDataRequest = URLRequest.init(url: requestURL, timeoutInterval: TimeInterval(RequestConstants.timeoutInterval))
        channelsDataRequest.httpMethod = RequestConstants.httpMethod
        channelsDataRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataSession = URLSession(configuration: .default)
        dataSession.dataTask(with: channelsDataRequest,
                             completionHandler: { (data, response, error) in
                                guard let data = data else {
                                    completion(nil, error)
                                    return
                                }
                                completion(data, nil)
        }).resume()
    }
}
