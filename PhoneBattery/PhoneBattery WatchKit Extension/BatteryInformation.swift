
//
//  BatteryInformation.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 29.07.15.
//  Copyright (c) 2015 Marcel Voss. All rights reserved.
//

import UIKit

class BatteryInformation: NSObject {
    
    class func stringForBatteryState(batteryState: UIDeviceBatteryState) -> String {
        if batteryState == UIDeviceBatteryState.Full {
            return NSLocalizedString("FULL", comment: "")
        } else if batteryState == UIDeviceBatteryState.Charging {
            return NSLocalizedString("CHARGING", comment: "")
        } else if batteryState == UIDeviceBatteryState.Unplugged {
            return NSLocalizedString("REMAINING", comment: "")
        } else {
            return NSLocalizedString("UNKNOWN", comment: "")
        }
    }
   
}
