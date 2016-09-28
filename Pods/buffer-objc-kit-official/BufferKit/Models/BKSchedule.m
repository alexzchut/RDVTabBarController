//
//  BKSchedule.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKSchedule.h"

@implementation BKSchedule

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"days": @"days",
        @"times": @"times",
    };
}

@end
