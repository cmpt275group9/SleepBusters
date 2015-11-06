//
//  SecondViewController.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-02.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import UIKit
import JBChart
import Charts




class TrackingLiveViewController:


UIViewController,JBLineChartViewDelegate, JBLineChartViewDataSource {
    @IBOutlet weak var pieChartView: PieChartView!
   // var business = Business()
    @IBOutlet weak var respLineChart: JBLineChartView!
    @IBAction func btnStopTracking(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    var counterPie = 0.00
    var counter = 5;
    var chartLegend = [""]
    var chartData = [50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50 ]
    var lastYearChartData = [75, 88, 79, 95, 72, 55, 90]
    var ui = UserInterfaceHelpers()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden == true
        
        view.backgroundColor = UIColor.clearColor()
        
        // Make the chart background colour the same as the view
        respLineChart.backgroundColor = UIColor.clearColor()
        
        respLineChart.delegate = self
        respLineChart.dataSource = self
        respLineChart.minimumValue = 0
        respLineChart.maximumValue = 100
        respLineChart.reloadData()
       
        respLineChart.setState(.Collapsed, animated: false)
        
        // business.startTracking()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //var testSleepData = business.getUserSleepSession(1, startDate: NSDate(), endDate: NSDate())
        
        
        
        sleepType = ["light\n sleep" , "deep\n sleep", "awake"]
        let sleepHours = [5.0, 4.0, 1.0]

        
        
        setChart(sleepType, values: sleepHours)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        let footerView = UIView(frame: CGRectMake(0, 0, respLineChart.frame.width, 16))
        
        print("viewDidLoad: \(respLineChart.frame.width)")
        
        let footer1 = UILabel(frame: CGRectMake(0, 0, respLineChart.frame.width/2 - 8, 16))
        footer1.textColor = UIColor.whiteColor()
        footer1.text = "\(chartLegend[0])"
        
        let footer2 = UILabel(frame: CGRectMake(respLineChart.frame.width/2 - 8, 0, respLineChart.frame.width/2 - 8, 16))
        footer2.textColor = UIColor.whiteColor()
        footer2.text = "\(chartLegend[chartLegend.count - 1])"
        footer2.textAlignment = NSTextAlignment.Right
        
        footerView.addSubview(footer1)
        footerView.addSubview(footer2)
        
        let header = UILabel(frame: CGRectMake(0, 0, respLineChart.frame.width, 50))
        header.textColor = UIColor.whiteColor()
        header.font = UIFont.systemFontOfSize(14)
        header.text = "Respiratory Signal"
        header.textAlignment = NSTextAlignment.Center
        
        respLineChart.footerView = footerView
        respLineChart.headerView = header
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBarHidden = true
        
        // our code
        respLineChart.reloadData()
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("showChart"), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        hideChart()
    }
    
    func hideChart() {
        respLineChart.setState(.Collapsed, animated: true)
    }
    
    func showChart() {
        chartData.removeFirst()
        var temp = 25+abs(70*sin(counterPie))
      
        chartData.append(Int(temp))
        respLineChart.reloadData()
        respLineChart.setState(.Expanded, animated: false)


        counterPie = counterPie + 0.02;

    }
    
    // MARK: JBlineChartView
    
    func numberOfLinesInLineChartView(lineChartView: JBLineChartView!) -> UInt {
        return 1
    }
    
    func lineChartView(lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        if (lineIndex == 0) {
            return UInt(chartData.count)
        } else if (lineIndex == 1) {
            return UInt(lastYearChartData.count)
        }
        
        return 0
    }
    
    func lineChartView(lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        if (lineIndex == 0) {
            
            return CGFloat(chartData[Int(horizontalIndex)])
        } else if (lineIndex == 1) {
            return CGFloat(lastYearChartData[Int(horizontalIndex)])
        }
        
        return 0
    }
    
    
    // This is the line colour of the char (the outline)
    func lineChartView(lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
//        if (lineIndex == 0) {
//            return UIColor.lightGrayColor()
//        } else if (lineIndex == 1) {
//            return UIColor.whiteColor()
//        }
        
        return UIColor(red: 68.0/255, green: 131.0/255, blue: 132.0/255, alpha: 0)
    }
    
    // This is the fill colour of the chart
    func lineChartView(lineChartView: JBLineChartView!, fillColorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor(red: 68.0/255, green: 131.0/255, blue: 132.0/255, alpha: 1.0)
    }
    
    func lineChartView(lineChartView: JBLineChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        return false
    }
    
    func lineChartView(lineChartView: JBLineChartView!, colorForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.lightGrayColor()
    }
    
    func lineChartView(lineChartView: JBLineChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        if (lineIndex == 0) { return true }
        else if (lineIndex == 1) { return true }
        
        return true
    }
    
    func lineChartView(lineChartView: JBLineChartView!, didSelectLineAtIndex lineIndex: UInt, horizontalIndex: UInt) {
        if (lineIndex == 0) {
            //      let data = chartData[Int(horizontalIndex)]
            //      let key = chartLegend[Int(horizontalIndex)]
            //      informationLabel.text = "Weather on \(key): \(data)"
        } else if (lineIndex == 1) {
            //      let data = lastYearChartData[Int(horizontalIndex)]
            //      let key = chartLegend[Int(horizontalIndex)]
            //      informationLabel.text = "Weather last year on \(key): \(data)"
        }
    }
    
    func didDeselectLineInLineChartView(lineChartView: JBLineChartView!) {
        //  informationLabel.text = ""
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
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
        var colors: [UIColor] = []

        
        var sum = 0.0;
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
            sum += values[i]
            
            
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
            
        }
        
    
        
        let chartDataSet = PieChartDataSet(yVals: dataEntries, label: "sleep hours")
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        
        let dataSets: [PieChartDataSet] = [ chartDataSet]
        let chartData = PieChartData(xVals: sleepType, dataSets: dataSets)
        pieChartView.data = chartData
        
        
        
        
        pieChartView.descriptionText = ""
        pieChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 0)
        
        pieChartView.legend.textColor = UIColor.whiteColor()
        pieChartView.centerText = "\( sum ) \n Hours \n completed"
     
     
        pieChartView.animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .EaseInBounce)
        
        //chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        chartDataSet.colors = ChartColorTemplates.colorful()

        
    }

    
    
}

