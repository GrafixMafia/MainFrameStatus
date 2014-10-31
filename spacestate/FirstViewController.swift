//
//  FirstViewController.swift
//  spacestate
//
//  Created by markus on 23.08.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var status: UILabel!
    
    var statusHandler : StatusHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusHandler = StatusHandler()

        status.text = statusHandler?.getStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
