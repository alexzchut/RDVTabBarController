//
//  BKFAQ.h
//  BufferKitDemo
//
//  Created by Jordan Morgan on 2/9/16.
//  Copyright © 2016 Andrew Yates. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BKFAQ : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *answer;
@property (strong, nonatomic) NSString *categoryID;
@property (nonatomic, readonly) BOOL isDraft;
@property (strong, nonatomic) NSString *faqID;
@property (strong, nonatomic) NSNumber *orderInCategory;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *faqURL;

@end
