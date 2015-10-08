//
//  AppStartViewController.swift
//  
//
//
//

import UIKit

class AppStartViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController")
        let tabViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TabViewController")
        let appDelegate = UIApplication.sharedApplication().delegate!
        
        if (!defaults.boolForKey("userIsLoggedIn"))
        {
            appDelegate.window!!.rootViewController = loginViewController;
        }
        else{
            appDelegate.window!!.rootViewController = tabViewController;
        }
    }
}
