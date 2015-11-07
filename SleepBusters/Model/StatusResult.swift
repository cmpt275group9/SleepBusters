/********************************************************
 
 StatusResult.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes
 
 Purpose:  This class is returned from the WebApi after
 a POST operation has completed. An IsSuccess = true if
 the save to the database was a success.
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import Foundation
class StatusResult {
    var IsSuccess: Bool? = nil
    var ErrorMessage: String? = nil
}