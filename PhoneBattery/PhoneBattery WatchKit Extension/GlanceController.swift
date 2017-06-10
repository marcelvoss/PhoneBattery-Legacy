//
//  GlanceController.swift
//  PhoneBattery WatchKit Extension
//
//  Created by Marcel Voss on 19.06.15.
//  Copyright (c) 2015 Marcel Voss. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    let device = UIDevice.currentDevice()
    var batteryLevel : Float?
    var batteryState : UIDeviceBatteryState!

    @IBOutlet weak var percentageLabel: WKInterfaceLabel!
    @IBOutlet weak var statusLabel: WKInterfaceLabel!
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    @IBOutlet weak var groupItem: WKInterfaceGroup!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        
        device.batteryMonitoringEnabled = true
        batteryLevel = device.batteryLevel
        batteryState = device.batteryState
        
        
        groupItem.setBackgroundImageNamed("frame-")
        
        let level = batteryLevel! * 100
        if level > 0 {
            groupItem.startAnimatingWithImagesInRange(NSMakeRange(0, Int(level)+1), duration: 1, repeatCount: 1)
        } else {
            groupItem.startAnimatingWithImagesInRange(NSMakeRange(0, Int(level)), duration: 1, repeatCount: 1)
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        device.batteryMonitoringEnabled = true
        batteryLevel = device.batteryLevel
        batteryState = device.batteryState
        
        // KVO for oberserving battery level and state
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "batteryLevelChanged:", name: UIDeviceBatteryLevelDidChangeNotification, object: device)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "batteryStateChanged:", name: UIDeviceBatteryStateDidChangeNotification, object: device)
       
        percentageLabel.setText(String(format: "%.f%%", batteryLevel! * 100))
        statusLabel.setText(self.stringForBatteryState(batteryState))
        titleLabel.setText(NSLocalizedString("PHONE_BATTERY", comment: ""))
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func stringForBatteryState(batteryState: UIDeviceBatteryState) -> String {
        if batteryState == UIDeviceBatteryState.Full {
            return NSLocalizedString("FULL", comment: "")
        } else if batteryState == UIDeviceBatteryState.Charging {
            return NSLocalizedString("CHARGING", comment: "")
        } else if batteryState == UIDeviceBatteryState.Unplugged {
            return NSLocalizedString("REMAINING", comment: "")
        } else {
            // State is unknown
            return NSLocalizedString("UNKNOWN", comment: "")
        }
    }
    
    func batteryLevelChanged(notification: NSNotification) {
        batteryLevel = device.batteryLevel
        percentageLabel.setText(String(format: "%.f%%", batteryLevel! * 100))
        
        var level = Int(batteryLevel!) * 100
        groupItem.startAnimatingWithImagesInRange(NSRange(location: 0, length: level), duration: 1, repeatCount: 1)
    }
    
    func batteryStateChanged(notification: NSNotification) {
        batteryState = device.batteryState
        stringForBatteryState(batteryState)
    }
}
