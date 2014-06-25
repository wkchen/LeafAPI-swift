//
//  SwiftHMAC.swift
//  LeafAPI
//
//  Created by William K Chen on 6/24/14.
//  Copyright (c) 2014 Leaf. All rights reserved.
//

import Foundation


class SwiftHMAC
{
    // Swift will automatically pull the enum from Obj-C
    
    func calculate(algorithm:HMACAlgorithm, key : Byte[], data : Byte[]) -> Byte[]
    {
        let computedHMAC = HMAC.calculateWithAlgorithm(algorithm, forKey: key, andData: data)
        
        var rawBytes = Byte[](count: computedHMAC.length, repeatedValue: 0)
        computedHMAC.getBytes(&rawBytes)
        
        return rawBytes
    }
    
    func calculateNS(algorithm:HMACAlgorithm, key : Byte[], data : Byte[]) -> NSData
    {
        let computedHMAC = HMAC.calculateWithAlgorithm(algorithm, forKey: key, andData: data)
        
//        var rawBytes = Byte[](count: computedHMAC.length, repeatedValue: 0)
//        computedHMAC.getBytes(&rawBytes)
        
        return computedHMAC
    }
    
}