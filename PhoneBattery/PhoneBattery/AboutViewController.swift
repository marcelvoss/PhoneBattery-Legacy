//
//  AboutViewController.swift
//  Copyright (c) 2015-2018 Marcel Voss
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit
import MessageUI

class AboutViewController: UITableViewController, MFMailComposeViewControllerDelegate, UIScrollViewDelegate {
    
    var visualEffectView : UIVisualEffectView?
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("WELCOME", comment: "")
        self.navigationController?.navigationBar.tintColor = UIColor(red:0, green:0.86, blue:0.55, alpha:1)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.view.window?.tintColor = UIColor(red:0, green:0.86, blue:0.55, alpha:1)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "sharePressed:")
        
        var headerView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 130))
        let backgroundImageView = UIImageView(image: UIImage(named: "BackgroundImage"))
        backgroundImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, headerView.frame.size.height)
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFit
        headerView.addSubview(backgroundImageView)
        
        let blurEffect = UIBlurEffect(style: .Dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = backgroundImageView.bounds
        backgroundImageView.addSubview(visualEffectView)
        
        let appIconImageView = UIImageView(image: UIImage(named: "MaskedIcon"))
        appIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        appIconImageView.contentMode = UIViewContentMode.ScaleAspectFit
        visualEffectView.addSubview(appIconImageView)
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: appIconImageView, attribute: .CenterY, relatedBy: .Equal, toItem: visualEffectView, attribute: .CenterY, multiplier: 1.0, constant: 0))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: appIconImageView, attribute: .Right, relatedBy: .Equal, toItem: visualEffectView, attribute: .CenterX, multiplier: 1.0, constant: -20))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: appIconImageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 75))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: appIconImageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: 75))
        
        
        let nameLabel = UILabel()
        nameLabel.text = "PhoneBattery"
        nameLabel.font = UIFont.boldSystemFontOfSize(17)
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        visualEffectView.addSubview(nameLabel)
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .CenterY, relatedBy: .Equal, toItem: visualEffectView, attribute: .CenterY, multiplier: 1.0, constant: -7))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Left, relatedBy: .Equal, toItem: appIconImageView, attribute: .Right, multiplier: 1.0, constant: 20))
        
        
        let (shortString, buildString) = DeviceInformation.appIdentifiers()
        
        let versionLabel = UILabel()
        versionLabel.text = String(format: "Version %@ (%@)", shortString, buildString)
        versionLabel.font = UIFont.systemFontOfSize(13)
        versionLabel.textColor = UIColor.whiteColor()
        versionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        visualEffectView.addSubview(versionLabel)
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: versionLabel, attribute: .Top, relatedBy: .Equal, toItem: nameLabel, attribute: .Bottom, multiplier: 1.0, constant: 0))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: versionLabel, attribute: .Left, relatedBy: .Equal, toItem: nameLabel, attribute: .Left, multiplier: 1.0, constant: 0))
        
        self.tableView.tableHeaderView = headerView
        
        
        if NSUserDefaults.standardUserDefaults().boolForKey("hasLaunchedBefore") != true {
            self.showIntroduction()
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLaunchedBefore")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showIntroduction() {
        
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        
        let blurEffect = UIBlurEffect(style: .Dark)
        visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView!.frame = UIScreen.mainScreen().bounds
        visualEffectView!.alpha = 0
        self.navigationController?.view.window?.addSubview(visualEffectView!)
    
        
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        let scrollView = UIScrollView()
        scrollView.pagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, screenHeight * 3)
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        visualEffectView!.addSubview(scrollView)
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .CenterX, relatedBy: .Equal, toItem: visualEffectView!, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .CenterY, relatedBy: .Equal, toItem: visualEffectView!, attribute: .CenterY, multiplier: 1.0, constant: 0))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Width, relatedBy: .Equal, toItem: visualEffectView!, attribute: .Width, multiplier: 1.0, constant: 0))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Height, relatedBy: .Equal, toItem: visualEffectView!, attribute: .Height, multiplier: 1.0, constant: 0))
        
        
        let firstDescription = UILabel()
        firstDescription.setTranslatesAutoresizingMaskIntoConstraints(false)
        firstDescription.textColor = UIColor.whiteColor()
        firstDescription.textAlignment = .Center
        firstDescription.numberOfLines = 0
        firstDescription.font = UIFont.systemFontOfSize(18)
        firstDescription.text = NSLocalizedString("INTRODUCTION_DESCRIPTION_1", comment: "")
        scrollView.addSubview(firstDescription)
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: firstDescription, attribute: .CenterX, relatedBy: .Equal, toItem: scrollView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: firstDescription, attribute: .CenterY, relatedBy: .Equal, toItem: scrollView, attribute: .CenterY, multiplier: 1.0, constant: 20))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: firstDescription, attribute: .Width, relatedBy: .Equal, toItem: visualEffectView, attribute: .Width, multiplier: 1.0, constant: -80))
        
        
        let firstTitle = UILabel()
        firstTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        firstTitle.textColor = UIColor.whiteColor()
        firstTitle.textAlignment = .Center
        firstTitle.numberOfLines = 0
        firstTitle.font = UIFont.boldSystemFontOfSize(25)
        firstTitle.text = NSLocalizedString("INTRODUCTION_GREETING", comment: "")
        scrollView.addSubview(firstTitle)
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: firstTitle, attribute: .CenterX, relatedBy: .Equal, toItem: scrollView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: firstTitle, attribute: .Bottom, relatedBy: .Equal, toItem: firstDescription, attribute: .Top, multiplier: 1.0, constant: -20))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: firstTitle, attribute: .Width, relatedBy: .Equal, toItem: visualEffectView!, attribute: .Width, multiplier: 1.0, constant: -80))
        
        
        
        
        let imageView1 = UIImageView(image: UIImage(named: "WatchImage1"))
        imageView1.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageView1.contentMode = UIViewContentMode.ScaleAspectFit
        scrollView.addSubview(imageView1)
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: imageView1, attribute: .CenterX, relatedBy: .Equal, toItem: scrollView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: imageView1, attribute: .CenterY, relatedBy: .Equal, toItem: scrollView, attribute: .CenterY, multiplier: 1.0, constant: -50 + screenHeight))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: imageView1, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: 200))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: imageView1, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 200))
        
        
        

        let scrollLabel1 = UILabel()
        scrollLabel1.text = NSLocalizedString("SWIPE_UP", comment: "")
        scrollLabel1.textColor = UIColor.whiteColor()
        scrollLabel1.textAlignment = .Center
        scrollLabel1.setTranslatesAutoresizingMaskIntoConstraints(false)
        scrollView.addSubview(scrollLabel1)
        
        scrollView.addConstraint(NSLayoutConstraint(item: scrollLabel1, attribute: .CenterX, relatedBy: .Equal, toItem: scrollView, attribute: .CenterX, multiplier: 1.0, constant: 15))
        
        scrollView.addConstraint(NSLayoutConstraint(item: scrollLabel1, attribute: .Bottom, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: (screenHeight * 1) - 25))
        
        
        
        let arrow1 = UIImageView(image: UIImage(named: "ArrowIcon"))
        arrow1.setTranslatesAutoresizingMaskIntoConstraints(false)
        arrow1.contentMode = .ScaleAspectFit
        scrollView.addSubview(arrow1)
        
        scrollView.addConstraint(NSLayoutConstraint(item: arrow1, attribute: .Right, relatedBy: .Equal, toItem: scrollLabel1, attribute: .Left, multiplier: 1.0, constant: -15))
        
        scrollView.addConstraint(NSLayoutConstraint(item: arrow1, attribute: .CenterY, relatedBy: .Equal, toItem: scrollLabel1, attribute: .CenterY, multiplier: 1.0, constant: 0))
        
        scrollView.addConstraint(NSLayoutConstraint(item: arrow1, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant:18))
        
        
        
        let scrollLabel2 = UILabel()
        scrollLabel2.text = NSLocalizedString("SWIPE_UP", comment: "")
        scrollLabel2.textColor = UIColor.whiteColor()
        scrollLabel2.textAlignment = .Center
        scrollLabel2.setTranslatesAutoresizingMaskIntoConstraints(false)
        scrollView.addSubview(scrollLabel2)
        
        scrollView.addConstraint(NSLayoutConstraint(item: scrollLabel2, attribute: .CenterX, relatedBy: .Equal, toItem: scrollView, attribute: .CenterX, multiplier: 1.0, constant: 15))
        
        scrollView.addConstraint(NSLayoutConstraint(item: scrollLabel2, attribute: .Bottom, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: (screenHeight * 2) - 25))
        
        
        
        let arrow2 = UIImageView(image: UIImage(named: "ArrowIcon"))
        arrow2.setTranslatesAutoresizingMaskIntoConstraints(false)
        arrow2.contentMode = .ScaleAspectFit
        scrollView.addSubview(arrow2)
        
        scrollView.addConstraint(NSLayoutConstraint(item: arrow2, attribute: .Right, relatedBy: .Equal, toItem: scrollLabel2, attribute: .Left, multiplier: 1.0, constant: -15))
        
        scrollView.addConstraint(NSLayoutConstraint(item: arrow2, attribute: .CenterY, relatedBy: .Equal, toItem: scrollLabel2, attribute: .CenterY, multiplier: 1.0, constant: 0))
        
        scrollView.addConstraint(NSLayoutConstraint(item: arrow2, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant:18))
        
        
        
        
        
        let secondDescription = UILabel()
        secondDescription.setTranslatesAutoresizingMaskIntoConstraints(false)
        secondDescription.textColor = UIColor.whiteColor()
        secondDescription.textAlignment = .Center
        secondDescription.numberOfLines = 0
        secondDescription.font = UIFont.systemFontOfSize(18)
        secondDescription.text = NSLocalizedString("INTRODUCTION_DESCRIPTION_2", comment: "")
        scrollView.addSubview(secondDescription)
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: secondDescription, attribute: .CenterX, relatedBy: .Equal, toItem: scrollView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: secondDescription, attribute: .Top, relatedBy: .Equal, toItem: imageView1, attribute: .Bottom, multiplier: 1.0, constant: 20))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: secondDescription, attribute: .Width, relatedBy: .Equal, toItem: visualEffectView!, attribute: .Width, multiplier: 1.0, constant: -80))
        
        
        let imageView2 = UIImageView(image: UIImage(named: "WatchImage2"))
        imageView2.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageView2.contentMode = UIViewContentMode.ScaleAspectFit
        scrollView.addSubview(imageView2)
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: imageView2, attribute: .CenterX, relatedBy: .Equal, toItem: scrollView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: imageView2, attribute: .CenterY, relatedBy: .Equal, toItem: scrollView, attribute: .CenterY, multiplier: 1.0, constant: -50 + screenHeight * 2))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: imageView2, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: 200))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: imageView2, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 200))
        
        
        let thirdDescription = UILabel()
        thirdDescription.setTranslatesAutoresizingMaskIntoConstraints(false)
        thirdDescription.textColor = UIColor.whiteColor()
        thirdDescription.textAlignment = .Center
        thirdDescription.numberOfLines = 0
        thirdDescription.font = UIFont.systemFontOfSize(18)
        thirdDescription.text = NSLocalizedString("INTRODUCTION_DESCRIPTION_3", comment: "")
        scrollView.addSubview(thirdDescription)
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: thirdDescription, attribute: .CenterX, relatedBy: .Equal, toItem: scrollView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: thirdDescription, attribute: .Top, relatedBy: .Equal, toItem: imageView2, attribute: .Bottom, multiplier: 1.0, constant: 20))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: thirdDescription, attribute: .Width, relatedBy: .Equal, toItem: visualEffectView!, attribute: .Width, multiplier: 1.0, constant: -80))
        
        
        
        let closeButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        closeButton.setTitle(NSLocalizedString("CLOSE", comment: ""), forState: .Normal)
        closeButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        closeButton.layer.cornerRadius = 14
        closeButton.layer.masksToBounds = true
        closeButton.setBackgroundImage(UIImage.imageWithColor(UIColor.whiteColor()), forState: .Normal)
        closeButton.addTarget(self, action: "closeIntroduction", forControlEvents: UIControlEvents.TouchUpInside)
        closeButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        scrollView.addSubview(closeButton)
        
        scrollView.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .CenterX, relatedBy: .Equal, toItem: scrollView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
        scrollView.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 45))
        
        visualEffectView!.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .Bottom, relatedBy: .Equal, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: -30 + screenHeight * 3))
        
        scrollView.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1.0, constant: -40))
    
        
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.visualEffectView!.alpha = 1
        }) { (finished) -> Void in
            
        }
    }
    
    func closeIntroduction() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.visualEffectView!.alpha = 0
                UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
            }) { (finished) -> Void in
                self.visualEffectView?.removeFromSuperview()
        }
    }
    
    func sharePressed(barButton: UIBarButtonItem) {
        let activityVC = UIActivityViewController(activityItems: [NSLocalizedString("SHARE_TITLE", comment: ""), NSURL(string: "https://itunes.apple.com/us/app/phonebattery-your-phones-battery/id1009278300?ls=1&mt=8")!], applicationActivities: nil)
        
        self.presentViewController(activityVC, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if section == 0 {
            return 3
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 2
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("GENERAL", comment: "").uppercaseString
        } else if section == 1 {
            return NSLocalizedString("WHO_MADE_THIS", comment: "").uppercaseString
        } else if section == 2 {
            return NSLocalizedString("MORE", comment: "").uppercaseString
        }
        return ""
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            var headerView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 30))
            
            let thanksLabel = UILabel()
            thanksLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
            thanksLabel.text = NSLocalizedString("THANKS_DOWNLOADING", comment: "")
            thanksLabel.textAlignment = .Center
            thanksLabel.font = UIFont.systemFontOfSize(12)
            thanksLabel.numberOfLines = 0
            thanksLabel.textColor = UIColor(red:0.48, green:0.48, blue:0.5, alpha:1)
            headerView.addSubview(thanksLabel)
            
            headerView.addConstraint(NSLayoutConstraint(item: thanksLabel, attribute: .CenterX, relatedBy: .Equal, toItem: headerView, attribute: .CenterX, multiplier: 1.0, constant: 0))
            
            headerView.addConstraint(NSLayoutConstraint(item: thanksLabel, attribute: .Top, relatedBy: .Equal, toItem: headerView, attribute: .Top, multiplier: 1.0, constant: 5))
            
            headerView.addConstraint(NSLayoutConstraint(item: thanksLabel, attribute: .Width, relatedBy: .Equal, toItem: headerView, attribute: .Width, multiplier: 1.0, constant: -50))
            
            return headerView
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                return 75
            }
        }
        return 44
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier") as! UITableViewCell?
        var cell2 = tableView.dequeueReusableCellWithIdentifier("cellidentifier2") as! CreatorTableViewCell?
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellIdentifier")
            cell2 = CreatorTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellIdentifier2")
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0   {
                cell?.textLabel?.text = NSLocalizedString("SUPPORT", comment: "")
                cell?.accessoryType = .DisclosureIndicator
            } else if indexPath.row == 1 {
                cell?.textLabel?.text = NSLocalizedString("INTRODUCTION", comment: "")
                cell?.accessoryType = .DisclosureIndicator
            } else if indexPath.row == 2 {
                cell?.textLabel?.text = NSLocalizedString("RATE_ON_STORE", comment: "")
                cell?.accessoryType = .DisclosureIndicator
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell2 = CreatorTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellIdentifier2")
                cell2?.nameLabel.text = "Marcel Voss"
                cell2?.jobLabel.text = NSLocalizedString("JOB_TITLE", comment: "")
                cell2?.avatarImageView.image = UIImage(named: "MarcelAvatar")
                return cell2!
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell?.textLabel?.text = NSLocalizedString("PB_TWITTER", comment: "")
                cell?.accessoryType = .DisclosureIndicator
            } else if indexPath.row == 1 {
                cell?.textLabel?.text = NSLocalizedString("AVAILABLE_GITHUB", comment: "")
                cell?.accessoryType = .DisclosureIndicator
            }
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                if MFMailComposeViewController.canSendMail() {
                    let mailComposer = MFMailComposeViewController()
                    mailComposer.mailComposeDelegate = self
                    mailComposer.navigationBar.tintColor = UIColor(red:0, green:0.86, blue:0.55, alpha:1)
                    
                    let device = UIDevice.currentDevice()
                    let (shortString, buildString) = DeviceInformation.appIdentifiers()
                    
                    let subjectString = String(format: "Support PhoneBattery: %@ (%@)", shortString, buildString)
                    let bodyString = String(format: "\n\n\n----\niOS Version: %@\nDevice: %@\n", device.systemVersion, DeviceInformation.hardwareIdentifier())
                    
                    mailComposer.setMessageBody(bodyString, isHTML: false)
                    mailComposer.setSubject(subjectString)
                    mailComposer.setToRecipients(["help@marcelvoss.com"])
                    
                    self.presentViewController(mailComposer, animated: true, completion: nil)
                }
            } else if indexPath.row == 1 {
                self.showIntroduction()
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            } else if indexPath.row == 2 {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                UIApplication.sharedApplication().openURL(NSURL(string: "https://itunes.apple.com/us/app/phonebattery-your-phones-battery/id1009278300?ls=1&mt=8")!)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                UIApplication.sharedApplication().openURL(NSURL(string: "http://twitter.com/uimarcel")!)
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/phonebatteryapp")!)
            } else if indexPath.row == 1 {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/marcelvoss/PhoneBattery")!)
            }
        }
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
