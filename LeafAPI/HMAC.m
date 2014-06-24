//
//  HMAC.m
//  LeafAPI
//
//  Created by William K Chen on 6/24/14.
//  Copyright (c) 2014 Leaf. All rights reserved.
//

// Using info from:
// http://stackoverflow.com/questions/24099520/commonhmac-in-swift

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "HMAC.h"

@implementation HMAC

// Class methods here
+ (NSData *)calculateWithAlgorithm:(HMACAlgorithm)algorithm forKey:(const void *)key andData:(const void *)data
{
    NSInteger digestLength = [self digestLengthForAlgorithm:algorithm];
    unsigned char hmac[digestLength];
    
    CCHmac(algorithm, &key, strlen(key), &data, strlen(data), &hmac);
    
    NSData *hmacBytes = [NSData dataWithBytes:hmac length:sizeof(hmac)];
    return hmacBytes;
}

+ (NSInteger)digestLengthForAlgorithm:(HMACAlgorithm)algorithm
{
    switch (algorithm)
    {
        case MD5: return CC_MD5_DIGEST_LENGTH;
        case SHA1: return CC_SHA1_DIGEST_LENGTH;
        case SHA224: return CC_SHA224_DIGEST_LENGTH;
        case SHA256: return CC_SHA256_DIGEST_LENGTH;
        case SHA384: return CC_SHA384_DIGEST_LENGTH;
        case SHA512: return CC_SHA512_DIGEST_LENGTH;
        default: return 0;
    }
}

@end