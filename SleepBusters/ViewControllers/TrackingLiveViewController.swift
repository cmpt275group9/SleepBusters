//
//  SecondViewController.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-02.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import UIKit
import JBChart



class TrackingLiveViewController:


UIViewController,JBLineChartViewDelegate, JBLineChartViewDataSource {
    //@IBOutlet weak var pieChartView: PieChartView!
    
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
        
        view.backgroundColor = ui.getGlobalBGColor()
        
        // Make the chart background colour the same as the view
        respLineChart.backgroundColor = ui.getGlobalBGColor()
        
        respLineChart.delegate = self
        respLineChart.dataSource = self
        respLineChart.minimumValue = 0
        respLineChart.maximumValue = 100
        respLineChart.reloadData()
       
        respLineChart.setState(.Collapsed, animated: false)
        
        // business.startTracking()
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
    
    
}

