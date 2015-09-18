//
//  SubmitButton.swift
//  Reception
//
//  Created by Muukii on 8/25/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class SubmitButton: UIControl {
    
    @IBOutlet var iconImageView: UIImageView?
    var backgroundLayer = CAShapeLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.insertSublayer(self.backgroundLayer, atIndex: 0)
        self.backgroundLayer.lineWidth = 2
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.backgroundColor = UIColor.eureColor
        self.backgroundLayer.fillColor = UIColor.eureColor.CGColor
        self.backgroundLayer.strokeColor = UIColor.whiteColor().CGColor
        self.iconImageView?.tintColor = UIColor.whiteColor()
    }
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        
        super.layoutSublayersOfLayer(layer)
        self.backgroundLayer.path = UIBezierPath(ovalInRect: self.bounds).CGPath
    }
    
    override var enabled: Bool {
        get {
            return super.enabled
        }
        set {
            
            super.enabled = newValue
            self.alpha = newValue ? 1 : 0.3
        }
    }
    
    override var highlighted: Bool {
        get {
            
            return super.highlighted
        }
        set {
            
            super.highlighted = newValue
            
            UIView.animateWithDuration(0.2, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                
                if newValue {
                    self.backgroundLayer.fillColor = UIColor.whiteColor().CGColor
                    self.iconImageView?.tintColor = UIColor.eureColor
                } else {
                    self.backgroundLayer.fillColor = UIColor.eureColor.CGColor
                    self.iconImageView?.tintColor = UIColor.whiteColor()
                }
                }) { (finish) -> Void in
            }
            
        }
    }
}