//
//  BKTeamMember.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "Mantle.h"

@interface BKTeamMember : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, copy, readonly) NSURL *avatarURL;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *status;
@property (nonatomic, copy, readonly) NSString *statusCode;
@property (nonatomic, readonly) BOOL isTFAEnabled;

@end
