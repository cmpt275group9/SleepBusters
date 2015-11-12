/********************************************************
 ***** NOT IMPLEMENTED ****
 LoginViewController.swift
 
 Team Name: PillowSoft
 
 Author(s): TODO: No one yet...
 
 Purpose:  The ViewController for the User Login View
 
 Known Bugs: Issue - Login is currently disabled.
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import UIKit
class LoginViewController:UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBAction func loginButtonPressed(sender: UIButton) {
        login()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mindWave = MindwaveEEG()

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    func login(){
        // TODO: Add Login Logic here
        showTabViewController()
    }
    
    /**
     Shows the Tab View Controller
     */
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