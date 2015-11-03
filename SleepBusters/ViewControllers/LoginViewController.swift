//
//  LoginViewController.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-03.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import UIKit
class LoginViewController:UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var business = Business()
    var rememberMe = false;

    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBAction func loginButtonPressed(sender: UIButton) {
        login()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    func login(){
        let loginName = userNameField.text!
        let password  = passwordField.text!
        let user = business.validateLogin(loginName, password: password)
        showTabViewController()
        
        // Code for Login Button OnClick Event
        ////////////////////////////////////
        //        let userId = user.Id
        //       let isValidated = user.IsValidated
        //        if (isValidated && rememberMe)
        //        {
        //            // Save user login state and show MyProfileViewController
        //            defaults.setBool(true,forKey: "userIsLoggedIn")
        //            showTabViewController()
        //        }
        //        else if (isValidated && !rememberMe)
        //        {
        //            // Save user login state and show MyProfileViewController
        //            defaults.setBool(false,forKey: "userIsLoggedIn")
        //            showTabViewController()
        //        }
        //        else
        //        {
        //            // Login Failed: Show message for incorrect username/password
        //            let alert = UIAlertView()
        //            alert.title = "Error"
        //            alert.message = "The username or password is incorrect!"
        //            alert.addButtonWithTitle("Okay")
        //            alert.show()
        //        }
        ////////////////////////////////////
        // END CODE FOR OnClick Login
        
    }
    
    func showTabViewController(){
        let tabViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController")
        let appDelegate = UIApplication.sharedApplication().delegate!
        appDelegate.window!!.rootViewController = tabViewController;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}