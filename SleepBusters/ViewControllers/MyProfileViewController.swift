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

class MyProfileViewController: UIViewController{
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    override func viewDidLoad() {
        var business = Business()
        
        business.getUserProfile(){
            (data: UserProfile, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                var userProfile = data
                
                self.firstNameLabel.text = userProfile.firstName
                self.lastNameLabel.text = userProfile.lastName
                self.dobLabel.text = "November 20, 1993"
                self.emailLabel.text = userProfile.userName
                var labelFormat = ".0"
                self.weightLabel.text = String.localizedStringWithFormat("%.0f lbs", userProfile.weight!)
                self.heightLabel.text = String.localizedStringWithFormat("%.0f cm", userProfile.height!)
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

