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
    
//    let YOUR_SITE_ID = "22" // Joe Fish
//    let YOUR_KEY = "78C208F3-C0A8-4B0D-8741-A075BB6C003D" // Joe Fish
    
    //let YOUR_APP_ID = 1
    let YOUR_SITE_ID = "23" // QA Fenway
    let YOUR_KEY = "655559DE-4E2B-4D29-AF72-C078B456BCC0" // QA Fenway
    
    let BASE_URL = "http://api.leaftest.me"
    
    let hmac = SwiftHMAC()
    
    //var LeafAPIKey : String = ""
    
    init() {
        println( "LeafAPI Started" )
    }
    
    func heartbeat() {
        var heartbeatUrl = NSURL(string: "\(BASE_URL)/heartbeat")
    
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
        let urlStr = "http://api.leaftest.me/heartbeat"
        request.URL = NSURL(string: urlStr)
        request.HTTPMethod = "GET"
        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(urlStr) {(data, response, error) in
//            println(NSString(data: data, encoding: NSUTF8StringEncoding))
//        }
//        
//        task.resume()
    }
    
    func heartbeat2() {
        var heartbeatUrl = NSURL(string: "http://api.leaftest.me/heartbeat")
        
        //println("Heartbeat")
        var sessionConfig : NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        //var session = NSURLSession()
        //[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        var request = NSMutableURLRequest()
        let urlStr = "http://api.leaftest.me/heartbeat"
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
        let usersUrl = NSURL(string: "http://api.leaftest.me/users?site_id=\(YOUR_SITE_ID)")
        
        
        println("Getting users url: \(usersUrl)")
        
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
        
        // Generate current Unix timestamp
        //let time = String(Int(NSDate().timeIntervalSince1970))
        
        let time = 1403728841
        
        println("Seconds: \(time)")
        
        // Signature
        let signature = "\(time),GET,users,\(YOUR_SITE_ID)"

        // Convert to NSData
        var keyData : NSData = YOUR_KEY.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
        var signatureData : NSData = signature.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
        
        // Convert NSData to byte array
        var keyBytes = Byte[](count: keyData.length, repeatedValue:0)
        keyData.getBytes(&keyBytes)
        var signatureBytes = Byte[](count: signatureData.length, repeatedValue:0)
        signatureData.getBytes(&signatureBytes)

        println("String to digest: \(signature)")
        
        // Generate authentication signature and encode it using the key provided by Leaf
//        var hash : Byte[] = hmac.calculate(HMACAlgorithm.SHA512, key: keyBytes, data: signatureBytes)
        
        var hash : NSData = hmac.calculateNS(HMACAlgorithm.SHA512, key: keyBytes, data: signatureBytes)
        
        var hashBytes = Byte[](count: keyData.length, repeatedValue:0)
        hash.getBytes(&hashBytes)
        
        println("hmac result: \(hashBytes)")
        
        //var sessionConfig : NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        //sessionConfig.se
        
        // Convert bytes to base 64
        var encoded : NSString = hash.base64Encoding()
        
        println("encoded string: \(encoded)")
        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(usersUrl) {(data, response, error) in
//            println("Users result:")
//            println(NSString(data: data, encoding: NSUTF8StringEncoding))
//        }
//        
//        task.resume()
        
        let usersRequest = NSMutableURLRequest(URL: usersUrl)
        usersRequest.setValue(YOUR_SITE_ID, forHTTPHeaderField: "leaf-api-site-id")
        usersRequest.setValue(String(time), forHTTPHeaderField: "leaf-api-timestamp")
        usersRequest.setValue(encoded, forHTTPHeaderField: "leaf-api-signature-sha512")
        
        
        let task2 = NSURLSession.sharedSession().dataTaskWithRequest(usersRequest) {(data, response, error) in
            println("Users Result: ")
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task2.resume()
        
        
        
    }
    
    
    
    

}