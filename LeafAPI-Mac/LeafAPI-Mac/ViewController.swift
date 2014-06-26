//
//  ViewController.swift
//  LeafAPI-Mac
//
//  Created by William K Chen on 6/26/14.
//  Copyright (c) 2014 wkchen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("View Did Load")
        
        let path = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path)
        
        println(dict.valueForKey("TEST_JOE_FISH_KEY"))
        
        
                                    
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
                                    
    }


}

