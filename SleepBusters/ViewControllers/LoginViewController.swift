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
    
    var rememberMe = true
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBAction func loginButtonPressed(sender: UIButton) {
        login()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userNamePlaceHolder = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName:UIColor.lightGrayColor()])
        let passwordPlaceHolder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName:UIColor.lightGrayColor()])
        passwordField.attributedPlaceholder = userNamePlaceHolder
        userNameField.attributedPlaceholder = passwordPlaceHolder
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    func login(){
        let alert: UIAlertView = UIAlertView(title: "Signing in", message: "Please wait...", delegate: nil, cancelButtonTitle: nil);
        
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 10, 37, 37)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.setValue(loadingIndicator, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
        alert.show();
        
        let business = Business()
        let userName = "Klein"//userNameField.text!
        let password = "test"//passwordField.text!
        
        business.login(userName,password: password){
            (data: UserProfile, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
               
                alert.dismissWithClickedButtonIndex(0, animated:true )
                let user = data

                let isValidated = user.isValidated!
            
                if (isValidated && self.rememberMe)
                {
                    // Save user login state and show MyProfileViewController
                    // TODO: this bool needs to be set to true when we have an isremember box
                    self.defaults.setBool(false,forKey: "userIsLoggedIn")
                    self.showTabViewController()
                }
                else if (isValidated && self.rememberMe)
                {
                    // Save user login state and show MyProfileViewController
                    self.defaults.setBool(false,forKey: "userIsLoggedIn")
                    self.showTabViewController()
                }
                else
                {
                    // Login Failed: Show message for incorrect username/password
                    let alertFail = UIAlertView()
                    alertFail.title = "Error"
                    alertFail.message = "The username or password is incorrect!"
                    alertFail.addButtonWithTitle("Okay")
                    alertFail.show()
                }
            }
        }
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