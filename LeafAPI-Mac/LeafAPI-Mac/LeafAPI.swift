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
    
    func users(callback: (NSString) -> Void) {
        callLeafAPIString("users", callback: callback)
    }
    
    func users(id: NSString) {
        //callLeafAPI("users", id)
    }
    
    func catalogs() {
        callLeafAPI("catalogs")
    }
    
    func catalogs(callback: (NSString) -> Void) {
        callLeafAPIString("catalogs", callback: callback)
    }
    
    func catalog38(callback: (NSString) -> Void) {
        //callLeafAPIStringArg("catalogs", arg: "38")
        callLeafAPICatalog("catalog_items", catalog_id: "38", callback)
    }
    
    func payments() {
        callLeafAPI("payments")
    }
    
    func payments(callback: (NSString) -> Void) {
        callLeafAPIString("payments", callback: callback)
    }
    
    func orders(callback: (NSString) -> Void) {
        callLeafAPIString("orders", callback: callback)
    }
    
    func order9694(callback: (NSString) -> Void) {
        //callLeafAPIStringArg("catalogs", arg: "38")
        callLeafAPIStringArg("orders", arg: "9694", callback)
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
    
    func callLeafAPIString(endpoint: NSString, callback: (NSString) -> Void) {
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
            callback(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
    }
    
    func callLeafAPIStringArg(endpoint: NSString, arg: NSString, callback: (NSString) -> Void) {
        let url = NSURL(string: "\(self.baseURL)/\(endpoint)/\(arg)")
        
        println(url)
        
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
            println("Arg Result: ")
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            callback(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
    }
    
    // Get catalog items
    func callLeafAPICatalog(endpoint: NSString, catalog_id: NSString, callback: (NSString) -> Void) {
        let url = NSURL(string: "\(self.baseURL)/\(endpoint)?catalog_id=\(catalog_id)")
        
        println(url)
        
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
        
        httpRequestWithCallback(usersRequest, callback: callback)
    }
    
    func buildLeafAPIRequest(endpoint: NSString, args: NSDictionary) -> NSURLRequest {
        
        let url = NSURL(string: "\(self.baseURL)/\(endpoint)") // TODO - update this, need siteID, etc.
        
        println(url)
        
        // Generate current Unix timestamp
        let time = String(Int(NSDate().timeIntervalSince1970))
        
        // Signature
        let signature = "\(time),GET,\(endpoint),\(self.siteID)"
        
        // Calculate Base 64 encoded digest
        let hash : NSString = HMAC.calculateSHA512Base64WithKey(self.apiKey, andData: signature)
        
        // Set headers in request
        let req = NSMutableURLRequest(URL: url)
        req.setValue(self.siteID, forHTTPHeaderField: "leaf-api-site-id")
        req.setValue(String(time), forHTTPHeaderField: "leaf-api-timestamp")
        req.setValue(hash, forHTTPHeaderField: "leaf-api-signature-sha512")
        
        return req
    }

    
    // Helper method to execute request as NSURLSession
    func httpRequestWithCallback(request: NSURLRequest, callback: (NSString) -> Void) {
        // Execute query
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            callback(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
    }
    
}