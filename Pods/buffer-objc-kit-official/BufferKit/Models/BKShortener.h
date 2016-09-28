//
//  BKShortener.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "Mantle.h"

@interface BKShortener : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *domain;
@property (nonatomic, copy, readonly) NSString *login;
@property (nonatomic, readonly) BOOL selected;
@property (nonatomic, readonly) BOOL tracking;

@end
