//
//  NSURL+Utils.h
//  BFRUtils
//
//  Created by Jordan Morgan on 4/13/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Utils)

/**
 *  Returns a new @c NSURL instance created with http:// or https:// prepended, or nil if it's invalid.
 *
 *  @return The new @c NSURL instance.
 */
- (NSURL * _Nullable)urlWithScheme;

/**
 *  Ensures the @c NSURL instance has a valid scheme.
 *
 *  @return YES if the URL is has a scheme.
 */
- (BOOL)isValidHTTPorHTTPS;

/**
 *  Ensures the @c NSURL instance is fully qualified.
 *
 *  @return YES if the URL is fully qualified.
 */
- (BOOL)isValidURL;
@end
