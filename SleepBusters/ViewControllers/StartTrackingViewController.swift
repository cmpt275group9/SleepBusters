/********************************************************
 StartTrackingViewController.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes
 
 Purpose:  The ViewController for the Start Tracking View
 
 Known Bugs: None
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import Foundation
import UIKit

class StartTrackingViewController: UITableViewController {
    
    var coffeeIsOn = false
    var homeIsOn = false
    var beerIsOn = false
    var exerciseIsOn = false
    var currentFaceImage = 0
    let faceImages = ["happy.png", "bored.png","tired.png","sad.png","angry.png"]
    let faceImagesDisplayText = ["Happy", "Bored","Tired","Sad","Angry"]
    
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var coffeeBtn: UIButton!
    @IBOutlet weak var faceBtn: UIButton!
    @IBOutlet weak var beerBtn: UIButton!
    @IBOutlet weak var exerciseBtn: UIButton!
    @IBOutlet weak var faceLabel: UILabel!
    
    @IBAction func faceBtnPressed(sender: UIButton) {
        cycleFace()
    }
    
    @IBAction func homeBtnPressed(sender: UIButton) {
        toggleIcon(homeBtn,onImage: "nothome.png",offImage: "home.png",flag: &homeIsOn)
    }
    
    @IBAction func coffeeBtnPressed(sender: UIButton) {
        toggleIcon(coffeeBtn,onImage: "coffee-off.png",offImage: "coffee-on.png",flag: &coffeeIsOn)
    }
    
    @IBAction func exerciseBtnPressed(sender: UIButton) {
        toggleIcon(exerciseBtn,onImage: "gym-off.png",offImage: "gym-on.png",flag: &exerciseIsOn)
    }
    
    @IBAction func beerBtnPressed(sender: UIButton) {
        toggleIcon(beerBtn,onImage: "beer-off.png",offImage: "beer-on.png",flag: &beerIsOn)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    /**
     These toggle functions below will toggle the icons on/off in the user interface when
     the icon is pressed.
     */
    
    func toggleIcon(uiButton: UIButton, onImage: String, offImage: String,inout flag: Bool ){
        if(flag)
        {
            uiButton.setImage(UIImage(named: offImage), forState: UIControlState.Normal)
            flag = false
            
        } else {
            uiButton.setImage(UIImage(named: onImage), forState: UIControlState.Normal)
            flag = true
        }
    }
    
    
    func cycleFace(){

        if(currentFaceImage == 5)
        {
            currentFaceImage = 0;
        }
        
        faceBtn.setImage(UIImage(named: faceImages[currentFaceImage]), forState: UIControlState.Normal)
        faceLabel.text = faceImagesDisplayText[currentFaceImage]
        currentFaceImage++
    }
    
}