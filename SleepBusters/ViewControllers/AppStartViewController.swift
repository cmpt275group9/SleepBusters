/********************************************************
 ***** NOT IMPLEMENTED ****
 AppStartViewController.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes
 
 Purpose:  This View Controller will first identify
 if the user is logged in already. It will then 
 determine if the user should be sent to the login 
 view or the my profile view.
 
 Known Bugs: None
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import UIKit

class AppStartViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        var business = Business()
        //
        //        var userProfile = UserProfile()
        //        userProfile.userName = "passwordtest"
        //        userProfile.firstName = "new test"
        //        userProfile.lastName = "last test"
        //        userProfile.weight = 21
        //        userProfile.height = 21
        //        userProfile.gender = 0
        //        userProfile.password = "tested"
        //        business.registerUserProfile(userProfile)
        //            {
        //                (data: UserProfile, error: NSError?) -> Void in
        //                dispatch_async(dispatch_get_main_queue()) {
        //
        //                    var temp = 2;
        //                    
        //                }
        //                
        //        }

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
         self.defaults.setBool(false,forKey: "userIsLoggedIn")
        let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController")
        let tabViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController")
        let appDelegate = UIApplication.sharedApplication().delegate!
        
        if (defaults.boolForKey("userIsLoggedIn"))
        {
            appDelegate.window!!.rootViewController = tabViewController;
        }
        else
        {
            appDelegate.window!!.rootViewController = loginViewController;
        }
    }
}
