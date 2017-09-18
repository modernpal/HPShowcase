//
//  ViewController.swift
//  HPShowCase
//
//  Created by Arash Farahani on 8/26/17.
//  Copyright © 2017 Arash Farahani & Mehdi Gilanpour. All rights reserved.
//

import UIKit

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
                , hintText: "This is for laasdfsdfsfhsb s"
                , containerView: view
                , backgroundColor: UIColor.red
                , textColor: UIColor.white
                , boxPosition: .top
            ) ,
            TAOverlayView(subtractedPaths: [
                TASubtractionPath(view: self.label1, horizontalPadding: 2, verticalPadding: 2, cornerRadius: 6.0, shape: .rectangle)
                ]
                , hintLableTargetView: self.label1
                , hintText: "This is for laasdfsdfsfhsb sfjgsfjsdfwquyefg qwgquyf gqwufy fugf uwf gwufyg quwgqwufy gqwuyf gqwugf wquygefuyqwgeu qwgefutweuy askdb aifugsdfiu gfghasdf iusagf asiugsuf saiofug asiuf saiufgasfiu sagfiuasgf isuaf gsuifg sui fgsauifg asuifg siufg asiufg auisg faiusog faiosug "
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
                , hintText: "This is for laasdfsdfsfhsb sfjgsfjsdfwquyefg qwgquyf gqwufy fugf uwf gwufyg quwgqwufy gqwuyf gqwugf wquygefuyqwgeu qwgefutweuy askdb aifugsdfiu gfghasdf iusagf asiugsuf saiofug asiuf saiufgasfiu sagfiuasgf isuaf gsuifg sui fgsauifg asuifg siufg asiufg auisg faiusog faiosug "
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

