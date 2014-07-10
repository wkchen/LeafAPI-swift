LeafAPI-swift
=============

Swift wrapper for the Leaf API, demonstrating support for both Test and Production environments, as well as the HMAC based authentication scheme.  HMAC is currently not suppored in Swift, so it is bridged from Objective C.

The library consists of three files:
- LeafAPI.swift
- HMAC.h
- HMAC.m

Usage
-----

First, declare an instance of LeafAPI:

    var leafAPI: LeafAPI?
    
Then you can instantiate and use it:
```swift
override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
        
    let path = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist")
    let dict = NSDictionary(contentsOfFile: path)
        
    self.leafAPI = LeafAPI(
        environment: LeafEnv.TEST,
        siteID: dict.valueForKey("TEST_QA_FENWAY_SITEID") as NSString,
        apiKey: dict.valueForKey("TEST_QA_FENWAY_KEY") as NSString)
        
    self.leafAPI?.heartbeat()

}
```
In this example, credentials are stored in a Keys.plist file (not synced to GitHub).  The format of the file is as follows:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>TEST_QA_FENWAY_SITEID</key>
    <string>xx</string>
    <key>TEST_QA_FENWAY_KEY</key>
    <string>xxxxx-xxxx-xxxx</string>
    <key>TEST_JOE_FISH_SITEID</key>
    <string>xx</string>
    <key>TEST_JOE_FISH_KEY</key>
    <string>xxxxx-xxx-xxxx</string>
</dict>
</plist>
```
