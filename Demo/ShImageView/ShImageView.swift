//
//  ShImageView.swift
/*
 MIT License
 
 Copyright (c) 2018 Shoaib Sarwar Cheema
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit

enum ShAlignmentMask {
    case center, top, bottom, left, right
    case topLeft, topRight, bottomLeft, bottomRight
}

class ShImageView: UIImageView {

    // This property holds the current alignment
    var alignment: ShAlignmentMask = .center {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    // Make the UIImageView scale only up or down
    // This are used only if the content mode is Scaled
    var enableScaleUp = true, enableScaleDown = true
    
    // Just in case you need access to the inner image view
//    should be readonly
    private var realImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        self.setup()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        realImageView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        realImageView.contentMode = self.contentMode
        addSubview(realImageView)
        // Move any image we might have from this container to the real image view
        
        if super.image != nil {
            let img = super.image
            super.image = nil
            self.image = img!
        }
    }
    
    
    override var image: UIImage? {
        get {
            return realImageView.image
        }
        set(value) {
            realImageView.image = value
            self.setNeedsLayout()
        }
    }
    
    override var contentMode: UIViewContentMode {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    
    override func layoutSubviews() {
        
        let realsize = realContentSize()
        
        // Start centered
        var realframe = CGRect(x: (self.bounds.size.width - realsize.width)/2, y: (self.bounds.size.height - realsize.height) / 2, width: realsize.width, height: realsize.height);
        
        if (alignment == .left || alignment == .topLeft || alignment == .bottomLeft) {
            realframe.origin.x = 0;
        }
        else if (alignment == .right || alignment == .topRight || alignment == .bottomRight) {
            realframe.origin.x = self.bounds.maxX - realframe.size.width
        }
        
        if (alignment == .top || alignment == .topLeft || alignment == .topRight) {
            realframe.origin.y = 0;
        }
        else if (alignment == .bottom || alignment == .bottomLeft || alignment == .bottomRight) {
            realframe.origin.y = self.bounds.maxY - realframe.size.height;
        }
        
        realImageView.frame = realframe;
        
        // Make sure we clear the contents of this container layer, since it refreshes from the image property once in a while.
        self.layer.contents = nil;
    }
    
    private func realContentSize() -> CGSize {
       
        var size = self.bounds.size
        if self.image == nil {
            return size
        }
        var scalex = self.bounds.size.width / realImageView.image!.size.width;
        var scaley = self.bounds.size.height / realImageView.image!.size.height;
        
        switch contentMode {
        case .scaleAspectFit:
            
            var scale = min(scalex, scaley)
            
            if ((scale > 1 && !enableScaleUp) ||
                (scale < 1 && !enableScaleDown)) {
                scale = 1.0;
            }
            size = CGSize(width: realImageView.image!.size.width * scale, height: realImageView.image!.size.height * scale)
            break
        case .scaleAspectFill:
            var scale = max(scalex, scaley)
            if ((scale > 1 && !enableScaleUp) ||
                (scale < 1 && !enableScaleDown)) {
                scale = 1
            }
            size = CGSize(width: realImageView.image!.size.width * scale, height: realImageView.image!.size.height * scale)
            break
        case .scaleToFill:
            if ((scalex > 1.0 && !enableScaleUp) ||
                (scalex < 1.0 && !enableScaleDown)) {
                scalex = 1.0;
            }
            if ((scaley > 1.0 && !enableScaleUp) ||
                (scaley < 1.0 && !enableScaleDown)) {
                scaley = 1.0;
            }
            
            size = CGSize(width: realImageView.image!.size.width * scalex,height:  realImageView.image!.size.height * scaley);
            break
        default:
            size = realImageView.image!.size;
            break
        }
       
        return size;
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return realImageView.sizeThatFits(size)
    }
    
}
