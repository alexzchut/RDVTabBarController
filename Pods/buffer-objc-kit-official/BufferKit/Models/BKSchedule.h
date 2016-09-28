//
//  BKSchedule.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "Mantle.h"

@interface BKSchedule : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSArray *days;
@property (nonatomic, copy, readonly) NSArray *times;

@end
