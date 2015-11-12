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



class TrackingLiveViewController:UIViewController,JBLineChartViewDelegate, JBLineChartViewDataSource, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    @IBOutlet weak var radarChartView: RadarChartView!
    @IBOutlet weak var respLineChart: JBLineChartView!
    @IBAction func btnStopTracking(sender: UIButton) {
        performSegueWithIdentifier("trackingSegue", sender: nil)
    }
    
    // EEG Sensor: (Simulated Data)
    var counterPie = 0.00
    var counter = 5;
    var chartLegend = [""]
    var eegValues = [5.0, 4.0, 1.0, 2.0, 3.0]
    var chartData = [0]
    var lastYearChartData = [75, 88, 79, 95, 72, 55, 90]
    /**************************************************/
    
    // Respiratory Sensor: (Live Data)
    let isSimulate = false
    let btName = "HMSoft"
    let btServiceID = "FFE0"
    let btCharacteristicId = "FFE1"
    var centralManager:CBCentralManager!
    var blueToothReady = false
    var peripheral: CBPeripheral?
    var characteristics: CBCharacteristic!
    var terminalChar:CBCharacteristic!
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
        
        if(isSimulate == false){
            // Respiratory Sensor
            centralManager = CBCentralManager(delegate: self, queue: nil)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        let header = UILabel(frame: CGRectMake(0, 0, respLineChart.frame.width, 50))
        header.textColor = UIColor.whiteColor()
        header.font = UIFont.systemFontOfSize(14)
        header.text = "         Respiratory Signal"
        header.textAlignment = NSTextAlignment.Left
        respLineChart.headerView = header
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBarHidden = true
        respLineChart.reloadData()
        
        // Create Timers that will Redraw the Chart every 50ms for respiratory and 1 second for EEG
        if(isSimulate){
            NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("updateRespiratoryChart"), userInfo: nil, repeats: true)
        }
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateEEGChart"), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        hideChart()
    }
    
    func hideChart() {
        respLineChart.setState(.Collapsed, animated: true)
    }
    
    
    func updateRespiratoryChart()
    {
            chartData.removeFirst()
            let temp = 150+abs(70*sin(counterPie))
            chartData.append(Int(temp))
            respLineChart.reloadData()
            respLineChart.setState(.Expanded, animated: false)
            counterPie = counterPie + 0.02;
    }
    
    func updateEEGChart(){
        for var index = 0; index < 4; index++
        {
            eegValues[index] = Double(Int(arc4random_uniform(11)));
        }
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
            let color = UIColor.redColor()
            colors.append(color)
        }
        
        let chartDataSet = RadarChartDataSet(yVals: dataEntries, label: "EEG Live Sensor")
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        let dataSets: [RadarChartDataSet] = [ chartDataSet]
        let chartData = RadarChartData(xVals: eegType, dataSets: dataSets)
        radarChartView.data = chartData
        chartData.setValueTextColor(UIColor.clearColor())
        radarChartView.descriptionText = ""
        radarChartView.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0)
        radarChartView.legend.textColor = UIColor.whiteColor()
        radarChartView.xAxis.labelTextColor = UIColor.whiteColor()
        radarChartView.yAxis.labelTextColor = UIColor.clearColor()
        radarChartView.animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .EaseInBounce)
        
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
            if(streamValues.count == 4)
            {
                let humidity = streamValues[0]
                let temp = streamValues[2]
                let respiratory  = streamValues[3].stringByReplacingOccurrencesOfString("\r\n", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
                chartData.removeFirst()
           
                chartData.append(Int(respiratory)!)
                respLineChart.reloadData()
                respLineChart.setState(.Expanded, animated: false)
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
}

