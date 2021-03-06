//
//  ViewController.swift
//  LeafAPI-Mac
//
//  Created by William K Chen on 6/26/14.
//  Copyright (c) 2014 wkchen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var leafAPI: LeafAPI?
    
    //@IBOutlet var responseText: NSTextView
    @IBOutlet var scrollView: NSScrollView
    
    var responseText : NSTextView {
    get {
        return scrollView.contentView.documentView as NSTextView
    }
    }
    
    @IBAction func heartbeatButton(sender: AnyObject) {
        println("Heartbeat button")
        responseText.string = ""
        responseText.insertText("Getting Heartbeat...\n")
        self.leafAPI?.heartbeat(setText)
    }
    
    @IBAction func usersButton(sender: AnyObject) {
        println("Users button")
        responseText.string = ""
        responseText.insertText("Getting Users...\n")
        self.leafAPI?.users(setText)
    }
    
    @IBAction func catalogsButton(sender: AnyObject) {
        println("Catalogs button")
        responseText.string = ""
        responseText.insertText("Getting Catalogs...\n")
        self.leafAPI?.catalogs(setText)
    }
    
    @IBAction func paymentsButton(sender: AnyObject) {
        println("Payments button")
        responseText.string = ""
        responseText.insertText("Getting Payments...\n")
        self.leafAPI?.payments(setText)
    }
    
    @IBAction func catalog38Button(sender: AnyObject) {
        println("Catalog 38 button")
        responseText.string = ""
        responseText.insertText("Getting Payments...\n")
        self.leafAPI?.callLeafAPICatalog("catalog_items", catalog_id: "38", setText)
    }
    
    @IBAction func ordersButton(sender : AnyObject) {
        println("Orders button")
        responseText.string = ""
        responseText.insertText("Getting Orders...\n")
        self.leafAPI?.orders(setText)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("View Did Load")
        
        let path = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path)
        
        self.leafAPI = LeafAPI(
            environment: LeafEnv.TEST,
            siteID: dict.valueForKey("TEST_QA_FENWAY_SITEID") as NSString,
            apiKey: dict.valueForKey("TEST_QA_FENWAY_KEY") as NSString)
        
        //self.leafAPI?.heartbeat()
        
        self.leafAPI?.catalog38(setText)

    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }                       
    }
    
    func setText(txt: NSString) {
        println("Setting text: \(txt)")
        responseText.string = txt
    }
    
    func setTextJSON(d: NSString) {
        var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(d.dataUsingEncoding(NSUTF8StringEncoding), options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        var str = NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        
        
    }


}

