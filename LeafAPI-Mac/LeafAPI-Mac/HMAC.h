//
//  HMAC.h
//  LeafAPI
//
//  Created by William K Chen on 6/24/14.
//  Copyright (c) 2014 Leaf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMAC : NSObject

+ (NSString *)calculateSHA512Base64WithKey:(NSString *)key andData:(NSString *)data;


@end