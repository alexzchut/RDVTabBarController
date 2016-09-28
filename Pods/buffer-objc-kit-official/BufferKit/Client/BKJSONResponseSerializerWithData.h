//
//  BFRJSONResponseSerializerWithData.h
//  Buffer
//
//  Created by Andrew Yates on 25/02/2014.
//
//

#import <Foundation/Foundation.h>

#import "AFURLResponseSerialization.h"

/// NSError userInfo key that will contain response data
static NSString * const JSONResponseSerializerWithDataKey = @"JSONResponseSerializerWithDataKey";

@interface BKJSONResponseSerializerWithData : AFJSONResponseSerializer

@end
