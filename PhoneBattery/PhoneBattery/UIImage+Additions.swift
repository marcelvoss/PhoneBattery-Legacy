//
//  UIImage+Additions.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 28.07.15.
//  Copyright (c) 2015 Marcel Voss. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0, 0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
   
}
