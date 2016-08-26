//
//  StatusHandler.swift
//  MainFrameStatusBar
//
//  Created by markus on 05.08.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import Foundation

public class StatusHandler {
    
    init() {
        
    }
    
    public var stateDetails: NSDictionary?
    private var data:NSString?
    private var rData:NSData?
    
  
    func getStatus(room: String) -> String {
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
                if let jsonSpaceResult = jsonResult?.valueForKey(room) {
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
        let urlPath: String = urlToRequest
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let queue:NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response: NSURLResponse?, data: NSData?, error: NSError?) in
            self.rData = data!
            
        }
        return rData!
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