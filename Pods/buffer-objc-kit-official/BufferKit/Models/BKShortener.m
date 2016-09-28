//
//  BKShortener.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKShortener.h"

@implementation BKShortener

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"domain": @"domain",
        @"login": @"login",
        @"selected": @"selected",
        @"tracking": @"tracking",
    };
}

@end
