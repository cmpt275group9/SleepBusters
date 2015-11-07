/********************************************************
 
 TabBarController.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes, Conrad Yeung
 
 Purpose:  This is the View Controller class for the 
 calendar view. The Calendar used in this class is the
 open source CVCalendar.
 
 Known Bugs: None
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import Foundation
import Charts
import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var barChartView: BarChartView!

    var business = Business()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden == true
        //calendar
        //barchart
        var testSleepData = business.getUserSleepSessions(1, startDate: NSDate(), endDate: NSDate())
        
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    
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
        //let ll = ChartLimitLine(limit: 4.0, label: "Recommended Deep Sleep")
        //ll.valueTextColor = UIColor.whiteColor()
        //ll.lineColor = UIColor(red:255/255, green: 20/255, blue: 60/255, alpha: 0.6)
        //barChartView.rightAxis.addLimitLine(ll)
        
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
    
    func didSelectDayView(dayView: CVCalendarDayView, animationDidFinish: Bool) {
        print("\(dayView.date.commonDescription) is selected!")
    }
    
/*    func presentedDateUpdated(date: CVDate) {
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .Center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
            
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
                self.monthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransformIdentity
                
                }) { _ in
                    
                    self.animationFinished = true
                    self.monthLabel.frame = updatedMonthLabel.frame
                    self.monthLabel.text = updatedMonthLabel.text
                    self.monthLabel.transform = CGAffineTransformIdentity
                    self.monthLabel.alpha = 1
                    updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }*/
    
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

// MARK: - CVCalendarViewDelegate
/*
extension ViewController: CVCalendarViewDelegate {
func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.Circle)
circleView.fillColor = .colorFromCode(0xCCCCCC)
return circleView
}

func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
if (dayView.isCurrentDay) {
return true
}
return false
}

func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
let π = M_PI

let ringSpacing: CGFloat = 3.0
let ringInsetWidth: CGFloat = 1.0
let ringVerticalOffset: CGFloat = 1.0
var ringLayer: CAShapeLayer!
let ringLineWidth: CGFloat = 4.0
let ringLineColour: UIColor = .blueColor()

let newView = UIView(frame: dayView.bounds)

let diameter: CGFloat = (newView.bounds.width) - ringSpacing
let radius: CGFloat = diameter / 2.0

let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)

ringLayer = CAShapeLayer()
newView.layer.addSublayer(ringLayer)

ringLayer.fillColor = nil
ringLayer.lineWidth = ringLineWidth
ringLayer.strokeColor = ringLineColour.CGColor

let ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
let ringRect: CGRect = CGRectInset(rect, ringLineWidthInset, ringLineWidthInset)
let centrePoint: CGPoint = CGPointMake(ringRect.midX, ringRect.midY)
let startAngle: CGFloat = CGFloat(-π/2.0)
let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)

ringLayer.path = ringPath.CGPath
ringLayer.frame = newView.layer.bounds

return newView
}

func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
if (Int(arc4random_uniform(3)) == 1) {
return true
}

return false
}
}
*/

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
    /*@IBAction func switchChanged(sender: UISwitch) {
        if sender.on {
            calendarView.changeDaysOutShowingState(false)
            shouldShowDaysOut = true
        } else {
            calendarView.changeDaysOutShowingState(true)
            shouldShowDaysOut = false
        }
    }*/
    
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