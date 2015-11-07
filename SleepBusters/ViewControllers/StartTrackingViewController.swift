//
//  StartTrackingViewController.swift
//  SleepBusters
//
//  Created by Klein on 2015-11-03.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
import UIKit

class StartTrackingViewController: UITableViewController {
    var coffeeIsOn = false
    var homeIsOn = false
    var beerIsOn = false
    var exerciseIsOn = false
    var currentFaceImage = 0
    var faceImages = ["happy.png", "bored.png","tired.png","sad.png","angry.png"]
    var faceImagesDisplayText = ["Happy", "Bored","Tired","Sad","Angry"]
    
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var coffeeBtn: UIButton!
    @IBOutlet weak var faceBtn: UIButton!
    @IBOutlet weak var beerBtn: UIButton!
    @IBOutlet weak var exerciseBtn: UIButton!
    @IBOutlet weak var faceLabel: UILabel!
    
    @IBAction func homeBtnPressed(sender: UIButton) {
        toggleHome()
    }
    @IBAction func coffeeBtnPressed(sender: UIButton) {
        toggleCoffee()
    }
    
    @IBAction func exerciseBtnPressed(sender: UIButton) {
        toggleExercise()
    }
    
    @IBAction func beerBtnPressed(sender: UIButton) {
        toggleBeer()
    }
    @IBAction func faceBtnPressde(sender: UIButton) {
        cycleFace()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    func toggleCoffee(){
        if(coffeeIsOn)
        {
coffeeBtn.setImage(UIImage(named: "coffee-off.png"), forState: UIControlState.Normal)
            coffeeIsOn = false
            
        } else {
            coffeeBtn.setImage(UIImage(named: "coffee-on.png"), forState: UIControlState.Normal)
            coffeeIsOn = true
        }
    }
    
    func toggleHome(){
        if(homeIsOn)
        {
            homeBtn.setImage(UIImage(named: "nothome.png"), forState: UIControlState.Normal)
            homeIsOn = false

        } else {
            homeBtn.setImage(UIImage(named: "home.png"), forState: UIControlState.Normal)
            homeIsOn = true
        }
    }
    
    func toggleBeer(){
        if(beerIsOn)
        {
            beerBtn.setImage(UIImage(named: "beer-off.png"), forState: UIControlState.Normal)
            beerIsOn = false
        } else {
            beerBtn.setImage(UIImage(named: "beer-on.png"), forState: UIControlState.Normal)
            beerIsOn = true
            
        }
    }
    
    func toggleExercise(){
        if(exerciseIsOn)
        {
            exerciseBtn.setImage(UIImage(named: "gym-off.png"), forState: UIControlState.Normal)
            exerciseIsOn = false
        } else {
           exerciseBtn.setImage(UIImage(named: "gym-on.png"), forState: UIControlState.Normal)
            exerciseIsOn = true
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