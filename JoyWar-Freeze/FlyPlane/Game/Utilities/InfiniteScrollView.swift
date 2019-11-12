// Copyright © 2016 C4
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions: The above copyright
// notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

import UIKit
import Foundation

public class InfiniteScrollView: UIScrollView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        //grab the current content offset (top-left corner)
        var curr = contentOffset
        //if the x value is less than zero
        if curr.x < 0 {
            //update x to the end of the scrollview
            curr.x = contentSize.width - frame.width
            //set the content offset for the view
            contentOffset = curr
        }
            //if the x value is greater than the width - frame width
            //(i.e. when the top-right point goes beyond contentSize.width)
        else if curr.x >= contentSize.width - frame.width {
            //update x to the beginning of the scrollview
            curr.x = 0
            //set the content offset for the view
            contentOffset = curr
        }
    }
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
      //  if let origin = view.superview {
            // Get the Y position of your child view
        let childStartPoint = CGPoint(x:view.frame.origin.x, y:0)//view.frame.origin//origin.convert(view.frame.origin, to: self)
        //print(childStartPoint.x)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x: childStartPoint.x, y: 0, width: self.frame.width, height: 1), animated: animated)
       // }
    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
