//
//  BKConfiguration.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 16/07/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "Mantle.h"

@interface BKConfiguration : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSDictionary *services;
@property (nonatomic, copy, readonly) NSDictionary *plans;

@end
