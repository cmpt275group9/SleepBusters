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
        if (timeElapsed >= 600){
            //determine 5% threshold based on max and min
            let threshold = (maxR - minR)*0.05
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
    
    
    
    }
    
    
    //this function uses data from a night of sleep to determine possible points of sleep apnea
    func checkPostSleepData(sleepdata: [Int]){
        let N = sizeof(sleepdata)
        var categories: [Int:Int]
        var avgVals: [Int]
        //sort all values into categories to determine average max and min and freq
        for var x = 0; x < N; x++
        {
            switch sleepdata[x]{
            case 200..<210:
                categories[205]+=1
            case 210..<220:
                categories[215]+=1
            case 220..<230:
                categories[225]+=1
            case 230..<240:
                categories[235]+=1
            case 240..<250:
                categories[245]+=1
            case 250..<260:
                categories[255]+=1
            case 260..<270:
                categories[265]+=1
            case 270..<280:
                categories[275]+=1
            case 280..<290:
                categories[285]+=1
            case 290..<300:
                categories[295]+=1
            case 300..<310:
                categories[305]+=1
            case 310..<320:
                categories[315]+=1
            case 320..<330:
                categories[325]+=1
            case 330..<340:
                categories[335]+=1
            case 340..<350:
                categories[345]+=1
            case 350..<360:
                categories[355]+=1
            case 360..<370:
                categories[365]+=1
            case 370..<380:
                categories[375]+=1
            case 380..<390:
                categories[385]+=1
            case 390..<400:
                categories[395]+=1
            default:
                categories[0]+=1
            }
        }
        for (key, value) in categories {
            if (value > floor(N/20)){
                avgVals.append(key)
            }
        }
    
        //find average max and min amplitude
        avgVals.sortInPlace(<)
        let minR = avgVals[0]
        var i = sizeof(avgVals)
        let maxR = avgVals[(i-1)]
        let threshold = (maxR - minR)*0.05
    
        //find average frequency of all data to find average breaths per minute
        //first 10 min of sleep is 600 seconds, therefore 60000 divisions
        //will likely have to recalibrate this function to account for error
        var freq
        
        for var x = 0; x < 60000; x++
        {
            if (sleepdata[x] == maxR){
                freq += 1.0
            }
        }
    
        freq = 60/(freq/2) //1/f = T (seconds per breath) times by 60 to have avg breaths per minute
    
        //create basis waveform to compare actual waveform to
        var baseWave: [Double]
        var apneaCount: Int
        
        for var x = 0; x < N; x++
        {
             baseWave[x] = maxR*abs(Int(sin(2*M_PI*freq*x))) + minR
    
        }
        //TODO: account for offset?
        //TODO: This formula really doesn't seem right....
    
        //check cross correlation of entire waveform to have base "error" value
        //cross correlation = covariance/ (stddev(x)* stddev(y))
        let sleepdataStdDev = standardDeviation(sleepdata)
        let basisStdDev = standardDeviation(baseWave)
    
        let baseError = covariancePopulation(Double(sleepdata), baseWave)/ (sleepdataStdDev * basisStdDev)
        
        var x = 0
    
        while (x < N)
        {
             var cc = covarianceSample(Double(sleepdata[x]), baseWave[x])/ (sleepdataStdDev * basisStdDev)
            
             if (cc > baseError)
             {
                 //check next 10 seconds to see if original wave stays within 5% threshold
                 var s = x
                 while sleepdata[s] <= threshold
                 {
                    s++
                 }
                 if ((s-x)>=1000){
                    apneaCount++
                 }
                 x = s
             }
            
             x++
        }
    
    
        //check cross correlation of each point and then check the next 10s for sleep apnea
    
        let hours = Int(N/(100*60*60))
        apneaCount = floor(apneaCount/hours)
    
        createDiagnosisMessage(apneaCount)
    
    }

    //this function creates a diagnosis message based on the number of times sleep apnea was detected by the previous algorithm
    func createDiagnosisMessage(apneaCount: Int){
        var diagnosis: String
        switch apneaCount{
        case 5..<15:
            diagnosis = "signs of Obstructive Sleep Apnea"
        case 15..<30:
            diagnosis = "signs of Moderate Sleep Apnea"
        case >30:
            diagnosis = "signs of Severe Sleep Apnea"
        //case >50? Because if we read that many errors then there's something wrong with our code
        default:
            diagnosis = "no signs of Sleep Apnea"
        }
    
        //"SleepBusters has detected (diagnosis)"
    
    
    }


    //standard deviation function from https://gist.github.com/jonelf/9ae2a2133e21e255e692
    func standardDeviation(arr : [Int]) -> Double
    {
        let length = Double(arr.count)
        let avg = arr.reduce(0, {$0 + $1}) / length
        let sumOfSquaredAvgDiff = arr.map { pow($0 - avg, 2.0)}.reduce(0, {$0 + $1})
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

    public static func covariancePopulation(x: [Double], y: [Double]) -> Double? {
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

    public static func covarianceSample(x x: [Double], y: [Double]) -> Double? {
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

}
