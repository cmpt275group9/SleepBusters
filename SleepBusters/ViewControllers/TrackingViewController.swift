//
//  SecondViewController.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-02.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import UIKit
import Charts

class TrackingViewController: UIViewController {

    
    @IBOutlet weak var respLineChartView: LineChartView!
    
    var business = Business()
    var counter: Double = 0;
    var chartLegend = [" ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "," ", " "]
    //var months:  ["1:30AM", "1:31AM", "1:32AM", "1:33AM", "1:34AM", "1:35AM", "1:36AM", "1:37AM", "1:38AM", "1:39AM", "1:40AM", "1:41AM"]
    var chartData: [Double] = [50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50,50, 50]

    var lastYearChartData = [75, 88, 79, 95, 72, 55, 90]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        respLineChartView.noDataText = "Connecting..."
        
        view.backgroundColor = UIColor.darkGrayColor()
        
        
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
    
        respLineChartView.leftAxis.customAxisMin = 0
        respLineChartView.leftAxis.customAxisMax = 120
        
        respLineChartView.xAxis.labelPosition = .Bottom
     //   respLineChartView.leftAxis.startAtZeroEnabled = true
        setChart(chartLegend, values: chartData)

        // business.startTracking()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // our code
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("showChart"), userInfo: nil, repeats: true)
    }
    
    func showChart() {
        chartData.removeFirst()
        chartData.append(counter)
        setChart(chartLegend, values: chartData)
        respLineChartView.notifyDataSetChanged(); // let the chart know it's data changed

       
      //  respLineChartView.reloadData()
      //  respLineChartView.setState(.Expanded, animated: false)
        if(counter == 100)
        {
            counter = 0;
        }
        counter++;
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
         var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Respiratory Sensor")
        lineChartDataSet.colors = ChartColorTemplates.liberty()
        
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        respLineChartView.data = lineChartData
        
    }
        
}

