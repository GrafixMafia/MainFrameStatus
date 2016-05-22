//
//  StatusHandler.swift
//  MainFrameStatusBar
//
//  Created by markus on 05.08.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import Foundation

public class StatusHandler : NSObject, NSURLSessionDelegate, NSURLSessionDataDelegate {
    
    override init() {
        super.init()
    }
    
    public var stateDetails: NSDictionary?
    
    public var status: String? {
        get {
            return self.getStatus() as String
        }
    }
    
    func getStatus() -> String {
        var freshStatus: String = ""
        
        let urlPath: String = "https://status.kreativitaet-trifft-technik.de/api/openState"
        
        let url: NSURL = NSURL(string: urlPath)!
        let request1: NSURLRequest = NSURLRequest(URL: url)
        
        var response: NSURLResponse?
        var error: NSError?
        
        var dataVal: NSData?
        
        do {
            dataVal =  try NSURLConnection.sendSynchronousRequest(request1, returningResponse: &response)
        } catch let error1 as NSError {
            error = error1
            dataVal = nil
        }
        
        if let _ = error {
            freshStatus = "X"
        } else {
            var jsonResult:NSDictionary?
            do {
                jsonResult = try NSJSONSerialization.JSONObjectWithData(dataVal!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                if let jsonSpaceResult = jsonResult?.valueForKey("space") {
                    if let thisState = jsonSpaceResult.valueForKey("state") {
                        if thisState as! String == "off" {
                            freshStatus = "C"
                        } else {
                            freshStatus = "O"
                        }
                    } else {
                        freshStatus = "X"
                    }
                }
            } catch _ as NSError {
                freshStatus = "X"
            }
            
        }
        return freshStatus
    }
    
    
    func getDetails(urlToSpace : String) {
        stateDetails = parseJSON(getJSON(urlToSpace))
    }
    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary{
        var jsonResult:NSDictionary?
        do {
            jsonResult = try NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            print(jsonResult)
        } catch let error as NSError {
            print(error)
        }
        return jsonResult!
    }
}