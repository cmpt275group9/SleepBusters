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
    
    override func viewDidLoad() {
        surveyTapped(self)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    @IBAction func consentTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func surveyTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    
}

extension MyProfileViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        //TEST PRINTING FOR RESULTS//
        let results = taskViewController.result.results as? [ORKStepResult]
        for stepResult: ORKStepResult in results!{
            for result in (stepResult.results as [ORKResult]?)!{
                if let questionResult = result as? ORKChoiceQuestionResult {
                    if questionResult.choiceAnswers != nil{
                        print("\(questionResult.identifier), \(questionResult.choiceAnswers!)")
                    }
                }
                else if let questionResult = result as? ORKQuestionResult {
                    if questionResult.answer != nil{
                        print("\(questionResult.identifier), \(questionResult.answer!)")
                    }
                }else{
                    print("No printable results.")
                }
                
            }
            
        }
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}




