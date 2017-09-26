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
    
    var tirangelView: UIView!
    var contentView: UIView!
    var hintText: String = ""
    var hintLableTargetView: UIView!
    var boxPosition: DialogBoxPosition = .bottom
    var rectangleRect: CGRect!
    var containerView: UIView!
    var viewBackgroundColor: UIColor!
    var textColor: UIColor!
    
    /// Use to init the overlay.
    ///
    /// - parameter frame: The frame to use for the semi-transparent overlay.
    /// - parameter subtractedPaths: The paths to subtract from the overlay initially. These are optional (not adding them creates a plain overlay). More paths can be subtracted later using ``subtractFromView``.
    ///
    public init(subtractedPaths: [TASubtractionPath], hintLableTargetView: UIView, hintText: String, containerView: UIView, backgroundColor: UIColor, textColor: UIColor, boxPosition: DialogBoxPosition) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        self.boxPosition = boxPosition
        self.textColor = textColor
        self.viewBackgroundColor = backgroundColor
        self.containerView = containerView
        self.hintText = hintText
        self.hintLableTargetView = hintLableTargetView
        
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
            tirangelView = TriangleView(frame: CGRect(x: self.hintLableTargetView.center.x, y: self.hintLableTargetView.frame.origin.y - 20, width: 15, height: 20), color: viewBackgroundColor)
            tirangelView.clipsToBounds = true
            addSubview(tirangelView)
            
            bringSubview(toFront: tirangelView)
            
            tirangelView.transform = CGAffineTransform(scaleX: 1, y: -1)
            
            let textLabel = UILabel(frame: .zero)
            textLabel.backgroundColor = viewBackgroundColor
            textLabel.lineBreakMode = .byClipping
            textLabel.numberOfLines = 0
            textLabel.clipsToBounds = true
            textLabel.layer.cornerRadius = 6.0
            textLabel.sizeToFit()
            textLabel.textColor = textColor
            textLabel.text = "\n " + hintText + " \n"
            textLabel.textAlignment = .center
            textLabel.isUserInteractionEnabled = false
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            addSubview(textLabel)
            
            bringSubview(toFront: textLabel)
            
            let fixedWidth = textLabel.frame.size.width
            textLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = textLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = textLabel.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            textLabel.frame = newFrame
            
            if newFrame.size.width > containerView.frame.size.width {
                rectangleRect = CGRect(x: hintLableTargetView.frame.origin.x + (hintLableTargetView.frame.size.width / 2) - (newFrame.size.width / 2), y: hintLableTargetView.frame.origin.y + hintLableTargetView.frame.size.height, width: containerView.frame.size.width - 20, height: 0)
            } else {
                rectangleRect = CGRect(x: hintLableTargetView.frame.origin.x + (hintLableTargetView.frame.size.width / 2) - (newFrame.size.width / 2), y: hintLableTargetView.frame.origin.y + hintLableTargetView.frame.size.height, width: newFrame.size.width, height: 0)
            }
            
            if rectangleRect.minX < 0 {
                let textLabelLayoutConstraint = [
                    NSLayoutConstraint(item: textLabel, attribute: .bottom, relatedBy: .equal, toItem: tirangelView, attribute: .top, multiplier: 1, constant: 0)
                    , NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .equal, toItem: textLabel.superview , attribute: .leading, multiplier: 1, constant: 8)
                    , NSLayoutConstraint(item: textLabel, attribute: .width, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: rectangleRect.size.width)
                ]
                addConstraints(textLabelLayoutConstraint)
            } else if rectangleRect.maxX > containerView.frame.size.width {
                let textLabelLayoutConstraint = [
                    NSLayoutConstraint(item: textLabel, attribute: .bottom, relatedBy: .equal, toItem: tirangelView, attribute: .top, multiplier: 1, constant: 0)
                    , NSLayoutConstraint(item: textLabel, attribute: .trailing, relatedBy: .equal, toItem: textLabel.superview , attribute: .trailing, multiplier: 1, constant: -8)
                    , NSLayoutConstraint(item: textLabel, attribute: .width, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: rectangleRect.size.width)
                ]
                addConstraints(textLabelLayoutConstraint)
            } else {
                let textLabelLayoutConstraint = [
                    NSLayoutConstraint(item: textLabel, attribute: .bottom, relatedBy: .equal, toItem: tirangelView, attribute: .top, multiplier: 1, constant: 0)
                    , NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: tirangelView , attribute: .centerX, multiplier: 1, constant: 0)
                    , NSLayoutConstraint(item: textLabel, attribute: .width, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: rectangleRect.size.width)
                ]
                addConstraints(textLabelLayoutConstraint)
            }
            
        case .bottom:
            tirangelView = TriangleView(frame: CGRect(x: self.hintLableTargetView.center.x - 5, y: self.hintLableTargetView.frame.origin.y + self.hintLableTargetView.frame.size.height + 5, width: 15, height: 20), color: viewBackgroundColor)
            tirangelView.clipsToBounds = true
            addSubview(tirangelView)
            
            let textLabel = UILabel(frame: .zero)
            textLabel.backgroundColor = viewBackgroundColor
            textLabel.lineBreakMode = .byClipping
            textLabel.numberOfLines = 0
            textLabel.clipsToBounds = true
            textLabel.layer.cornerRadius = 6.0
            textLabel.sizeToFit()
            textLabel.textColor = textColor
            textLabel.text = "\n " + hintText + " \n"
            textLabel.textAlignment = .center
            textLabel.isUserInteractionEnabled = false
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            addSubview(textLabel)
            
            bringSubview(toFront: textLabel)
            
            let fixedWidth = textLabel.frame.size.width
            textLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = textLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = textLabel.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            textLabel.frame = newFrame
            
            if newFrame.size.width > containerView.frame.size.width {
                rectangleRect = CGRect(x: hintLableTargetView.frame.origin.x + (hintLableTargetView.frame.size.width / 2) - (newFrame.size.width / 2), y: hintLableTargetView.frame.origin.y + hintLableTargetView.frame.size.height, width: containerView.frame.size.width - 20, height: 0)
            } else {
                rectangleRect = CGRect(x: hintLableTargetView.frame.origin.x + (hintLableTargetView.frame.size.width / 2) - (newFrame.size.width / 2), y: hintLableTargetView.frame.origin.y + hintLableTargetView.frame.size.height, width: newFrame.size.width, height: 0)
            }
            
            if rectangleRect.minX < 0 {
                let textLabelLayoutConstraint = [
                    NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: tirangelView, attribute: .bottom, multiplier: 1, constant: -5)
                    , NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .equal, toItem: textLabel.superview , attribute: .leading, multiplier: 1, constant: 8)
                    , NSLayoutConstraint(item: textLabel, attribute: .width, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: rectangleRect.size.width)
                ]
                addConstraints(textLabelLayoutConstraint)
            } else if rectangleRect.maxX > containerView.frame.size.width {
                let textLabelLayoutConstraint = [
                    NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: tirangelView, attribute: .bottom, multiplier: 1, constant: -5)
                    , NSLayoutConstraint(item: textLabel, attribute: .trailing, relatedBy: .equal, toItem: textLabel.superview , attribute: .trailing, multiplier: 1, constant: -8)
                    , NSLayoutConstraint(item: textLabel, attribute: .width, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: rectangleRect.size.width)
                ]
                addConstraints(textLabelLayoutConstraint)
            } else {
                let textLabelLayoutConstraint = [
                    NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: tirangelView, attribute: .bottom, multiplier: 1, constant: -5)
                    , NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: tirangelView , attribute: .centerX, multiplier: 1, constant: 0)
                    , NSLayoutConstraint(item: textLabel, attribute: .width, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: rectangleRect.size.width)
                ]
                addConstraints(textLabelLayoutConstraint)
            }
            
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
public enum DialogBoxPosition {
    
    case top
    case bottom
    
}
