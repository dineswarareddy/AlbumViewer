//
//  AlbumNetworkUtilityTests.swift
//  AlbumViewerTests
//
//  Created by Dinesh Reddy on 23/09/20.
//

import XCTest
@testable import AlbumViewer

class NetworkUtilitySupporterTests: XCTestCase {
    
    override class func setUp() {
        
    }

    /// To test request url generator
    func testGivenRequestTypeAlbumWhenURLGeneratedThenURLReturn() {
        let expectedOutput = "users/1/albums"
        let utiliyObj = NetworkUtilitySupporter(requestType: .album)
        let actualOutput = utiliyObj.constructRequestBasedURL(dynamicPathComponent: nil)
        XCTAssertTrue(((actualOutput?.absoluteString.contains(expectedOutput)) != nil))
    }
    
    func testGivenRequestTypePhotosWhenURLGeneratedThenURLContainsPhotosPath() {
        let expectedOutput = "albums/1/photos"
        let utiliyObj = NetworkUtilitySupporter(requestType: .photos)
        let actualOutput = utiliyObj.constructRequestBasedURL(dynamicPathComponent: ["1"])
        XCTAssertTrue(((actualOutput?.absoluteString.contains(expectedOutput)) != nil))
    }
}
