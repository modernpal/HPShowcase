# HPShowcase

![alt text](http://uupload.ir/files/up9t_group_3.png)

[![CI Status](http://img.shields.io/travis/Aerox1/HPShowcase.svg?style=flat)](https://travis-ci.org/Aerox1/HPShowcase)
[![Version](https://img.shields.io/cocoapods/v/HPShowcase.svg?style=flat)](http://cocoapods.org/pods/HPShowcase)
[![License](https://img.shields.io/cocoapods/l/HPShowcase.svg?style=flat)](http://cocoapods.org/pods/HPShowcase)
[![Platform](https://img.shields.io/cocoapods/p/HPShowcase.svg?style=flat)](http://cocoapods.org/pods/HPShowcase)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Features

- [x] Describe more than one component with one dialog box.
- [x] Set dialog box in bottom or top of your component.
- [x] Adjusting component in circle shape.
- [x] Self resizing to fit in the screen.
- [x] Customizing dialog box in the way you want.
  
## Requirements

```
Xcode 8.0+ / Swift 3
iOS 8.0+
```  
## Installation

#### CocoaPods
HPShowcase is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HPShowcase'
```
#### Manually
You just need to drag ShowcaseController.swift , TASubtractionPath.swift , TAOverlayView.swift and TriangleView.swift into your project.

## Usage
All thing you have to do is to complete below function:
```swift
ShowcaseController.instance.showHelp(helps: [TAOverlayView], targetVireController: UIViewController)
```
So you have to pass an array from TAOverlayView with your targetViewController. Lets create our first TAOverlayView:
```swift
TAOverlayView(subtractedPaths: [TASubtractionPath], hintLableTargetView: UIView, hintText: String, containerView: UIView, backgroundColor: UIColor, textColor: UIColor, boxPosition: DialogBoxPosition)
```
- [x] subtractedPaths are the paths that you want to be shown in HPShowcase. If you want to show more than one component to user , create multiple subtractedPaths.
- [x] hintLableTargetView is the view that you want to put dialog box under or top of it.
- [x] hintText is your text that will be shown to user.
- [x] containerView is a view that contains all of your hintLableTargetViews.
- [x] backgroundColor parameter is backgroundColor of dialog box.
- [x] textColor parameter is textColor of hint label.
- [x] DialogBoxPosition is an enum to allow you put your dialog box on top or on bottom of hintLableTargetView.

So just one more thing , now we create TASubtractionPath:
```swift
TASubtractionPath(view: UIView, horizontalPadding: CGFloat = 0, verticalPadding: CGFloat = 0, cornerRadius: CGFloat = 0, shape: Shape = .rectangle)
```
- [x] view will be shown to user in a shape.
- [x] horizontalPadding is padding from left and right.
- [x] verticalPadding is padding from top and bottom.
- [x] cornerRadius can make corners of your shape(It is a square by default) to be curved.
- [x] shape is an enum that allow you to make circle or square shapes.
#### Delegate
You can access to HPShowcase delegate by:
```swift
ShowcaseController.instance.delegate
```
Do what you want after all things:
```swift
func helpShowFinished() {
    // You can set a perfrence for that
 }
```
## Author

- [Arash Farahani](http://github.com/aerox1)
- [Mehdi Gilanpour](http://github.com/mrealblack)
Also thanks to [Nick Yap](https://github.com/nyapster) for the idea of overlay.

## License

HPShowcase is available under the MIT license. See the LICENSE file for more info.
