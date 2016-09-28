//
//  BKFriend.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "Mantle.h"

@interface BKFriend : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSURL *avatarURL;
@property (nonatomic, copy, readonly) NSString *friendID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *screenname;
@property (nonatomic, copy, readonly) NSString *canonicalSearchTerm;

@end
