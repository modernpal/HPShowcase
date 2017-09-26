//
//  ViewController.swift
//  HPShowCase
//
//  Created by Arash Farahani on 8/26/17.
//  Copyright © 2017 Arash Farahani & Mehdi Gilanpour. All rights reserved.
//

import UIKit
import HPShowcase

class ViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ShowcaseController.instance.delegate = self
        ShowcaseController.instance.showHelp(helps: [
            
            TAOverlayView(subtractedPaths: [
                TASubtractionPath(view: self.testButton, horizontalPadding: 2, verticalPadding: 2, cornerRadius: 6.0, shape: .rectangle),
                TASubtractionPath(view: self.label1, horizontalPadding: 2, verticalPadding: 2, cornerRadius: 6.0, shape: .circle)
                ]
                , hintLableTargetView: self.testButton
                , hintText: "Lorem ipsum dolor sit amet, et  "
                , containerView: view
                , backgroundColor: UIColor.red
                , textColor: UIColor.white
                , boxPosition: .top
            ) ,
            TAOverlayView(subtractedPaths: [
                TASubtractionPath(view: self.label1, horizontalPadding: 2, verticalPadding: 2, cornerRadius: 6.0, shape: .rectangle)
                ]
                , hintLableTargetView: self.label1
                , hintText: "Lorem ipsum dolor sit amet, et dicunt pertinacia mea. Cum odio agam ea. Pri luptatum mandamus iudicabit an, te idque utinam graece mea. Id euismod voluptatum consequuntur has. Te harum molestie eum, deleniti splendide at pro. Eu eros tamquam g"
                , containerView: view
                , backgroundColor: UIColor.white
                , textColor: UIColor.blue
                , boxPosition: .bottom
            ),
            TAOverlayView(subtractedPaths: [
                TASubtractionPath(view: self.label1, horizontalPadding: 2, verticalPadding: 2, cornerRadius: 6.0, shape: .rectangle),
                TASubtractionPath(view: self.label2, horizontalPadding: 2, verticalPadding: 2, cornerRadius: 6.0, shape: .rectangle),
                TASubtractionPath(view: self.testButton, horizontalPadding: 2, verticalPadding: 2, cornerRadius: 6.0, shape: .circle)
                ]
                , hintLableTargetView: self.label2
                , hintText: "Lorem ipsum dolor sit amet, et dicunt pertinacia mea. Cum odio agam ea. Pri luptatum mandamus iudicabit an, te idque utinam graece mea. Id euismod voluptatum consequuntur has. Te harum molestie eum, deleniti splendide at pro. \n Eu eros tamquam graecis per. Ut solet iisque convenire vix, choro habemus accusam mei cu, mei ad dicat veritus luptatum. Eam "
                , containerView: view
                , backgroundColor: UIColor.yellow
                , textColor: UIColor.orange
                , boxPosition: .bottom
            )
            ]
            
            , targetVireController: self)
    }
    
}
extension ViewController: FinishHelpDelegate {
    
    func helpShowFinished() {
        // You can set a perfrence for that
    }
    
}

