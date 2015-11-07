/********************************************************
 
 SleepBusterTests.swift
 
 Author(s): Klein Gomes
 
 Purpose:  Induvidually tests each component of SleepBusters
           Current Tests: Business Layer
           TODO Tests: Data Layer and UI Layer
 
 ********************************************************/

import XCTest
@testable import SleepBusters

class SleepBustersTests: XCTestCase {
    
    // Business Logic Testing
    var business = Business()
    
    // Test that Get Last N Sleep sessions returns 7
    // records from the database.
    func testGetUserSleepSessionsIsEqualTo7()
    {
        var sleepSessions = business.getLastNSleepSessions(1,7)
        var sessionCount = sleepSessions.count
        XCTAssertEqual(sessionCount,7)
    }
    
    // Test that we can save a sleep session
    // to the database. The database will 
    // return a true if it was successful
    func testSaveUserSleepSessions()
    {
        var testUser = UserSleepSession()
        testUser.User = UserProfile()
        testUser.User.id = 1
        testUser.TotalAwakeHours = 2
        testUser.TotalDeepSleepHours = 2
        testUser.TotalLightSleepHours = 8
        testUser.TotalHoursAsleep = 10
        testUser.StartSessionDate = NSDate("")
        testUser.EndSessionDate = NSDate("")
        var saveSuccess = business.saveUserSleepSession()
        XCTAssertEqual(saveSuccess,true)
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
