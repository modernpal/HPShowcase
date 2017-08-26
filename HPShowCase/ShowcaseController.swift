//
//  ShowcaseController.swift
//  HPShowCase
//
//  Created by Arash Farahani on 8/26/17.
//  Copyright © 2017 Arash Farahani. All rights reserved.
//

import UIKit

protocol FinishHelpDelegate: class {
    
    func helpShowFinished()
    
}
class ShowcaseController {
    
    fileprivate static var showcaseControllerInstance: ShowcaseController? = nil
    static var instance: ShowcaseController = {
        if showcaseControllerInstance == nil {
            showcaseControllerInstance = ShowcaseController()
        }
        return showcaseControllerInstance!
    }()
    
    var targetViewController: UIViewController!
    var overlays: [TAOverlayView]!
    
    var thisOverlayIndex = 0
    var delegate: FinishHelpDelegate?
    
    func showNextOverlay() {
        if overlays != nil && overlays.count > 0 {
            if thisOverlayIndex < (overlays.count - 1) {
                UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.overlays[self.thisOverlayIndex].alpha = 0
                }, completion: nil)
                overlays[thisOverlayIndex].removeFromSuperview()
                thisOverlayIndex = thisOverlayIndex + 1
                
                //targetViewController.view.addSubview(overlays[thisOverlayIndex])
                targetViewController.view.subviews.filter( {$0 is UIScrollView} ).first?.addSubview(overlays[thisOverlayIndex])
                
                overlays[thisOverlayIndex].alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.overlays[self.thisOverlayIndex].alpha = 1
                }, completion: nil)
                
            } else {
                hideHelp()
            }
        }
    }
    
    func hideHelp() {
        if (overlays != nil && overlays.count > 0) {
            overlays[thisOverlayIndex].removeFromSuperview()
            thisOverlayIndex = 0
            overlays.removeAll()
            delegate?.helpShowFinished()
        }
        
    }
    
    func startInstructions() {
        //targetViewController.view.addSubview(overlays[0])
        targetViewController.view.subviews.filter( {$0 is UIScrollView} ).first?.addSubview(overlays[0])
    }
    
}
