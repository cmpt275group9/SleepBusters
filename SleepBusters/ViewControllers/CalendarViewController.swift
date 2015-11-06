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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        days = ["1", "2", "3", "4", "5", "6", "7"]
        let sleepHours = [5.0, 4.0, 6.0, 3.0, 7.0, 9.0, 4.0]
        let awakeHours = [3.0, 2.0, 2.0, 3.0, 1.0, 2.0, 2.0]
        
        setChart(days, values: sleepHours, values2: awakeHours)
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
    func setChart(dataPoints: [String], values: [Double], values2: [Double]) {
        barChartView.noDataText = "No Sleep Data Available."
        
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries2: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        for i in 0..<dataPoints.count {
            let dataEntry2 = BarChartDataEntry(value: values2[i], xIndex: i)
            dataEntries2.append(dataEntry2)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Sleep Hours")
        chartDataSet.colors = [UIColor(red: 50/255, green: 75/255, blue: 50/255, alpha: 1)]
        let chartDataSet2 = BarChartDataSet(yVals: dataEntries2, label: "Awake Hours")
        chartDataSet2.colors = [UIColor(red: 50/255, green: 50/255, blue: 75/255, alpha: 1)]
        
        let dataSets: [BarChartDataSet] = [ chartDataSet, chartDataSet2]
        let chartData = BarChartData(xVals: days, dataSets: dataSets)
        barChartView.data = chartData
        
        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        barChartView.gridBackgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        barChartView.xAxis.labelPosition = .Bottom

        barChartView.animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .EaseInBounce)
        let ll = ChartLimitLine(limit: 8.0, label: "Recommended Sleep")
        barChartView.rightAxis.addLimitLine(ll)
        
    }
}