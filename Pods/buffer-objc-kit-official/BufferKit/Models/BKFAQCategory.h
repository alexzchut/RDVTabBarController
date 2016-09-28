//
//  BKFAQCategory.h
//  BufferKitDemo
//
//  Created by Jordan Morgan on 2/9/16.
//  Copyright © 2016 Andrew Yates. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BKFAQCategory : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *categoryID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *categoryURL;

@end
