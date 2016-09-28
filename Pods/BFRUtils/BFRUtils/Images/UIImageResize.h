//
//  UIImageResize.h
//  Buffer
//
//  Created by Andrew Yates on 07/11/2012.
//
//

#import <UIKit/UIKit.h>

@interface UIImageResize : NSObject

/**
 *  Creates an @c UIImage scaled to a particular width.
 *
 *  @param sourceImage The image to scale.
 *  @param i_width     The scale factor.
 *
 *  @return A @c UIImage scaled to a particular width.
 */
+(UIImage*)imageWithImage:(UIImage *)sourceImage scaledToWidth:(float)i_width;

/**
 *  Creates an @c UIImage scaled to a particular height.
 *
 *  @param sourceImage The image to scale.
 *  @param i_wheight     The scale factor.
 *
 *  @return A @c UIImage scaled to a particular height.
 */
+(UIImage*)imageWithImage:(UIImage *)sourceImage scaledToHeight:(float)i_height;

@end
