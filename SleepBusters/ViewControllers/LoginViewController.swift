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
import ResearchKit

class LoginViewController:UIViewController {
    
    var rememberMe = true
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBAction func loginButtonPressed(sender: UIButton) {
        login()
    }
    
    @IBAction func surveyTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
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

extension LoginViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, stepViewControllerWillAppear stepViewController: ORKStepViewController) {
        if let stepViewController = stepViewController as? ORKWaitStepViewController {
            let registrationStepResult = taskViewController.result.resultForIdentifier("registrationStep") as? ORKStepResult
            let emailQuestionResult = registrationStepResult?.resultForIdentifier(ORKRegistrationFormItemIdentifierEmail) as? ORKTextQuestionResult
            let fnameQuestionResult = registrationStepResult?.resultForIdentifier(ORKRegistrationFormItemIdentifierGivenName) as? ORKTextQuestionResult
            let lnameQuestionResult = registrationStepResult?.resultForIdentifier(ORKRegistrationFormItemIdentifierFamilyName) as? ORKTextQuestionResult
            let passwordQuestionResult = registrationStepResult?.resultForIdentifier(ORKRegistrationFormItemIdentifierPassword) as? ORKTextQuestionResult
            var business = Business()
            
            var userProfile = UserProfile()
            userProfile.userName = emailQuestionResult!.textAnswer
            userProfile.firstName = fnameQuestionResult!.textAnswer
            userProfile.lastName = lnameQuestionResult!.textAnswer
            userProfile.weight = 21
            userProfile.height = 21
            userProfile.gender = 0
            userProfile.password = passwordQuestionResult!.textAnswer
            business.registerUserProfile(userProfile)
                {
                    (data: UserProfile, error: NSError?) -> Void in
                    dispatch_async(dispatch_get_main_queue()) {
                        let delay = 2.5 * Double(NSEC_PER_SEC)
                        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                        dispatch_after(time, dispatch_get_main_queue()) {
                            stepViewController.goForward()
                        }
                    }
                    
            }
            
        }
        //UIView.appearanceWhenContainedInInstancesOfClasses([ORKTaskViewController.self]).backgroundColor = UIColor(red: 16.0/255.0, green: 12.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        //UIView.appearanceWhenContainedInInstancesOfClasses([ORKTaskViewController.self]).tintColor = UIColor.whiteColor()
    }
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        //TEST PRINTING FOR RESULTS//
        let results = taskViewController.result.results as? [ORKStepResult]
        for stepResult: ORKStepResult in results!{
            for result in (stepResult.results as [ORKResult]?)!{
                if let questionResult = result as? ORKChoiceQuestionResult {
                    if questionResult.choiceAnswers != nil{
                        print("\(questionResult.identifier), \(questionResult.choiceAnswers!)")
                        
                        if(questionResult.identifier == "gender")
                        {
                            user.gender = (questionResult.choiceAnswers?.first! as! Int)
                        }
                        
                        
                        
                    }
                }
                else if let questionResult = result as? ORKQuestionResult {
                    if questionResult.answer != nil{
                        print("\(questionResult.identifier), \(questionResult.answer!)")
                        
                        if(questionResult.identifier == "fname")
                        {
                            user.firstName = (questionResult.answer! as! String)
                        }
                        if(questionResult.identifier == "lname")
                        {
                            user.lastName = (questionResult.answer! as! String)
                        }
                        if(questionResult.identifier == "height")
                        {
                            user.height = (questionResult.answer! as! Double)
                        }
                        if(questionResult.identifier == "weight")
                        {
                            user.weight = (questionResult.answer! as! Double)
                        }
                        // TODO Add occupation and Date of birth
                    }
                }else{
                    print("No printable results.")
                }
                
            }
        }
        let business = Business()
        var temp = user
        //business.saveUserProfile(user)
        
        taskViewController.dismissViewControllerAnimated(true, completion: nil)

    }
}