//
//  ViewController.swift
//  HPShowCase
//
//  Created by Arash Farahani on 8/26/17.
//  Copyright © 2017 Arash Farahani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showHelp() {
        // You can do this if you want first time show Delay
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            let overlay1 = TAOverlayView(
                subtractedPaths: [
                    TASubtractionPath(view: self.packageButton, horizontalPadding: 2, verticalPadding: 2, cornerRadius: 6.0, shape: .rectangle)
                ]
                , rectangleRect: CGRect(x: self.packageButton.frame.origin.x - 150, y: self.packageButton.frame.origin.y + self.packageButton.frame.size.height, width: 220, height: 70)
                , hintText: "This is the first hint"
                , boxPosition: .bottom
            )
            
            // This shows Three differect items at the same time.
            let overlay2 = TAOverlayView(
                subtractedPaths: [
                    TASubtractionPath(view: self.heightButton, shape: .circle)
                    , TASubtractionPath(view: self.labButton, shape: .circle)
                    , TASubtractionPath(view: self.weightButton, shape: .circle)
                ]
                , hintLableTargetView: self.bloodSugerButton
                , rectangleRect: CGRect(x: self.bloodSugerButton.frame.origin.x - 100, y: self.bloodSugerButton.frame.origin.y + self.bloodSugerButton.frame.size.height, width: 260, height: 80)
                , hintText: "This is the second hint for showing five items"
                , boxPosition: .bottom
            )
            
            let overlay3 = TAOverlayView(
                subtractedPaths: [
                    TASubtractionPath(view: self.chatButton, shape: .circle)
                ]
                , rectangleRect: CGRect(x: self.chatButton.frame.origin.x - 30 , y: self.chatButton.frame.origin.y + self.chatButton.frame.size.height, width: 150, height: 40)
                , hintText: "This is the third hint"
                , boxPosition: .bottom
            )
            
            ShowcaseController.instance.overlays = [overlay1, overlay2, overlay3]
            ShowcaseController.instance.targetViewController = self
            ShowcaseController.instance.delegate = self
            ShowcaseController.instance.startInstructions()            
        }
    }
    
}
extension ViewController: FinishHelpDelegate {
    
    func helpShowFinished() {
        // You can set a perfrence for that
    }
    
}

