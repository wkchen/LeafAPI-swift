//
//  AppDelegate.swift
//  LeafAPI
//
//  Created by William K Chen on 6/24/14.
//  Copyright (c) 2014 Leaf. All rights reserved.
//

import Cocoa
//import "SwiftHMAC"

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet var window: NSWindow

    
    
    let leafAPI = LeafAPI()

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        
        println("Heartbeat:")
        leafAPI.heartbeat2()
        
        NSThread.sleepForTimeInterval(2)
        
        //sleep(200)
        
        leafAPI.users()
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }

}

