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

    let YOUR_APP_ID = 1
    let YOUR_SITE_ID = 2
    let YOUR_KEY = 3

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        
        heartbeat()
        users()
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }
    
    func heartbeat() {
        var heartbeatUrl = NSURL(string: "http://api.leaf.me/heartbeat")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(heartbeatUrl) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
    }
    
    func users() {
        let usersUrl = NSURL(string: "https://api.leaf.me/users?site_id=\(YOUR_SITE_ID)&per_page=10")
        
        println("Getting users: \(usersUrl)")
        
//        var now = NSDate()
//        var seconds = now.sec
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let seconds = components.second
        
        let time = components.second
        
        println("Seconds: \(time)")
        
        // Signature
        let reqStr = "\(time),GET,users,\(YOUR_APP_ID)"
        
        var string :String = "Hello"
        println("Hello as UTF8 \(string.utf8)")
        
        //var bytes[] = []
//        for byte in string.utf8 {
//            
//        }
//        string.utf8
        
        println("String to digest: \(reqStr)")
        //bytes = SwiftHMAC.calculate(algorithm: HMACAlgorithm.SHA512, key: YOUR_KEY, data: reqStr)
        
    
        
    }

}

