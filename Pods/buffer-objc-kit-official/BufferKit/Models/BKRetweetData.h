//
//  BKRetweetData.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "Mantle.h"

@interface BKRetweetData : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *tweetID;
@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *screenname;
@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) NSURL *avatarHTTP;
@property (nonatomic, copy, readonly) NSURL *avatarHTTPS;
@property (nonatomic, copy, readonly) NSURL *tweetURL;

@end
