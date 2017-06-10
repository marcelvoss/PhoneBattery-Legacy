//
//  DeviceInformation.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 29.07.15.
//  Copyright (c) 2015 Marcel Voss. All rights reserved.
//

import UIKit

class DeviceInformation: NSObject {
    
    class func hardwareIdentifier() -> String {
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, &name, 0)
        var hw_machine = [CChar](count: Int(size), repeatedValue: 0)
        sysctl(&name, 2, &hw_machine, &size, &name, 0)
        
        let hardware: String = String.fromCString(hw_machine)!
        return hardware
    }
    
    class func appIdentifiers() -> (String, String) {
        let shortString = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let buildString = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
        
        return (shortString, buildString)
    }
   
}
