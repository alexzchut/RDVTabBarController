//
//  BKImport.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "Mantle.h"

@interface BKImport : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *importID;
@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, copy, readonly) NSURL *iconURL;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSURL *feedURL;
@property (nonatomic, copy, readonly) NSString *profileID;
@property (nonatomic, copy, readonly) NSString *twitterUsername;
@property (nonatomic, copy, readonly) NSString *type;

@end
