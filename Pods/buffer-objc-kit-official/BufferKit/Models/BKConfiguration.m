//
//  BKConfiguration.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 16/07/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKConfiguration.h"

@implementation BKConfiguration

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"services": @"services",
        @"plans": @"plans.types"
    };
}

@end
