//
//  AlbumListInteractorTests.swift
//  AlbumViewerTests
//
//  Created by Dinesh Reddy on 23/09/20.
//

import XCTest
@testable import AlbumViewer

class AlbumListInteractorTests: XCTestCase {
    var albumListInteractor: AlbumListInteractor?
    var presenter: OutputMock = OutputMock()
    
    override func setUp() {
    }
    
    func testGivenAlbumListWhenRequestSuccessThenReturnAlbums() {
        let expectedOutput = [Album(userId: 1, id: 1, title: "Test1"), Album(userId: 1, id: 2, title: "Test2")]
        let albumNetworkMock = AlbumNetworkMock(albumsList: expectedOutput, error: nil)
        setupInteractor(albumNetowork: albumNetworkMock)
        albumListInteractor?.fetchAlbumList()
        XCTAssertEqual(presenter.albumsList, expectedOutput)
    }
    
    func testGivenAlbumListWhenRequestFailedThenReturnError() {
        let mockError = AppError(message: "test error")
        let albumNetworkMock = AlbumNetworkMock(albumsList: nil, error: mockError)
        setupInteractor(albumNetowork: albumNetworkMock)
        albumListInteractor?.fetchAlbumList()
        XCTAssertNotEqual(presenter.error.debugDescription, nil)
    }
    

    private func setupInteractor(albumNetowork: AlbumNetworkMock) {
        albumListInteractor = AlbumListInteractor(presenter: presenter, networkController: albumNetowork)
    }
    
    class OutputMock: AlbumListViewInteractorOutput {
        var albumsList: [Album]?
        var error: Error?
        
        func updateAlbumList(albums: [Album]) {
            albumsList = albums
        }
        
        func displayAlbumDetails(dataToPass: Any?, segue: UIStoryboardSegue?) {
            // UITest
        }
        
        func showActivityIndicator() {
            // UITest
        }
        
        func hideActivityIndicator() {
            // UITest
        }
        
        func updateError(error: Error) {
            self.error = error
        }
    }
    
    class AlbumNetworkMock: AlbumsNetworkDelegate {
        var albumList: [Album]?
        var errorToReturn: Error?
        init(albumsList:[Album]?, error: Error?) {
            self.albumList = albumsList
            self.errorToReturn = error
        }
        
        func fetchAlbums(completionHandler: @escaping (Result<[Album], Error>) -> (Void)) {
            if let error = errorToReturn {
                completionHandler(.failure(error))
                return
            }
            if let albumsList = self.albumList {
                completionHandler(.success(albumsList))
            }
        }
        
        func fetchPhotos(of albumId: Int, completionHandler: @escaping (Result<[Photo], Error>) -> (Void)) {
            
        }
    }
}

struct AppError: Error {
    let message: String
    
    internal init(message: String) {
        self.message = message
    }
}
