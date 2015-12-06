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
    var business = Business()
    var userID = defaults.valueForKey("userId") as! Int

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    override func viewDidLoad() {

        // Do any additional setup after loading the view, typically from a nib.
        firstNameLabel.text = userInfo.firstName
        lastNameLabel.text = userInfo.lastName
        dobLabel.text = String(userInfo.dateOfBirth)
        emailLabel.text = userInfo.userName
        weightLabel.text = String(userInfo.weight)
        heightLabel.text = String(userInfo.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    
}

