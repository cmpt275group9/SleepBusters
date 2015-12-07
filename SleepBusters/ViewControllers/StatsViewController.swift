/********************************************************

StatsViewController.swift

Team Name: PillowSoft

Author(s): Riyadh Almuaili, Klein Gomes, Conrad Yeung

Purpose:  This is the View Controller class for the
Statistics/Summary view. This view is reached from multiple views, and provides
a summary statistic on tracked sleep sessions.

Known Bugs: None

Issues:
*** View constraints on views not fully completed
*** TODO: Implement data from database
*** TODO: Fix/update constraints and overall appearance
*** Currently this View is Simulated

Copyright © 2015 PillowSoft. All rights reserved.

********************************************************/

import UIKit
import Charts
import JBChart

class StatsViewController: UIViewController {
    
    var currentUserSleepSession = UserSleepSession()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var breathLabel: UILabel!
    @IBOutlet weak var SleepApneaDetection: UILabel!
    
    @IBOutlet weak var alcoholImage: UIImageView!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var coffeeImage: UIImageView!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var moodImage: UIImageView!
    
    @IBOutlet weak var pieChartView: PieChartView!
    /*@IBOutlet weak var FeedBackButton: UIButton!
    @IBAction func FeedBackButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("feedbackSegue", sender: nil)
    }
    */
    
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonPressed(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBOutlet weak var sleepPercentages: UILabel!
    
    var sleepType: [String]!

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //print("here)")
        //var business = Business()
        
        //var date =  sender as! NSDate;
        //print("\(date) is selected!")
        
        // business.getUserSleepSessionForDate(self.User.Id, date: date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This contains the clicked user sleep session
        var temp =  self.currentUserSleepSession
        if(temp.id != -1 && temp.id != nil)
        {
            //load piechart
            sleepType = ["light sleep" , "deep sleep", "awake"]
            let sleepHours = [temp.totalLightSleepHours!, temp.totalDeepSleepHours!, temp.totalAwakeHours!]
            setChart(sleepType, values: sleepHours)
            // Do any additional setup after loading the view, typically from a nib.
            
            SleepApneaDetection.text = Respiratory().getDiagnosisMessage(self.currentUserSleepSession.timesApneaDetected!)
            humidityLabel.text = "\(String(temp.averageHumidity!))%"
            tempLabel.text = "\(String(temp.averageTemp!))\u{00B0}C"
            breathLabel.text = "\(String(temp.bpm!)) b/min"
            timeLabel.text = "\(temp.startDate!) - \(temp.endDate!)"
            
            var alcoholimage = UIImage(named: "beer-off.png")!
            if(temp.beerIsOn!){
                alcoholimage = UIImage(named: "beer-on.png")!
            }
            var homeimage = UIImage(named: "nothome.png")!
            if(temp.homeIsOn!){
                homeimage = UIImage(named: "home.png")!
            }
            var coffeeimage = UIImage(named: "coffee-off.png")!
            if (temp.coffeeIsOn!){
                coffeeimage = UIImage(named: "coffee-on.png")!
            }
            var exerciseimage = UIImage(named: "gym-off.png")!
            if (temp.exerciseIsOn!){
                exerciseimage = UIImage(named: "gym-on.png")!
            }
            let faceImages = ["happy.png", "bored.png","tired.png","sad.png","angry.png"]
            
            var moodimage = UIImage(named: faceImages[temp.faceNumber!])!
            
            alcoholImage.image = alcoholimage
            homeImage.image = homeimage
            coffeeImage.image = coffeeimage
            exerciseImage.image = exerciseimage
            moodImage.image = moodimage
            

        } else {
            var t = 2
            var refreshAlert = UIAlertController(title: "No Data", message: "No recorded sleep session found", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Go Back", style: .Default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popToRootViewControllerAnimated(true)
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
        }
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    //Piechart function graphs sleep hours and types of sleep
    func setChart(dataPoints: [String], values: [Double]) {
        pieChartView.noDataText = "No Sleep Data Available."
        
        var dataEntries: [ChartDataEntry] = []
        // piechart data colors
        let colors: [UIColor] = [ UIColor(red: 0.314, green: 0.824, blue: 0.761, alpha: 1),UIColor(red: 0.729, green: 0.467, blue: 1, alpha: 1),UIColor(red: 0.988, green: 0.671, blue: 0.325, alpha: 1) ]
        
        var sum = 0.0;
        var DeepSleepPercentage = 0.0
        var LightSleepPercentage = 0.0
        var AwakePercentage = 0.0
        let deepSleep = values[1]
        let lightSleep = values[0]
        let awake = values[2]
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
            sum += values[i]

        }
        //percentages of sleep types
        DeepSleepPercentage = Double(round(10*((deepSleep / sum ) * 100))/10)
        LightSleepPercentage = Double(round(10*((lightSleep / sum ) * 100))/10)
        AwakePercentage = Double(round(10*((awake / sum ) * 100))/10)
        
        var apneaMessage = Respiratory().getDiagnosisMessage(currentUserSleepSession.timesApneaDetected!)
        //Sleep Percentage Label
        sleepPercentages.text = "  \(LightSleepPercentage)%          \(DeepSleepPercentage)%          \(AwakePercentage)% "
        
        //pie chart dataset
        let chartDataSet = PieChartDataSet(yVals: dataEntries, label: "")
        chartDataSet.valueTextColor = UIColor.clearColor()
        chartDataSet.colors = colors
        let dataSets: [PieChartDataSet] = [ chartDataSet]
        let chartData = PieChartData(xVals: sleepType, dataSets: dataSets)
        pieChartView.data = chartData
        
        //pie chart appearance settings
        pieChartView.holeRadiusPercent = 0.93
        pieChartView.holeColor = UIColor(red:0.067, green:0.055, blue:0.137, alpha: 0)
        pieChartView.descriptionText = ""
        pieChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 0)
        pieChartView.legend.textColor = UIColor.whiteColor()
        pieChartView.centerText = "\(sum) Total Hours"
        pieChartView.centerTextColor = UIColor.whiteColor()
        pieChartView.animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .EaseOutBack)
        

    }

    
}