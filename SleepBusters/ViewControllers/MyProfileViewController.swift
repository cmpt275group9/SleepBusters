/********************************************************
 ***** NOT IMPLEMENTED ****
 MyProfileViewController.swift
 
 Team Name: PillowSoft
 
 Author(s): TODO: No one yet...
 
 Purpose:  The ViewController for the MyProfile View
 
 Known Bugs: None
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import UIKit
import ResearchKit

var user = UserProfile()
class MyProfileViewController: UIViewController{
    
    
    
    override func viewDidLoad() {
        var business = Business()
        
        business.getUserProfile(){
            (data: UserProfile, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                var userProfile = data
                // UPDATE LABELS HERE
            }
        }

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
}

