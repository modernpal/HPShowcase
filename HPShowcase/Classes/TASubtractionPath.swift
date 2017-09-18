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

/// Creates a subtraction path that is rectangular.
public class TASubtractionPath: TABaseSubtractionPath {
    /// Total padding applied to the left and the right of ``self.frame``.
    let horizontalPadding: CGFloat
    
    /// Total padding applied to the top and the bottom of ``self.frame``.
    let verticalPadding: CGFloat
    
    /// Rect Radius
    let cornerRadius: CGFloat
    
    /// Is circle
    let shape: Shape
    
    let view: UIView
    
    /// Use to init the path.
    ///
    /// - parameter frame: The frame of the object to enclose.
    /// - parameter horizontalPadding: Total padding applied to the left and the right of the ``frame``.
    /// - parameter verticalPadding: Total padding applied to the top and the bottom of the ``frame``.
    ///
    public init(view: UIView, horizontalPadding: CGFloat = 0, verticalPadding: CGFloat = 0, cornerRadius: CGFloat = 0, shape: Shape = .rectangle) {
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.cornerRadius = cornerRadius
        self.shape = shape
        self.view = view
        super.init(frame: view.frame)
    }
    
    /// Creates a rectangular path with the given padding. The frame is centered in the padding.
    fileprivate override func createPath() -> UIBezierPath {
        var rect = self.frame
        
        // Adjust the origin to center the frame in the padding.
        rect.origin.x -= self.horizontalPadding
        rect.origin.y -= self.verticalPadding
        
        // Adjust the width/height for the padding.
        rect.size.width += 2 * self.horizontalPadding
        rect.size.height += 2 * self.verticalPadding
        
        if shape == .circle {
            return UIBezierPath(arcCenter: CGPoint(x: rect.origin.x + rect.size.width/2,y: rect.origin.y + rect.size.height/2), radius: view.frame.size.height/2, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        } else {
            return UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        }
    }
    
    public enum Shape {
        
        case circle
        case rectangle
        
    }
    
}

/// Creates a subtraction path that is circular.
public class TACircularSubtractionPath: TABaseSubtractionPath {
    
    /// The radius of the circle to subtract.
    let radius: CGFloat
    
    /// Use to init the path.
    ///
    /// - parameter frame: The frame of the object to encircle.
    /// - parameter radius: The radius of the hole. The larger the radius, the larger the hole in the overlay.
    ///
    public init(frame: CGRect, radius: CGFloat = 0) {
        self.radius = radius
        super.init(frame: frame)
    }
    
    /// Creates a circular path with the given radius.
    fileprivate override func createPath() -> UIBezierPath {
        let rect = CGRect(x: self.frame.midX - self.radius, y: self.frame.midY - self.radius,
                          width: 2 * self.radius, height: 2 * self.radius)
        return UIBezierPath(ovalIn: rect)
    }
}



/// Base class to be inherited from when creating new path shapes.
public class TABaseSubtractionPath {
    
    /// The frame of the object that will be visible through the overlay.
    let frame: CGRect
    
    /// The path to be subtracted.
    lazy var bezierPath: UIBezierPath = {
        return self.createPath()
    }()
    
    public init(frame: CGRect) {
        self.frame = frame
    }
    
    /// Creates the path that will be subtracted. Override to customize the shape of the path (circular, rectangular, etc.).
    fileprivate func createPath() -> UIBezierPath {
        return UIBezierPath()
    }
    
}

