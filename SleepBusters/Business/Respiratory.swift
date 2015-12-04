/********************************************************
StatsViewController.swift

Team Name: PillowSoft

Author(s): Chelsea Huang

Purpose:  All Business Logic is located here.
All SleepBusters calculations will be done here.

Known Bugs: None

Copyright © 2015 PillowSoft. All rights reserved.

********************************************************/

import Foundation
import Darwin

class Respiratory
{
    var apneaStatArray = [UserSensorStat]()
    
    func checkRTSleepData (resp: Int, prevResp: Int, timeElapsed: NSTimeInterval){
    /*
        var breathRate = 30
        var startingPoint = 200 //resp range is 200-400
        var maxR = 0
        var minR = 0
        var bigMax = 0
    
        if (timeElapsed <= 600){ //preliminary sleep information is determined in the first 10 minutes
            // determine the average breathing rate (so we know how many divisions we have per breath
    
    
            //when user is in phase I sleep, find Max/Min
            for var x = 0; x < breathRate; x++
            {
                if (resp > maxR){
                    maxR = resp
                }
                if (resp < minR){
                    minR = resp
                }
            }
        }
        /*if (timeElapsed >= 600){
            //determine 5% threshold based on max and min
            let threshold = (Double(maxR) - Double(minR)) * 0.05
           /* if ((resp <= threshold) && timer has not started){
                starttimer;
            }
            else if ((resp > threshold) && timer has started){
                stoptimer;
            }
            */
            if (timer > 10 && resp > threshold){
                for var x = 0; x < (2*breathRate); x++ //look for big intake in the next 2 breaths
                {
                    if (resp > maxR){
                    //flag high chance of apnea
                    //assign value 10 for high, 5 for medium, 1 for low
                    //can also call function to compare eeg data values
                    }
                }
            }
        //if time exceeds 10 seconds check for big intake
        }
*/*/
    
    
    
    }
    
    
    //this function uses data from a night of sleep to determine possible points of sleep apnea
    func getPostSleepData(sleepdata: [Int], startTime: NSDate) -> RespiratoryCalculatedData {
        
        let N = sleepdata.count
        var categories = [Int:Int]()
        var avgVals = [Int]()
        categories[0] = 0
        for var index = 200; index <= 400; index++
        {
            if(index % 5 == 0)
            {
                categories[index] = 0
            }
            
        }
        
        //sort all values into categories to determine average max and min and freq
        for var d = 0; d < N; d++
        {
            switch sleepdata[d]{
            case 200..<210:
                categories[205]! += 1
            case 210..<220:
                categories[215]!+=1
            case 220..<230:
                categories[225]!+=1
            case 230..<240:
                categories[235]!+=1
            case 240..<250:
                categories[245]!+=1
            case 250..<260:
                categories[255]!+=1
            case 260..<270:
                categories[265]!+=1
            case 270..<280:
                categories[275]!+=1
            case 280..<290:
                categories[285]!+=1
            case 290..<300:
                categories[295]!+=1
            case 300..<310:
                categories[305]!+=1
            case 310..<320:
                categories[315]!+=1
            case 320..<330:
                categories[325]!+=1
            case 330..<340:
                categories[335]!+=1
            case 340..<350:
                categories[345]!+=1
            case 350..<360:
                categories[355]!+=1
            case 360..<370:
                categories[365]!+=1
            case 370..<380:
                categories[375]!+=1
            case 380..<390:
                categories[385]!+=1
            case 390..<400:
                categories[395]!+=1
            default:
                categories[0]! += 1
            }
        }
       // print("cat 0")
       // print(categories[0]!)
        
        for (key, value) in categories {
            if (value > N/20){
                avgVals.append(key)
            }
        }
    
        //find average max and min amplitude
        avgVals.sortInPlace(<)
        let minR = avgVals[0]
        let a = avgVals.count
        let maxR = avgVals[(a-1)]
        let threshold = Double(maxR - minR)*0.25
        let midpt = Int((maxR - minR)/2 + minR)
    
        //find average frequency of all data to find average breaths per minute
        //first 10 min of sleep is 600 seconds, therefore 60000 divisions
        //will likely have to recalibrate this function to account for error
        var freq: Double = 0
        
        for var l = 0; l < 300; l++
        {
            if (sleepdata[l] == midpt){
                freq += 1.0
            }
            else if (sleepdata[l] == (midpt + 1)){
                freq += 1.0
            }
            //else if (sleepdata[x] == (midpt + 2)){
            //    freq += 1.0
            //}
        }
    
        //freq = number of times max is hit in 300 samples
        // 300 samples = 300 * 100ms = 30 seconds
        //freq = number of times max is hit in 30 seconds => 2*freq = # breaths/ minute
        
        //freq = 2*freq //breaths/min
        let period = 60/freq //seconds/breath: 1/f min/breath * 60 sec/min * 1/10 min/100ms
        //let samples = period*10 // samples/breath: seconds/breath * samples/second
        //let period = 60/(freq/2) //1/f = T (seconds per breath) times by 60 to have avg breaths per minute
        
        //create basis waveform to compare actual waveform to
        var baseWave = [Double]()
        var apneaCount: Int = 0
        //let w = (2.0*M_PI)/period //angular frequency = 2*pi*f or 2*pi/T
        //let c = Double(midpt) //zero point of waveform
        
        for var k = 0; k < N; k++
        {
            let wave = sin(Double(k)/(2.2*period))
            let abswave = abs(wave)
            let transform = Double(maxR-minR) * abswave + Double(minR)
            baseWave.append(transform)
            //Asin(wt + p) + c
    
        }
    
        //check cross correlation of entire waveform to have base "error" value
        //cross correlation = covariance/ (stddev(x)* stddev(y))
        //var sleepdataDbl = [Double]()
        //for i in sleepdata {
        //    sleepdataDbl.append(Double(sleepdata[i]))
        //}
        
        //let sleepdataStdDev = standardDeviation(sleepdataDbl)
        //let basisStdDev = standardDeviation(baseWave)
    
        //let baseError = covariancePopulation(x: sleepdataDbl, y: baseWave)! / (sleepdataStdDev * basisStdDev)
        
        var x = 0
        var log = [Int:String]()
        var logc = 0
        var duration = ""
    
        while (x < N)
        {
            //initialize empty arrays each time
            //var sdpt = [Double]()
            //var bwpt = [Double]()
            let limit = (Double(minR) + threshold)
            if (sleepdata[x] < Int(limit)) {
                //for var j = 0; j<Int(samples); j++
                //{
                //    if ((x+j) < N){
                //        sdpt.append(Double(sleepdata[x+j]))
                //        bwpt.append(baseWave[j])
                //    }
                //    else {
                //        break
                //    }
                //}
                //let covariance = covarianceSample(x: sdpt, y: bwpt)!
                //let standardDiv =  (sleepdataStdDev * basisStdDev)
                //let cc =  covariance / standardDiv
                //if (cc > baseError)
                //{
                
                //check next 10 seconds to see if original wave stays within 5% threshold
                var s = 0
                while (sleepdata[x+s] <= Int(limit))
                {
                    s++
                    if ((x+s) > N){
                        break
                    }
                }
                if (s>=90){
                    apneaCount++
                    let start = startTime.dateByAddingTimeInterval(Double(x/100))
                    let end = startTime.dateByAddingTimeInterval(Double((x+s)/100))
                    duration = "start:\(start), end:\(end)"
                    log[logc] = duration
                    logc++
                }
                x += s
                //}
            }

            //sdpt.append(sleepdataDbl[x])
            //bwpt.append(baseWave[x])
            //sdpt.append(sleepdataDbl[x+1])
            //bwpt.append(baseWave[x+1])
            
            

            
             x++
        }
    
    
        //check cross correlation of each point and then check the next 10s for sleep apnea
    
        //let hours = Int(N/(100*60*60))
        //if (apneaCount != 0){
        //    apneaCount = apneaCount/hours
        //}
        print("\(Int(freq)) breaths/minute")
        getDiagnosisMessage(apneaCount)
    
        var calculatedData = RespiratoryCalculatedData()
        calculatedData.Bpm = Int(freq)
        calculatedData.TimesApneaDetected = apneaCount
        return calculatedData
    }

    //this function creates a diagnosis message based on the number of times sleep apnea was detected by the previous algorithm
    func getDiagnosisMessage(apneaCount: Int) -> Void {
        var diagnosis: String
        switch apneaCount{
        case 5..<15:
            diagnosis = "signs of Mild Obstructive Sleep Apnea; detected breathing gaps \(apneaCount) times"
        case 15..<30:
            diagnosis = "signs of Moderate Obstructive Sleep Apnea; detected breathing gaps \(apneaCount) times"
        case _ where apneaCount > 29:
            diagnosis = "signs of Severe Obstructive Sleep Apnea; detected breathing gaps \(apneaCount) times"
        //case >50? Because if we read that many errors then there's something wrong with our code
        default:
            diagnosis = "no signs of Sleep Apnea; detected breathing gaps \(apneaCount) time(s)"
        }
        
        //print to diagnosis page: "SleepBusters has detected (diagnosis)"
        print(diagnosis)
    
    }


    //standard deviation function from https://gist.github.com/jonelf/9ae2a2133e21e255e692
    func standardDeviation(arr : [Double]) -> Double
    {
        let length = Double(arr.count)
        let avg = arr.reduce(0, combine: {$0 + $1}) / length
        let sumOfSquaredAvgDiff = arr.map { pow($0 - avg, 2.0)}.reduce(0, combine: {$0 + $1})
        return sqrt(sumOfSquaredAvgDiff / length)
    }


    /*the following 2 covariance functions were taken fromhttps://github.com/evgenyneu/SigmaSwiftStatistics/blob/master/SigmaSwiftStatistics/Sigma.swift
    */

    /**
    Computes covariance for entire population between two variables: x and y.

    http://en.wikipedia.org/wiki/Covariance

    - parameter x: Array of decimal numbers for the first variable.
    - parameter y: Array of decimal numbers for the second variable.
    - returns: Covariance for entire population between two variables: x and y. Returns nil if arrays x and y have different number of values. Returns nil for empty arrays.
    Formula
    cov(x,y) = Σ(x - mx)(y - my) / n
    Where:
    mx is the population mean of the first variable.

    my is the population mean of the second variable.

    n is the total number of values.
    Example
    let x = [1, 2, 3.5, 3.7, 8, 12]
    let y = [0.5, 1, 2.1, 3.4, 3.4, 4]
    Sigma.covariancePopulation(x: x, y: y) // 4.19166666666667
    */

    func covariancePopulation(x x: [Double], y: [Double]) -> Double? {
        let xCount = Double(x.count)
        let yCount = Double(y.count)
        
        if xCount == 0 { return nil }
        if xCount != yCount { return nil }
        
        if let xMean = average(x),
        yMean = average(y) {
        
            var sum:Double = 0
        
            for (index, xElement) in x.enumerate() {
                let yElement = y[index]
        
                sum += (xElement - xMean) * (yElement - yMean)
            }
        
            return sum / xCount
        }
        
        return nil
    }

    /**
    Calculates the Pearson product-moment correlation coefficient between two variables: x and y.

    http://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient

    - parameter x: Array of decimal numbers for the first variable.
    - parameter y: Array of decimal numbers for the second variable.
    - returns: The Pearson product-moment correlation coefficient between two variables: x and y. Returns nil if arrays x and y have different number of values. Returns nil for empty arrays.
    Formula
    p(x,y) = cov(x,y) / (σx * σy)
    Where:
    cov is the population covariance.
    σx is the population standard deviation of x.
    Example
    let x = [1, 2, 3.5, 3.7, 8, 12]
    let y = [0.5, 1, 2.1, 3.4, 3.4, 4]
    Sigma.pearson(x: x, y: y) // 0.843760859352745
    */

    func covarianceSample(x x: [Double], y: [Double]) -> Double? {
        let xCount = Double(x.count)
        let yCount = Double(y.count)
        
        if xCount < 2 { return nil }
        if xCount != yCount { return nil }
        
        if let xMean = average(x),
        yMean = average(y) {
        
            var sum:Double = 0
        
            for (index, xElement) in x.enumerate() {
                let yElement = y[index]
        
                sum += (xElement - xMean) * (yElement - yMean)
            }
        
            return sum / (xCount - 1)
        }
        
        return nil
    }
    
    func average(values: [Double]) -> Double? {
        let count = Double(values.count)
        if count == 0 { return nil }
        return sum(values) / count
    }
    
    func sum(values: [Double]) -> Double {
        return values.reduce(0, combine: +)
    }

}

class RespiratoryCalculatedData
{
    var Bpm: Int? = nil
    var TimesApneaDetected: Int? = nil
}
