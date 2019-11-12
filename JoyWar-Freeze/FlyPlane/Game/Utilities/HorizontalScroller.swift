//
//  HorizontalScroller.swift
//  HebrewKeyboard
//
//  Created by Daniel Slupskiy on 12.04.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

@objc protocol HorizontalScrollerDelegate {
    // ask the delegate how many views he wants to present inside the horizontal scroller
    func numberOfViewsForHorizontalScroller(_ scroller: HorizontalScroller) -> Int
    // ask the delegate to return the view that should appear at <index>
    func horizontalScrollerViewAtIndex(_ scroller: HorizontalScroller, index:Int) -> UIView
    // inform the delegate what the view at <index> has been clicked
    func horizontalScrollerClickedViewAtIndex(_ scroller: HorizontalScroller, index:Int)
    // ask the delegate for the index of the initial view to display. this method is optional
    // and defaults to 0 if it's not implemented by the delegate
    @objc optional func initialViewIndex(_ scroller: HorizontalScroller) -> Int
    
    @objc optional func horizontalScrollerClicked(_ scroller: HorizontalScroller, at view: UIView)
    
    //func showSavedMessage()
    
   // var isLearningMode: Bool { get }
    
    //func userDidTapActionButton()
}

class HorizontalScroller: UIView {
    weak var delegate: HorizontalScrollerDelegate?
    
    fileprivate let VIEW_PADDING: CGFloat = 5
    fileprivate let VIEW_HEIGHT: CGFloat = 30.0
    fileprivate var VIEW_WIDTH: CGFloat?
    fileprivate var VIEWS_OFFSET: CGFloat?
    fileprivate var swipeDirection: ScrollerSwipeDirecrion = .right
    fileprivate var lastContentOffset: CGFloat = 0.0
    
    enum ScrollerSwipeDirecrion {
        case right
        case left
    }
    
    //Constants
    let itemCoprnerRadius: CGFloat = 5.0
    
    var scroller : UIScrollView!
    
   /* override func layoutSubviews() {
        super.layoutSubviews()
        //if (Catboard.instance.textDocumentProxy.keyboardAppearance == UIKeyboardAppearance.dark) {
            scroller.layer.backgroundColor = UIColor(red: CGFloat(45)/CGFloat(255), green: CGFloat(45)/CGFloat(255), blue: CGFloat(45)/CGFloat(255), alpha: 1).cgColor
            self.layer.backgroundColor = UIColor(red: CGFloat(45)/CGFloat(255), green: CGFloat(45)/CGFloat(255), blue: CGFloat(45)/CGFloat(255), alpha: 1).cgColor
        //}
    }*/
    
    var viewArray = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeScrollView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initializeScrollView()
    }
    
    func initializeScrollView() {
        
        scroller = UIScrollView()
        scroller.delegate = self
        scroller.frame = self.bounds // FIX: delete
        addSubview(scroller)
        
        VIEW_WIDTH = (frame.size.width / 3) - (VIEW_PADDING * 2)
        VIEWS_OFFSET = VIEW_WIDTH
        
        scroller.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        let tapRecognizer = UITapGestureRecognizer(target: self, action:#selector(HorizontalScroller.scrollerTapped(_:)))
        scroller.addGestureRecognizer(tapRecognizer)
        
        scroller.backgroundColor = UIColor(red: 231/255 , green: 231/255, blue: 231/255, alpha: 1)
    }

    
    func viewAtIndex(_ index :Int) -> UIView {
        return viewArray[index]
    }
    
    func scrollerTapped(_ gesture: UITapGestureRecognizer) {
        
        if !scroller.subviews.isEmpty {
            let location = gesture.location(in: gesture.view)
            if let delegate = delegate {
                for index in 0..<delegate.numberOfViewsForHorizontalScroller(self) {
                    
                    //if let view = scroller.subviews[index] as? ActionViewItem {
                    let view = scroller.subviews[index]
                        if view.frame.contains(location) {
                            delegate.horizontalScrollerClickedViewAtIndex(self, index: index)
                            scroller.setContentOffset(CGPoint(x: view.frame.origin.x - self.frame.size.width / 2 + view.frame.size.width / 2, y: 0), animated:true)
                            
                      /*      if view.isCentered {
                                if KeyboardManager.checkFullAccess() {
                                    AnalyticsManager.send(interfaceEvent: .speakerPressed)
                                }
                                
                                view.tapAnimation(with: gesture.location(in: gesture.view?.superview))
                                view.pronounce()
                                
                                
                            } else {
                                if KeyboardManager.checkFullAccess() {
                                    AnalyticsManager.send(interfaceEvent: .upperBarPressed)
                                }
                            }
                            for view in scroller.subviews as! [ActionViewItem] {
                                view.isCentered = false
                            }
                            view.isCentered = true*/
                            break
                        }
                    //}
                }
            }
        }
    }
    
    func centerView(withIndex index:Int) {
//        guard let aViewArray = viewArray as? [ActionViewItem] else { return }
        
        for view in viewArray {
          //  view.isCentered = false
        }
        let view = viewArray[index]
       // view.isCentered = true
        scroller.setContentOffset(CGPoint(x: view.frame.origin.x - self.frame.size.width / 2 + view.frame.size.width / 2, y: 0), animated:true)
        if let delegate = delegate {
            delegate.horizontalScrollerClickedViewAtIndex(self, index: index)
        }
    }
 
  /*  func center(view: ActionViewItem) {
        guard let aViewArray = viewArray as? [ActionViewItem] else { return }
        
        for view in aViewArray {
            view.isCentered = false
        }
        view.isCentered = true
        scroller.setContentOffset(CGPoint(x: view.frame.origin.x - self.frame.size.width / 2 + view.frame.size.width / 2, y: 0), animated:true)
        if let delegate = delegate {
            delegate.horizontalScrollerClicked?(self, at: view)
        }
    }*/
    
    func reload() {
                
        if let delegate = delegate{
            
            viewArray = []
            let views: Array = scroller.subviews
            for view in views {
                view.removeFromSuperview()
            }
            var xValue = VIEWS_OFFSET!
            for index in 0..<delegate.numberOfViewsForHorizontalScroller(self) {
                xValue += VIEW_PADDING
                let view = delegate.horizontalScrollerViewAtIndex(self, index: index) //as! ActionViewItem
                view.layer.masksToBounds = true
                view.layer.cornerRadius = itemCoprnerRadius
                var viewWidth: CGFloat = 285
                viewWidth = max(viewWidth, VIEW_WIDTH!)
                viewWidth = min(viewWidth, frame.size.width*0.75)
                view.frame = CGRect(x:CGFloat(xValue), y:CGFloat(VIEW_PADDING), width:CGFloat(viewWidth), height:CGFloat(VIEW_HEIGHT))
                scroller.addSubview(view)
                xValue += viewWidth + VIEW_PADDING
                viewArray.append(view)
            }
            scroller.contentSize = CGSize(width:CGFloat(xValue + VIEWS_OFFSET!), height:frame.size.height)
         
            let maxIndex = scroller.subviews.count - 1
            if (scroller.subviews.count > 1) && (maxIndex > 0) {
                let randomIndex = arc4random_uniform(UInt32(maxIndex - 1))
                centerView(withIndex: Int(randomIndex + 1))
            }
            if let initialView = delegate.initialViewIndex?(self) {
                scroller.setContentOffset(CGPoint(x: CGFloat(initialView)*CGFloat((VIEW_WIDTH! + (2 * VIEW_PADDING))), y: 0), animated: true)
            }
            scroller.isHidden = false
        }
    }
    
    fileprivate func centerCurrentView(_ scrollView: UIScrollView) {
        let location = CGPoint(x: scrollView.contentOffset.x + scrollView.frame.size.width / 2, y: scrollView.frame.size.height / 2)
        let locationWithLeftPadding = CGPoint(x: scrollView.contentOffset.x + scrollView.frame.size.width / 2 + 10, y: scrollView.frame.size.height / 2)
        let locationWithRightPadding = CGPoint(x: scrollView.contentOffset.x + scrollView.frame.size.width / 2 - 10, y: scrollView.frame.size.height / 2)
        for view in scrollView.subviews {
            switch swipeDirection {
            case .left:
                if view.frame.contains(location) || view.frame.contains(locationWithLeftPadding) {
            //        guard let view = view as? ActionViewItem else { return }
                    //center(view: view)
                }
            default:
                if view.frame.contains(location) || view.frame.contains(locationWithRightPadding) {
            //        guard let view = view as? ActionViewItem else { return }
                    //center(view: view)
                }
            }
        }
    }
}

extension HorizontalScroller: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if !decelerate {
                centerCurrentView(scrollView)
            }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerCurrentView(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentOffset > scrollView.contentOffset.x {
            swipeDirection = .right
        } else if lastContentOffset < scrollView.contentOffset.x {
            swipeDirection = .left
        }
        lastContentOffset = scrollView.contentOffset.x
    }
}

