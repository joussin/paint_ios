//
//  ViewController.swift
//  primitiveDraw
//
//  Created by etudiant-02 on 10/06/2016.
//  Copyright © 2016 etudiant-02. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
        @IBOutlet var tempImageView : UIImageView!
    
    @IBOutlet var RSlider : UISlider!
     @IBOutlet var VSlider : UISlider!
        @IBOutlet var BSlider : UISlider!
    @IBOutlet var ASlider : UISlider!
        @IBOutlet var SSlider : UISlider!
   
    @IBOutlet var previewLabel : UILabel!
    
    
    
    var lastPoint = CGPoint(x: 0, y: 0)
    
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var dessinEnCours = false
    
    
    
    @IBAction func update (sender: AnyObject) {
        red = CGFloat (RSlider.value/255)
        green = CGFloat (VSlider.value/255)
        blue = CGFloat (BSlider.value/255)
        brushWidth = CGFloat (SSlider.value)
        opacity = CGFloat(ASlider.value/10)
        preview ()
    }
    
   func preview () {
        previewLabel.backgroundColor = UIColor.init(red: red, green: green, blue: blue, alpha: opacity)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
        
    }
    
    
    func draw (from: CGPoint, to: CGPoint){
        // 1
        UIGraphicsBeginImageContext(tempImageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height))
        
        // 2
        CGContextMoveToPoint(context, from.x, from.y)
        CGContextAddLineToPoint(context, to.x, to.y)
        
        // 3
        var typeOfCap = CGLineCap.Round //Butt Round Square
        
        var typeOfBlend = CGBlendMode.Hue
        
        CGContextSetLineCap(context, typeOfCap)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetRGBStrokeColor(context, red, green, blue, opacity)
        CGContextSetBlendMode(context, typeOfBlend)
        
        // 4
        CGContextStrokePath(context)
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = 1.0
        UIGraphicsEndImageContext()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            if !dessinEnCours {
                dessinEnCours = true
                lastPoint = touch.locationInView(tempImageView)
                let position = touch.locationInView(tempImageView)
                draw(lastPoint, to: position)
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        if let touch = touches.first {
          let position = touch.locationInView(tempImageView)
            draw(lastPoint, to: position)
            lastPoint = touch.locationInView(tempImageView)
        }
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
        
            dessinEnCours = false
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

