//
//  HMAC.m
//  LeafAPI
//
//  Created by William K Chen on 6/24/14.
//  Copyright (c) 2014 Leaf. All rights reserved.
//

// Inspired by:
// http://jokecamp.wordpress.com/2012/10/21/examples-of-creating-base64-hashes-using-hmac-sha256-in-different-languages/#objc

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "HMAC.h"
//#import "LeafAPI-Swift.h"

@implementation HMAC

+ (NSString *)calculateSHA512Base64WithKey:(NSString *)key andData:(NSString *)data
{
    const char *cKey = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA512_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA512, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *hash = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    return [hash base64EncodedStringWithOptions:0];
}

@end