/********************************************************
 
 TrackingLiveViewController.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes, Conrad Yeung
 
 Purpose:  This is the View Controller for the main
 live tracking view. All live tracking data should be 
 invoked and displayed from this view controller.
 
 Known Bugs: None
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import UIKit
import JBChart
import Charts
import CoreBluetooth
import Foundation



class TrackingLiveViewController:UIViewController,JBLineChartViewDelegate, JBLineChartViewDataSource, CBCentralManagerDelegate, CBPeripheralDelegate,TGAccessoryDelegate {
    
    @IBOutlet weak var radarChartView: RadarChartView!
    @IBOutlet weak var respLineChart: JBLineChartView!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBAction func btnStopTracking(sender: UIButton) {
        stopTracking()
    }
    let defaults = NSUserDefaults.standardUserDefaults()
    
    // EEG Sensor: (Simulated Data)
    var counterPie = 0.00
    var counter = 5;
    var chartLegend = [""]
    var eegValues = [5.0, 4.0, 1.0, 2.0, 3.0]
    var chartData = [0]
    var lastYearChartData = [75, 88, 79, 95, 72, 55, 90]
    /**************************************************/
    
    // Respiratory Sensor: (Live Data)
    let isEEGSimulate = false
    let isRespiratorySimulate = true
    
    let btName = "HMSoft"
    let btServiceID = "FFE0"
    let btCharacteristicId = "FFE1"
    var centralManager:CBCentralManager!
    var blueToothReady = false
    var peripheral: CBPeripheral?
    var characteristics: CBCharacteristic!
    var terminalChar:CBCharacteristic!
    var countIndex = 0;
    var startDate = NSDate()
    var data = [0]
    var tempData = [0]
    var humidityData = [0]
    var tempAverage = 0.0
    var humidityAverage = 0.0
    //var respiratory = Respiratory()
    /**************************************************/
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
        view.backgroundColor = UIColor.clearColor()
        // Make the chart background colour the same as the view
        respLineChart.backgroundColor = UIColor.clearColor()
        respLineChart.delegate = self
        respLineChart.dataSource = self
        respLineChart.minimumValue = 100
        respLineChart.maximumValue = 300
        respLineChart.reloadData()
        respLineChart.setState(.Collapsed, animated: false)
        
        for var index = 0; index < 200; index++
        {
            chartData.append(50)
        }
        
        eegType = ["Delta" , "Theta", "Alpha", "Beta", "Gamma" ]
        setChart(eegType, values: eegValues)
        
        if(isRespiratorySimulate == false){
            // Respiratory Sensor
            centralManager = CBCentralManager(delegate: self, queue: nil)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        
        // Repiratory Init
        let header = UILabel(frame: CGRectMake(0, 0, respLineChart.frame.width, 50))
        header.textColor = UIColor.whiteColor()
        header.font = UIFont.systemFontOfSize(14)
        header.textAlignment = NSTextAlignment.Left
        respLineChart.headerView = header
        
        // EEG Init
        if(!isEEGSimulate)
        {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let accessoryType: TGAccessoryType = UInt(defaults.integerForKey("accessory_type_preference"))
        let manager =  TGAccessoryManager.sharedTGAccessoryManager()
        manager.setupManagerWithInterval(0.05, forAccessoryType: accessoryType)
        manager.delegate = self
        manager.rawEnabled = true
        
        if TGAccessoryManager.sharedTGAccessoryManager().accessory != nil {
            NSLog("ThinkGearTouch version: %d", TGAccessoryManager.sharedTGAccessoryManager().getVersion())
            TGAccessoryManager.sharedTGAccessoryManager().startStream()
        }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBarHidden = true
        respLineChart.reloadData()
        
        // Create Timers that will Redraw the Chart every 100ms for respiratory and 1 second for EEG
        if(isRespiratorySimulate){
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateRespiratoryChart"), userInfo: nil, repeats: true)
        }
        if(isEEGSimulate)
        {
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateEEGChart"), userInfo: nil, repeats: true)
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        hideChart()
    }
    
    func hideChart() {
        respLineChart.setState(.Collapsed, animated: true)
    }
    
     var dataRandom = 0
    var isLocked = false;
    func updateRespiratoryChart()
    {
        //print(countIndex)
        
        
        if(countIndex > 630 && countIndex < 875)
        {
           
            if(isLocked == false)
            {
                dataRandom = Int(data.last!)
                isLocked = true
            }
            if(isLocked)
            {
                var dataTolerance =  dataRandom + Int((Double(arc4random_uniform(10))*1.5))
                data.append(dataTolerance)
                chartData.removeFirst()
                chartData.append(Int(dataTolerance))
            }
        }
        else
        {
            let temp = Int(200+abs(70*sin(counterPie)))
            data.append(Int(temp))
            counterPie = counterPie + 0.02;
            chartData.removeFirst()
            chartData.append(Int(temp))
        }
        
        
        respLineChart.reloadData()
        respLineChart.setState(.Expanded, animated: false)
        counterPie = counterPie + 0.02;
//            chartData.removeFirst()
//            let temp = 150+abs(70*sin(counterPie))
//            chartData.append(Int(temp))
//            respLineChart.reloadData()
//            respLineChart.setState(.Expanded, animated: false)
//            counterPie = counterPie + 0.02;
        countIndex++;
    }
    
    func updateEEGChart(){
        for var index = 1; index < 4; index++
        {
            eegValues[index] = Double(Int(arc4random_uniform(10)));
            let randomIndex = Int(arc4random_uniform(4))
            eegValues[randomIndex] = 10
        }
//        var sleepStat = UserSensorStat()
//        sleepStat.EegLowAlpha = Int(arc4random_uniform(10))
//        Business().saveSleepStat(sleepStat)
//
        setChart(eegType, values: eegValues)
    }
    
    
    // MARK: JBlineChartView
    // Functions below are methods to change JBChart Properties
    
    /**
    Draws the Pie chart in a given view on the user interface.
    - parameter dataPoints: The data points for the pie chart.
    - parameter values: The values for the pie chart.
    */
    var eegType: [String]!
    func setChart(dataPoints: [String], values: [Double]) {
        
        radarChartView.noDataText = "No Sleep Data Available."
        var dataEntries: [ChartDataEntry] = []
        var colors: [UIColor] = []
        var sum = 0.0;
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
            sum += values[i]
            let color = UIColor.greenColor()
            colors.append(color)
        }
        
        let chartDataSet = RadarChartDataSet(yVals: dataEntries, label: "EEG Frequency")
        
     
        chartDataSet.drawFilledEnabled = true;
        chartDataSet.lineWidth = 2.0

        chartDataSet.colors = [UIColor.whiteColor()]
        let dataSets: [RadarChartDataSet] = [ chartDataSet]
        let chartData = RadarChartData(xVals: eegType, dataSets: dataSets)
        
        
        radarChartView.data = chartData
        chartData.setValueTextColor(UIColor.clearColor())
        radarChartView.descriptionText = ""
        radarChartView.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0)
        radarChartView.legend.textColor = UIColor.whiteColor()
        radarChartView.xAxis.labelTextColor = UIColor.whiteColor()
        radarChartView.xAxis.axisLineColor = UIColor.greenColor()
        radarChartView.yAxis.axisLineWidth = 100.0
        radarChartView.webColor = UIColor.grayColor()
        radarChartView.innerWebColor = UIColor.grayColor()
        radarChartView.yAxis.labelTextColor = UIColor.clearColor()
        radarChartView.yAxis.startAtZeroEnabled = true

        
        radarChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .EaseInBounce)
        
    }
    
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Respiratory Sensor
    // Functions below are related to the Arduino Bluetooth stream
    func startUpCentralManager() {
        print("Init Central manager")
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    func discoverDevices() {
        print("Discovering Devices...")
        centralManager.scanForPeripheralsWithServices(nil, options: nil)
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        if(peripheral.name == btName) {
            print("Discovered \(peripheral.name)")
            centralManager!.stopScan()
            self.peripheral = peripheral
            peripheral.delegate = self
            centralManager!.connectPeripheral(peripheral, options: nil)
        }
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID(string: btServiceID)])
        let state = peripheral.state == CBPeripheralState.Connected ? "yes" : "no"
        print("Connected:\(state)")
        
    }
    
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        
        var svc:CBService
        for svc in peripheral.services! {
            print(svc)
            print("Service \(svc)\n")
            print("Discovering Characteristics for  : \(svc)")
            peripheral.discoverCharacteristics([CBUUID(string: btCharacteristicId)],forService: svc as CBService)
        }
    }
    
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
     
        if (error != nil) {
            return
        }
        
        for characteristic in service.characteristics! {
            if characteristic.UUID == CBUUID(string: btCharacteristicId) {
                self.terminalChar = (characteristic as CBCharacteristic)
                peripheral.setNotifyValue(true, forCharacteristic: characteristic as CBCharacteristic)
                print(peripheral.readValueForCharacteristic(characteristic as CBCharacteristic))
                
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        
        if (characteristic.UUID.UUIDString == btCharacteristicId) {
            
            let stream = characteristic.value
            let dataString = String(data: stream!, encoding: NSUTF8StringEncoding)
            var streamValues =  dataString!.characters.split{$0 == ","}.map(String.init)
            
            print(streamValues.count)
            if(streamValues.count == 3)
            {
                let humidity = streamValues[0]
                let temp = streamValues[1]
                let respiratory  = streamValues[2].stringByReplacingOccurrencesOfString("\r\n", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
                chartData.removeFirst()
                chartData.append(Int(respiratory)!)
                respLineChart.reloadData()
                respLineChart.setState(.Expanded, animated: false)
                lblHumidity.text = "Humidity: " + humidity + " %"
                lblTemperature.text = "Temperature: " + temp + " C"
                
                if(humidityAverage == 0 || tempAverage == 0)
                {
                    humidityAverage = Double(humidity)!
                    tempAverage =  Double(temp)!
                }
                else
                {
                    humidityAverage = (humidityAverage + Double(humidity)!)/2
                    tempAverage = (tempAverage + Double(temp)!)/2
                }
                print("value: \(dataString)")
            }
            
        }
        
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        print("State Check:")
        switch (central.state) {
        case .PoweredOff:
            print("Powered off")
            
        case .PoweredOn:
            print("Powered On")
            blueToothReady = true;
            
        case .Resetting:
            print("Resetting")
            
        case .Unauthorized:
            print("Unauthorized")
            
        case .Unknown:
            print("Unknown");
            
        case .Unsupported:
            print("Unsupported");
            
        }
        if blueToothReady {
            discoverDevices()
        }
    }
    
    
    // MARK: EEG Sensor
    // Functions below are related to the EEG Sensor
    func accessoryDidDisconnect() -> Void {
        
        
    }
    
    func accessoryDidConnect(accessory:EAAccessory) -> Void{
        TGAccessoryManager.sharedTGAccessoryManager().startStream()
    }
    
    
    var eegBusiness = Business()
    func dataReceived(data: [NSObject : AnyObject]) {
       
        if (data["poorSignal"] != nil) {

        let signal = data["poorSignal"]!.intValue
        print("signal")
        print(signal)
            
        if (signal < 200 ) {
            var sleepStat = UserSensorStat()
            
            if (data["blinkStrength"] != nil) {
                let blinkStrength = data["blinkStrength"]!.intValue
                print("blink")
                print(blinkStrength)
            }
            if (data["eegDelta"] != nil) {
                let delta = data["eegDelta"]!.intValue
                eegValues[0] = Double(delta)
                sleepStat.EegDelta = Int(delta)
            }
            if (data["eegTheta"] != nil) {
                let theta = data["eegTheta"]!.intValue
                eegValues[1] = Double(theta)
                sleepStat.EegTheta = Int(theta)
            }
            if (data["eegHighAlpha"] != nil) {
                let highAlpha = data["eegHighAlpha"]!.intValue
                eegValues[2] = Double(highAlpha)
                sleepStat.EegHighAlpha = Int(highAlpha)
            }
            if (data["eegHighBeta"] != nil) {
                let highBeta = data["eegHighBeta"]!.intValue
                eegValues[3] = Double(highBeta)
                sleepStat.EegHighBeta = Int(highBeta)
            }
            if (data["eegHighGamma"] != nil) {
                let highGamma = data["eegHighGamma"]!.intValue
                eegValues[4] = Double(highGamma)
                sleepStat.EegHighGamma = Int(highGamma)
            }
            if (data["eegLowGamma"] != nil) {
                let eegLowGamma = data["eegLowGamma"]!.intValue
                //eegValues[4] = Double(eegLowGamma)
                sleepStat.EegLowGamma = Int(eegLowGamma)
            }
            if (data["eegLowAlpha"] != nil) {
                let eegLowAlpha = data["eegLowAlpha"]!.intValue
                //eegValues[4] = Double(eegLowGamma)
                sleepStat.EegLowAlpha = Int(eegLowAlpha)
            }
            if (data["eegLowBeta"] != nil) {
                let eegLowBeta = data["eegLowBeta"]!.intValue
                //eegValues[4] = Double(eegLowGamma)
                sleepStat.EegLowBeta = Int(eegLowBeta)
            }
            
            sleepStat.DataQuality = Int(signal)
                
            eegBusiness.saveSleepStat(sleepStat)
            
            setChart(eegType, values: eegValues)
        }
        }
        
    }
    
    
    // MARK: Stop Tracking
    func stopTracking()
    {

        let alertController = UIAlertController(title: "Save Tracking", message: "Would you like to save your sleep session?", preferredStyle: .Alert)

        let saveAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.saveTracking()
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            self.cancelTracking()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func saveTracking()
    {
       
        if(countIndex > 0)
        {
        let alert: UIAlertView = UIAlertView(title: "Processing", message: "", delegate: nil, cancelButtonTitle: nil);
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 10, 37, 37)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        alert.setValue(loadingIndicator, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        alert.show();
        
//        
//        let timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "update", userInfo: nil, repeats: true)
        
            createSleepSession(data)
            alert.dismissWithClickedButtonIndex(-1, animated: true)
            performSegueWithIdentifier("trackingSegue", sender: nil)
        }
        else
        {
            cancelTracking()
        }
        
        
    }
    
    func cancelTracking()
    {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func createSleepSession(data: [Int])
    {
        var respiratory = Respiratory()
        var calculatedData = respiratory.getPostSleepData(data, startTime: self.startDate)
        
        var sleepSession = UserSleepSession()
        sleepSession.bpm = calculatedData.Bpm
        sleepSession.timesApneaDetected = calculatedData.TimesApneaDetected
        sleepSession.averageTemp = self.humidityAverage
        sleepSession.averageHumidity = self.tempAverage
        sleepSession.startSessionDate = self.startDate
        sleepSession.endSessionDate = NSDate()
        sleepSession.totalHoursAsleep =   Double(sleepSession.endSessionDate!.minutesFrom(self.startDate)) / 60.0
        
        sleepSession.totalLightSleepHours = 1 // we need this from eeg
        sleepSession.totalAwakeHours = 0 // we need this from eeg
        sleepSession.totalDeepSleepHours = 0 // we need this from eeg
        
        sleepSession.userId = defaults.integerForKey("userId")
        saveSleepSession(sleepSession)
    }

//    func update() {
//
//
//    }
    
    func saveSleepSession(sleepSession: UserSleepSession) -> Void
    {
        var business = Business()
        business.saveUserSleepSession(sleepSession)
    }
    
    func saveUserSensorStats(stats: [UserSensorStat]) -> Void
    {
        
    }
}

