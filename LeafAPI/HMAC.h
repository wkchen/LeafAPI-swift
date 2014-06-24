//
//  HMAC.h
//  LeafAPI
//
//  Created by William K Chen on 6/24/14.
//  Copyright (c) 2014 Leaf. All rights reserved.
//

#import <Foundation/Foundation.h>

// This enum is in HMAC.h
typedef NS_ENUM(NSInteger, HMACAlgorithm)
{
    SHA1,
    MD5,
    SHA256,
    SHA384,
    SHA512,
    SHA224
};

@interface HMAC : NSObject

// Class methods here
+ (NSData *)calculateWithAlgorithm:(HMACAlgorithm)algorithm forKey:(const void *)key andData:(const void *)data;

+ (NSInteger)digestLengthForAlgorithm:(HMACAlgorithm)algorithm;

@end