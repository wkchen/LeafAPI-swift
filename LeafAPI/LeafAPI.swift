//
//  LeafAPI.swift
//  LeafAPI
//
//  Created by William K Chen on 6/24/14.
//  Copyright (c) 2014 Leaf. All rights reserved.
//

//import Foundation
import Cocoa

class LeafAPI {
    
    //let YOUR_APP_ID = 1
    let YOUR_SITE_ID = "49"
    let YOUR_KEY = "8BA1551A-EA07-404C-A50C-1A53ABCB9B3B" // Kafofo
    
    let hmac = SwiftHMAC()
    
    //var LeafAPIKey : String = ""
    
    init() {
        println( "LeafAPI Started" )
    }
    
    func heartbeat() {
        var heartbeatUrl = NSURL(string: "https://api.leaf.me/heartbeat")
    
        //println("Heartbeat")
    
        let task = NSURLSession.sharedSession().dataTaskWithURL(heartbeatUrl) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
    
        task.resume()
    }
    
    func heartbeat3() {
        //var heartbeatUrl = NSURL(string: "https://api.leaf.me/heartbeat")
        
        //println("Heartbeat")
        
        var request = NSMutableURLRequest()
        let urlStr = "https://api.leaf.me/heartbeat"
        request.URL = NSURL(string: urlStr)
        request.HTTPMethod = "GET"
        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(urlStr) {(data, response, error) in
//            println(NSString(data: data, encoding: NSUTF8StringEncoding))
//        }
//        
//        task.resume()
    }
    
    func heartbeat2() {
        var heartbeatUrl = NSURL(string: "https://api.leaf.me/heartbeat")
        
        //println("Heartbeat")
        var sessionConfig : NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        //var session = NSURLSession()
        //[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        var request = NSMutableURLRequest()
        let urlStr = "https://api.leaf.me/heartbeat"
        request.URL = NSURL(string: urlStr)
        request.HTTPMethod = "GET"
        

        var connection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        
        println("sending request...")
        
        connection.start()
        
    }
    
//    func completion(error: errorStr as NSString) {
//        println("Got error: \(errorStr)");
//    }
    
    func users() {
        let usersUrl = NSURL(string: "https://api.leaf.me/users?site_id=\(YOUR_SITE_ID)&per_page=10")
        
        println("Getting users: \(usersUrl)")
        
        //        var now = NSDate()
        //        var seconds = now.sec
        
//        let date = NSDate()
//        let calendar = NSCalendar.currentCalendar()
//        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
//        let hour = components.hour
//        let minutes = components.minute
//        let seconds = components.second
//        
//        let time = components.second
        
        // Get Unix timestamp
        let time = String(Int(NSDate().timeIntervalSince1970))
        
        println("Seconds: \(time)")
        
        // Signature
        let signature = "\(time),GET,users,\(YOUR_SITE_ID)"
        
        var string :String = "Hello"
        println("Hello as UTF8 \(string.utf8)")
        var b : Array<Character>
        
        
        
        var keyData : NSData = YOUR_KEY.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
        var signatureData : NSData = signature.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
        
        // Convert to bytes array
        var keyBytes = Byte[](count: keyData.length, repeatedValue:0)
        keyData.getBytes(&keyBytes)
        var signatureBytes = Byte[](count: signatureData.length, repeatedValue:0)
        signatureData.getBytes(&signatureBytes)
        
        
        
        println("String to digest: \(signature)")
        
        //var bytes = SwiftHMAC.calculate(HMACAlgorithm.SHA512, key: keyBytes, data: signatureBytes)
        //SwiftHMAC.cal
        var bytes : Byte[] = hmac.calculate(HMACAlgorithm.SHA512, key: keyBytes, data: signatureBytes)
        
        println("result: \(bytes)")
        
        var sessionConfig : NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        //sessionConfig.se
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(usersUrl) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
        
        
        
        
    }
    
    
    
    

}