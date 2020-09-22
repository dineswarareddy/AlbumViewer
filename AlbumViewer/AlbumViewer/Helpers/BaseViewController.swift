//
//  BaseViewController.swift
//  AlbumViewer
//
//  Created by Dinesh Reddy on 22/09/20.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    var activityIndicator: UIActivityIndicatorView?
    // To show activity indicator on top of view controller.
    func showActivityIndicator() {
        if activityIndicator != nil {
            startActivityAnimation()
            return
        }
        addActivityIndicator()
    }
    
    private func startActivityAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
        guard let `self` = self else { return }
            self.activityIndicator.map(self.view.addSubview(_:))
            self.activityIndicator?.startAnimating()
        }
    }
    
    private func addActivityIndicator() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            guard let `self` = self else { return }
            self.activityIndicator = UIActivityIndicatorView()
            self.activityIndicator?.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
            self.activityIndicator?.center = self.view.center
            self.activityIndicator?.hidesWhenStopped = true
            self.activityIndicator?.style = .medium
            self.activityIndicator.map(self.view.addSubview(_:))
            self.startActivityAnimation()
        }
    }
    
    // To hide activity indicator.
    func hideActivityIndicator() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.activityIndicator?.stopAnimating()
        }
    }
}
