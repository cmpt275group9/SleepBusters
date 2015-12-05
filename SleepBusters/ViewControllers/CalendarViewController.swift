/********************************************************
 
 CalendarViewController.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes, Conrad Yeung
 
 Purpose:  This is the View Controller class for the 
 calendar view. The Calendar used in this class is the
 open source CVCalendar.
 
 Known Bugs: None
 
 Issues:
 *** Some Functions and Extensions code is sample code provided by ios-charts
 *** TODO: Review code that we will not use in SleepBusters.
 *** TODO: Implement Real Hardware Sensor Values
 *** Currently this View is Simulated
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import Foundation
import Charts
import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var barChartView: BarChartView!
    var currentUserSleepSession = UserSleepSession()
    var business = Business()
    let days = ["1", "2", "3", "4", "5", "6", "7"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get Calendar
        // TODO: Get the real user id (hardcoded 3 for now)
        let n = 7;
        business.getLastNSleepSessions(3,n: n){ (data: [UserSleepSession], error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                var lightSleepHours: [Double] = []
                var deepSleepHours: [Double] = []
                var awakeHours: [Double] = []
                
                for var i = 0; i < n; i++ {
                    lightSleepHours.append(data[i].totalLightSleepHours!)
                    deepSleepHours.append(data[i].totalDeepSleepHours!)
                    awakeHours.append(data[i].totalAwakeHours!)
                }
                
                self.setChart(self.days, values: awakeHours, values2: lightSleepHours, values3: deepSleepHours)
            }
        }

        navigationController?.navigationBarHidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    
    }
    

    func setChart(dataPoints: [String], values: [Double], values2: [Double], values3: [Double]) {
        barChartView.noDataText = "Loading Data"
        
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
        chartDataSet.colors = [UIColor(red: 0.988, green: 0.671, blue: 0.325, alpha: 1)]
        
        let chartDataSet2 = BarChartDataSet(yVals: dataEntries2, label: "Light Sleep Hours")
        chartDataSet2.colors = [UIColor(red: 0.314, green: 0.824, blue: 0.761, alpha: 1)]
        
        let chartDataSet3 = BarChartDataSet(yVals: dataEntries3, label: "Deep Sleep Hours")
        chartDataSet3.colors = [UIColor(red: 0.729, green: 0.467, blue: 1, alpha: 1)]
        
        let dataSets: [BarChartDataSet] = [ chartDataSet, chartDataSet2, chartDataSet3]
        let chartData = BarChartData(xVals: days, dataSets: dataSets)
        chartData.setValueTextColor(UIColor.clearColor())
        barChartView.data = chartData
        
        barChartView.reloadInputViews()
        barChartView.resetViewPortOffsets()
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
        barChartView.animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .EaseInOutExpo)
        
    }
}
extension CalendarViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    // MARK: Optional methods
    
    func shouldShowWeekdaysOut() -> Bool {
        return true
    }
    
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "calendarSegue") {
            let svc = segue!.destinationViewController as! StatsViewController;
            svc.currentUserSleepSession = self.currentUserSleepSession
        }
    }
    
    func didSelectDayView(dayView: CVCalendarDayView, animationDidFinish: Bool) {
        print("test")
        calendarView.selected = false
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        
        let date1 = dateFormatter.stringFromDate(dayView.date.convertedDate()!)
        
        var business = Business()
        var sleepSession = business.getUserSleepSessionForDate(date1){ (data: UserSleepSession, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.currentUserSleepSession = data
                if self.calendarView.selected {self.performSegueWithIdentifier("calendarSegue", sender: nil)}
            }
        }

        

    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        let day = dayView.date.day
        let randomDay = Int(arc4random_uniform(31))
        if day == randomDay {
            return true
        }
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        
        let red = CGFloat(arc4random_uniform(600) / 255)
        let green = CGFloat(arc4random_uniform(600) / 255)
        let blue = CGFloat(arc4random_uniform(600) / 255)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        let numberOfDots = Int(arc4random_uniform(3) + 1)
        switch(numberOfDots) {
        case 2:
            return [color, color]
        case 3:
            return [color, color, color]
        default:
            return [color] // return 1 dot
        }
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 13
    }
    
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .Short
    }
    
}



// MARK: - CVCalendarViewAppearanceDelegate

extension CalendarViewController: CVCalendarViewAppearanceDelegate {
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
}

// MARK: - IB Actions

extension CalendarViewController {
    
    @IBAction func todayMonthView() {
        calendarView.toggleCurrentDayView()
    }
    
    /// Switch to WeekView mode.
    @IBAction func toWeekView(sender: AnyObject) {
        calendarView.changeMode(.WeekView)
    }
    
    /// Switch to MonthView mode.
    @IBAction func toMonthView(sender: AnyObject) {
        calendarView.changeMode(.MonthView)
    }
    
    @IBAction func loadPrevious(sender: AnyObject) {
        calendarView.loadPreviousView()
    }
    
    
    @IBAction func loadNext(sender: AnyObject) {
        calendarView.loadNextView()
    }
}

// MARK: - Convenience API Demo

extension CalendarViewController {
    func toggleMonthViewWithMonthOffset(offset: Int) {
        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(NSDate()) // from today
        
        components.month += offset
        
        let resultDate = calendar.dateFromComponents(components)!
        
        self.calendarView.toggleViewWithDate(resultDate)
    }
    
    func didShowNextMonthView(date: NSDate)
    {
        //        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(date) // from today
        calendarView.selected = false
        print("Showing Month: \(components.month)")
    }
    
    
    func didShowPreviousMonthView(date: NSDate)
    {
        //        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(date) // from today
        
        print("Showing Month: \(components.month)")
    }
    
}