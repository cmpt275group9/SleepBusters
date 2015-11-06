//
//  CalendarViewController.swift
//  SleepBusters
//
//  Created by Klein on 2015-11-03.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
import Charts
import UIKit

class CalendarViewController: UIViewController {
    

    @IBOutlet weak var barChartView: BarChartView!

    var business = Business()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var testSleepData = business.getUserSleepSession(1, startDate: NSDate(), endDate: NSDate())
        
        days = ["1", "2", "3", "4", "5", "6", "7"]
        var lightSleepHours: [Double] = []
        var deepSleepHours: [Double] = []
        var awakeHours: [Double] = []
    
        for var i = 1; i < 8; i++ {
            lightSleepHours.append(testSleepData[i].TotalLightSleepHours!)
            deepSleepHours.append(testSleepData[i].TotalDeepSleepHours!)
            awakeHours.append(testSleepData[i].TotalAwakeHours!)
        }
        setChart(days, values: awakeHours, values2: lightSleepHours, values3: deepSleepHours)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    var days: [String]!
    func setChart(dataPoints: [String], values: [Double], values2: [Double], values3: [Double]) {
        barChartView.noDataText = "No Sleep Data Available."
        
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries2: [BarChartDataEntry] = []
        var dataEntries3: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
            
            let dataEntry2 = BarChartDataEntry(value: values2[i], xIndex: i)
            dataEntries2.append(dataEntry2)
            
            let dataEntry3 = BarChartDataEntry(value: values3[i], xIndex: i)
            dataEntries3.append(dataEntry3)
        }

        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Awake Hours")
        chartDataSet.colors = [UIColor(red: 255/255, green: 165/255, blue: 0, alpha: 1)]
        
        let chartDataSet2 = BarChartDataSet(yVals: dataEntries2, label: "Light Sleep Hours")
        chartDataSet2.colors = [UIColor(red: 151/255, green: 252/255, blue: 151/255, alpha: 1)]
        
        let chartDataSet3 = BarChartDataSet(yVals: dataEntries3, label: "Deep Sleep Hours")
        chartDataSet3.colors = [UIColor(red: 0, green: 191/255, blue: 255/255, alpha: 1)]
        
        let dataSets: [BarChartDataSet] = [ chartDataSet, chartDataSet2, chartDataSet3]
        let chartData = BarChartData(xVals: days, dataSets: dataSets)
        chartData.setValueTextColor(UIColor.clearColor())
        barChartView.data = chartData
        
        // color settings for chart
        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 0)
        barChartView.gridBackgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 0)
        barChartView.xAxis.labelPosition = .Bottom
        barChartView.legend.textColor = UIColor.whiteColor()
        barChartView.xAxis.labelTextColor = UIColor.whiteColor()
        barChartView.descriptionText = ""
        barChartView.leftAxis.labelTextColor = UIColor.whiteColor()
        barChartView.rightAxis.labelTextColor = UIColor.whiteColor()
        //clear grid
        barChartView.leftAxis.gridColor = UIColor.clearColor()
        barChartView.rightAxis.gridColor = UIColor.clearColor()
        barChartView.xAxis.gridColor = UIColor.clearColor()
    
        barChartView.animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .EaseInBounce)
        let ll = ChartLimitLine(limit: 4.0, label: "Recommended Deep Sleep")
        ll.valueTextColor = UIColor.whiteColor()
        ll.lineColor = UIColor(red:255/255, green: 20/255, blue: 60/255, alpha: 0.6)
        barChartView.rightAxis.addLimitLine(ll)
        
    }
}