/********************************************************
 StatsViewController.swift
 
 Team Name: PillowSoft
 
 Author(s): Conrad Yeung
 
 Purpose:  The ViewController for the Stats View
 
 Known Bugs: None
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import UIKit
import Charts
import JBChart

class StatsViewController: UIViewController {
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonPressed(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sleepType = ["light sleep" , "deep sleep", "awake"]
        let sleepHours = [5.0, 4.0, 1.0]
        
        setChart(sleepType, values: sleepHours)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///PieChart function
    /// Edited Conrad's BarChart funtion to make it PieChart
    var sleepType: [String]!
    func setChart(dataPoints: [String], values: [Double]) {
        pieChartView.noDataText = "No Sleep Data Available."
        
        
        var dataEntries: [ChartDataEntry] = []
        var colors: [UIColor] = [ UIColor(red: 0.314, green: 0.824, blue: 0.761, alpha: 1),UIColor(red: 0.729, green: 0.467, blue: 1, alpha: 1),UIColor(red: 0.988, green: 0.671, blue: 0.325, alpha: 1) ]

        var sum = 0.0;
        var DeepSleepPercentage = 0.0
        var deepSleep = values[1]
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
            sum += values[i]
            
           // let red = Double(arc4random_uniform(256))
           // let green = Double(arc4random_uniform(256))
            //let blue = Double(arc4random_uniform(256))

            
        }
        
        DeepSleepPercentage = (deepSleep / sum ) * 100
        
        let chartDataSet = PieChartDataSet(yVals: dataEntries, label: "sleep type")
        chartDataSet.colors = colors
        
        
        let dataSets: [PieChartDataSet] = [ chartDataSet]
        let chartData = PieChartData(xVals: sleepType, dataSets: dataSets)
        pieChartView.data = chartData
        
        pieChartView.holeColor = UIColor.clearColor()
        pieChartView.descriptionText = ""
        pieChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 0)
        
        pieChartView.legend.textColor = UIColor.whiteColor()
        pieChartView.centerText = "\( DeepSleepPercentage) % \n Deep Sleep"
        pieChartView.centerTextColor = UIColor.whiteColor()
        pieChartView.animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .EaseInBounce)
        
        //chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        
        
    }

    
}