/*
 Copyright © 2016 Toboggan Apps LLC. All rights reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import UIKit

/// View with a black, semi-transparent overlay that can have subtracted "holes" to view behind the overlay.
/// Optionally add ``subtractedPaths`` to initialize the overlay with holes. More paths can be subtracted later using ``subtractFromView``.
public class TAOverlayView: UIView {
    
    /// The paths that have been subtracted from the view.
    fileprivate var subtractions: [UIBezierPath] = []
    
    var hideButton: UIButton!
    
    var tirangelImageView: UIImageView!
    var contentView: UIView!
    var hintText: String = ""
    var hintLableTargetView: UIView!
    var boxPosition: DialogBoxPosition = .bottom
    
    /// Use to init the overlay.
    ///
    /// - parameter frame: The frame to use for the semi-transparent overlay.
    /// - parameter subtractedPaths: The paths to subtract from the overlay initially. These are optional (not adding them creates a plain overlay). More paths can be subtracted later using ``subtractFromView``.
    ///
    init(subtractedPaths: [TASubtractionPath], hintLableTargetView: UIView?, rectangleRect: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        self.hintLableTargetView = hintLableTargetView ?? subtractedPaths.first!.view
        
        // Set a semi-transparent, black background.
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        self.alpha = 0.0
        
        // Create the initial layer from the view bounds.
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.fillColor = UIColor.black.cgColor
        
        let path = UIBezierPath(rect: self.bounds)
        maskLayer.path = path.cgPath
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        // Set the mask of the view.
        self.layer.mask = maskLayer
        
        self.subtractFromView(paths: subtractedPaths)

        hideButton = UIButton(frame: .zero)
        hideButton.addTarget(self, action: #selector(hideButtonTouchUpInside), for: .touchUpInside)
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hideButton)
        
        switch boxPosition {
        case .top:
            tirangelImageView = UIImageView(frame: CGRect(x: self.hintLableTargetView.center.x, y: self.hintLableTargetView.frame.origin.y - 20, width: 15, height: 20))
            tirangelImageView.clipsToBounds = true
            tirangelImageView.contentMode = .scaleAspectFit
            tirangelImageView.image = .mpTriangleBottom()
            addSubview(tirangelImageView)
            
            bringSubview(toFront: tirangelImageView)
            
            let textLabel = UITextView(frame: .zero)
            textLabel.clipsToBounds = true
            textLabel.layer.cornerRadius = 6.0
            //textLabel.backgroundColor = .mpPackageBackgroundColor()
            //textLabel.font = .UILabelTextSmallerMedium()
            //textLabel.textColor = .mpCellSelectedBackground()
            textLabel.sizeToFit()
            textLabel.text = hintText
            textLabel.isUserInteractionEnabled = false
            textLabel.textAlignment = .center
            textLabel.textContainerInset = UIEdgeInsetsMake(10, 5, 0, 5)
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            addSubview(textLabel)
            
            bringSubview(toFront: textLabel)
            
            let textLabelLayoutConstraint = [
                NSLayoutConstraint(item: textLabel, attribute: .bottom, relatedBy: .equal, toItem: tirangelImageView, attribute: .top, multiplier: 1, constant: 5)
                , NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .equal, toItem: tirangelImageView , attribute: .leading, multiplier: 1, constant: rectangleRect.origin.x - (tirangelImageView.center.x - self.hintLableTargetView.frame.size.width / 2))
                , NSLayoutConstraint(item: textLabel, attribute: .width, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: rectangleRect.size.width)
                , NSLayoutConstraint(item: textLabel, attribute: .height, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: rectangleRect.size.height)
            ]
            addConstraints(textLabelLayoutConstraint)
            
        case .bottom:
            tirangelImageView = UIImageView(frame: CGRect(x: self.hintLableTargetView.center.x-5, y: self.hintLableTargetView.frame.origin.y + self.hintLableTargetView.frame.size.height + 5, width: 15, height: 20))
            tirangelImageView.clipsToBounds = true
            tirangelImageView.contentMode = .scaleAspectFit
            tirangelImageView.image = .mpTriangleTop()
            addSubview(tirangelImageView)
            
            let textLabel = UITextView(frame: .zero)
            textLabel.clipsToBounds = true
            textLabel.layer.cornerRadius = 6.0
            //textLabel.backgroundColor = .mpPackageBackgroundColor()
            //textLabel.font = .UILabelTextSmallerMedium()
            //textLabel.textColor = .mpCellSelectedBackground()
            textLabel.sizeToFit()
            textLabel.text = hintText
            textLabel.textAlignment = .center
            textLabel.isUserInteractionEnabled = false
            textLabel.textContainerInset = UIEdgeInsetsMake(10, 5, 0, 5);
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            addSubview(textLabel)
            
            bringSubview(toFront: textLabel)
            
            let textLabelLayoutConstraint = [
                NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: tirangelImageView, attribute: .bottom, multiplier: 1, constant: -5)
                , NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .equal, toItem: tirangelImageView , attribute: .leading, multiplier: 1, constant:rectangleRect.origin.x - (self.hintLableTargetView.center.x - self.hintLableTargetView.frame.size.width / 2))
                , NSLayoutConstraint(item: textLabel, attribute: .width, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: rectangleRect.size.width)
                , NSLayoutConstraint(item: textLabel, attribute: .height, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: rectangleRect.size.height)
            ]
            addConstraints(textLabelLayoutConstraint)
            
        case .left:
            tirangelImageView.image = .mpTriangleLeft()
        case .right:
            tirangelImageView.image = .mpTriangleRight()
        }
        
        let hideButtonLayoutConstraint = [
            NSLayoutConstraint(item: hideButton, attribute: .top, relatedBy: .equal, toItem: hideButton.superview, attribute: .top, multiplier: 1, constant: 0)
            , NSLayoutConstraint(item: hideButton, attribute: .leading, relatedBy: .equal, toItem: hideButton.superview, attribute: .leading, multiplier: 1, constant: 0)
            , NSLayoutConstraint(item: hideButton, attribute: .trailing, relatedBy: .equal, toItem: hideButton.superview, attribute: .trailing, multiplier: 1, constant: 0)
            , NSLayoutConstraint(item: hideButton, attribute: .bottom, relatedBy: .equal, toItem: hideButton.superview, attribute: .bottom, multiplier: 1, constant: 0)
        ]
        addConstraints(hideButtonLayoutConstraint)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.alpha = 1
        }, completion: nil)
    }
    
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // Allow touches in "holes" of the overlay to be sent to the views behind it.
        for path in self.subtractions {
            if path.contains(point) {
                return true
            }
        }
        return true
    }
    
    public func hideButtonTouchUpInside() {
        ShowcaseController.instance.showNextOverlay()
    }
    
    /// Subtracts the given ``paths`` from the view.
    public func subtractFromView(paths: [TABaseSubtractionPath]) {
        if let layer = self.layer.mask as? CAShapeLayer, let oldPath = layer.path {
            // Start off with the old/current path.
            let newPath = UIBezierPath(cgPath: oldPath)
            
            // Subtract each of the new paths.
            for path in paths {
                self.subtractions.append(path.bezierPath)
                newPath.append(path.bezierPath)
            }
            
            // Update the layer.
            layer.path = newPath.cgPath
            self.layer.mask = layer
        }
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
enum DialogBoxPosition {
    
    case top
    case bottom
    case right
    case left
    
}
