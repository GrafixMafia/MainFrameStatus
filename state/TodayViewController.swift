//
//  TodayViewController.swift
//  spacestate
//
//  Created by markus on 31.10.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet weak var status: UILabel!
    
    var statusHandler : StatusHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusHandler = StatusHandler()
        
        status.text = statusHandler!.getStatus() as String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.NewData)
    }
    
}
