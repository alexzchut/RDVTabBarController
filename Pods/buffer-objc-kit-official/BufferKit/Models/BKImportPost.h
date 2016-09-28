//
//  BKFeedPost.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 03/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "Mantle.h"

@interface BKImportPost : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *importItemID;
@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, copy, readonly) NSURL *importIcon;
@property (nonatomic, copy, readonly) NSString *importType;
@property (nonatomic, copy, readonly) NSDictionary *media;
@property (nonatomic, copy, readonly) NSDictionary *shortenedLinks;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) NSString *via;
@property (nonatomic, copy, readonly) NSURL *viaURL;
@property (nonatomic, copy, readonly) NSURL *link;

@end
