//
//  ViewController.swift
//  Demo
//
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

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: ShImageView!
    
    @IBOutlet weak var topSwitch: UISwitch!
    @IBOutlet weak var topLeftSwitch: UISwitch!
    @IBOutlet weak var topRightSwitch: UISwitch!
    @IBOutlet weak var bottomLeftSwitch: UISwitch!
    @IBOutlet weak var bottomRightSwitch: UISwitch!
    @IBOutlet weak var bottomSwitch: UISwitch!
    
    @IBOutlet weak var contentModeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @IBAction func topLeftAction(_ sender: UISwitch) {
        imageView.alignment = .topLeft
        turnOtherOff(current: sender)
    }
    @IBAction func topAction(_ sender: UISwitch) {
        imageView.alignment = .top
        turnOtherOff(current: sender)
    }
    @IBAction func topRightAction(_ sender: UISwitch) {
        imageView.alignment = .topRight
        turnOtherOff(current: sender)
    }
    @IBAction func bottomLeftAction(_ sender: UISwitch) {
        imageView.alignment = .bottomLeft
        turnOtherOff(current: sender)
    }
    @IBAction func bottomRightAction(_ sender: UISwitch) {
        imageView.alignment = .bottomRight
        turnOtherOff(current: sender)
    }
    @IBAction func bottomAction(_ sender: UISwitch) {
        imageView.alignment = .bottom
        turnOtherOff(current: sender)
    }
    var currentImage = 0
    @IBAction func changeImage(_ sender: Any) {
        if currentImage == 0 {
            currentImage = 1
            imageView.image = #imageLiteral(resourceName: "image2")
        } else {
            currentImage = 0
            imageView.image = #imageLiteral(resourceName: "image")
        }
    }
    @IBAction func changeContentMode(_ sender: Any) {
        
        if imageView.contentMode == .scaleAspectFit {
            imageView.contentMode = .scaleAspectFill
            contentModeButton.setTitle("Change to .aspectFit", for: .normal)
        } else {
            imageView.contentMode = .scaleAspectFit
            contentModeButton.setTitle("Change to .aspectFill", for: .normal)
        }
    }
    
    func turnOtherOff(current: UISwitch) {
        for subView in view.subviews {
            if subView == current {
                if !current.isOn {
                    imageView.alignment = .center
                }
                continue
            }
            if subView.isKind(of: UISwitch.self) {
                (subView as! UISwitch).isOn = false
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
