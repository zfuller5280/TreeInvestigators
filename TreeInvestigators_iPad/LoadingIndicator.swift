//
//  LoadingIndicator.swift
//  TreeInvestigators_iPad
//
//  Created by Steve Schaeffer on 7/7/16.
//  Copyright © 2016 Zach Fuller. All rights reserved.
//

//  Usage:
//
//  # Show Overlay
//  LoadingOverlay.shared.showOverlay(self.navigationController?.view)
//
//  # Hide Overlay
//  LoadingOverlay.shared.hideOverlayView()

import UIKit
import Foundation

public class LoadingOverlay: NSObject {
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    public func showOverlay(view: UIView!) {
        overlayView = UIView(frame: UIScreen.mainScreen().bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activityIndicator.center = overlayView.center
        overlayView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        print(overlayView)
        view.addSubview(overlayView)
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
