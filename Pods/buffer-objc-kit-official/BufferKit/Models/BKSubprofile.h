//
//  BKSubprofile.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 04/05/2015.
//  Copyright (c) 2015 Andrew Yates. All rights reserved.
//

#import "Mantle.h"

@interface BKSubprofile : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *profileID;
@property (nonatomic, copy, readonly) NSURL *avatarHTTPS;
@property (nonatomic, readonly) BOOL isShared;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *service;
@property (nonatomic, copy, readonly) NSString *url;
@property (nonatomic, copy, readonly) NSString *userID;

@end
