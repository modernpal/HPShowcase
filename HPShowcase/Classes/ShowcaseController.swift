//
//  ShowcaseController.swift
//  HPShowCase
//
//  Created by Arash Farahani on 8/26/17.
//  Copyright © 2017 Arash Farahani & Mehdi Gilanpour. All rights reserved.
//

import UIKit

public protocol FinishHelpDelegate: class {
    func helpShowFinished()
}
public class ShowcaseController {
    
    fileprivate static var showcaseControllerInstance: ShowcaseController? = nil
    public static var instance: ShowcaseController = {
        if showcaseControllerInstance == nil {
            showcaseControllerInstance = ShowcaseController()
        }
        return showcaseControllerInstance!
    }()
    
    var targetViewController: UIViewController!
    var overlays: [TAOverlayView]!
    var currentOverlayIndex = 0
    public var delegate: FinishHelpDelegate?
    
    func showNextOverlay() {
        if overlays != nil && overlays.count > 0 {
            if currentOverlayIndex < (overlays.count - 1) {
                UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.overlays[self.currentOverlayIndex].alpha = 0
                }, completion: nil)
                overlays[currentOverlayIndex].removeFromSuperview()
                currentOverlayIndex = currentOverlayIndex + 1
                
                if let scrollView = targetViewController.view.subviews.filter( {$0 is UIScrollView} ).first {
                    scrollView.addSubview(overlays[currentOverlayIndex])
                } else {
                    targetViewController.view.addSubview(overlays[currentOverlayIndex])
                }
                
                overlays[currentOverlayIndex].alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.overlays[self.currentOverlayIndex].alpha = 1
                }, completion: nil)
                
            } else {
                hideHelp()
            }
        }
    }
    
    public func showHelp(helps: [TAOverlayView], targetVireController: UIViewController) {
        // You can do this if you want first time show Delay
        ShowcaseController.instance.overlays = helps
        ShowcaseController.instance.targetViewController = targetVireController
        ShowcaseController.instance.startInstructions()
    }
    
    func hideHelp() {
        
        if (overlays != nil && overlays.count > 0) {
            overlays[currentOverlayIndex].removeFromSuperview()
            currentOverlayIndex = 0
            overlays.removeAll()
            delegate?.helpShowFinished()
            if let scrollView = targetViewController.view.subviews.filter( {$0 is UIScrollView} ).first {
                (scrollView as! UIScrollView).isScrollEnabled = true
            }
        }
    }
    
    func startInstructions() {
        if let scrollView = targetViewController.view.subviews.filter( {$0 is UIScrollView} ).first {
            scrollView.addSubview(overlays[0])
            (scrollView as! UIScrollView).isScrollEnabled = false
        } else {
            targetViewController.view.addSubview(overlays[0])
        }
    }
    
}
