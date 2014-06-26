//
//  LeafAPI.swift
//  LeafAPI-Mac
//
//  Created by William K Chen on 6/26/14.
//  Copyright (c) 2014 wkchen. All rights reserved.
//

import Cocoa

enum LeafEnv: Int {
    case PRODUCTION = 1, TEST
}

class LeafAPI {
    
    let BASE_URL_TEST = "http://api.leaftest.me"
    let BASE_URL_PRODUCTION = "https://api.leaf.me"
    
    var environment : LeafEnv
    var baseURL : NSString
    var siteID : NSString
    var apiKey : NSString
    
    init(environment: LeafEnv, siteID : NSString, apiKey : NSString) {
        
        self.environment = environment
        
        switch environment {
            
        case LeafEnv.PRODUCTION:
            self.baseURL = BASE_URL_PRODUCTION
        default:
            self.baseURL = BASE_URL_TEST
            
        }
        
        self.siteID = siteID
        self.apiKey = apiKey
    }
    
    func heartbeat() {
        var heartbeatUrl = NSURL(string: "\(baseURL)/heartbeat")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(heartbeatUrl) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
    }
    
    func heartbeat(callback: (NSString) -> Void) {
        var heartbeatUrl = NSURL(string: "\(baseURL)/heartbeat")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(heartbeatUrl) {(data, response, error) in
            callback(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
    }
    
    func users() {
        callLeafAPI("users")
    }
    
    func users(id: NSString) {
        //callLeafAPI("users", id)
    }
    
    //, callback: (NSData, NSURLResponse, NSError) -> Void
    func callLeafAPI(endpoint: NSString) {
        let url = NSURL(string: "\(self.baseURL)/\(endpoint)?site_id=\(self.siteID)")
        
        // Generate current Unix timestamp
        let time = String(Int(NSDate().timeIntervalSince1970))
        
        // Signature
        let signature = "\(time),GET,\(endpoint),\(self.siteID)"
        
        // Calculate Base 64 encoded digest
        let hash : NSString = HMAC.calculateSHA512Base64WithKey(self.apiKey, andData: signature)
        
        // Set headers in request
        let usersRequest = NSMutableURLRequest(URL: url)
        usersRequest.setValue(self.siteID, forHTTPHeaderField: "leaf-api-site-id")
        usersRequest.setValue(String(time), forHTTPHeaderField: "leaf-api-timestamp")
        usersRequest.setValue(hash, forHTTPHeaderField: "leaf-api-signature-sha512")
        
        // Execute query
        let task = NSURLSession.sharedSession().dataTaskWithRequest(usersRequest) {(data, response, error) in
            println("Users Result: ")
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            println()
            //callback(data, response, error)
        }
        
        task.resume()
    }
    
    //, callback: (NSData, NSURLResponse, NSError) -> Void
    func callLeafAPIString(endpoint: NSString) {
        let url = NSURL(string: "\(self.baseURL)/\(endpoint)?site_id=\(self.siteID)")
        
        // Generate current Unix timestamp
        let time = String(Int(NSDate().timeIntervalSince1970))
        
        // Signature
        let signature = "\(time),GET,\(endpoint),\(self.siteID)"
        
        // Calculate Base 64 encoded digest
        let hash : NSString = HMAC.calculateSHA512Base64WithKey(self.apiKey, andData: signature)
        
        // Set headers in request
        let usersRequest = NSMutableURLRequest(URL: url)
        usersRequest.setValue(self.siteID, forHTTPHeaderField: "leaf-api-site-id")
        usersRequest.setValue(String(time), forHTTPHeaderField: "leaf-api-timestamp")
        usersRequest.setValue(hash, forHTTPHeaderField: "leaf-api-signature-sha512")
        
        // Execute query
        let task = NSURLSession.sharedSession().dataTaskWithRequest(usersRequest) {(data, response, error) in
            println("Users Result: ")
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            println()
            //callback(data, response, error)
        }
        
        task.resume()
    }
    
    
    
}