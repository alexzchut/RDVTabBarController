//
//  BFRImageUtils.h
//  BFRComposer
//
//  Created by Humberto Aquino on 1/6/16.
//  Copyright © 2016 Andrew Yates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface BFRImageUtils : NSObject

/**
 *  Detects whether or not the instance is a .gif.
 *
 *  @param imageSource The image reference to test.
 *
 *  @return YES if the image reference is a .gif.
 */
+ (BOOL)isGIF:(CGImageSourceRef)imageSource;

/**
 *  Detects whether or not the instance is an animated .gif.
 *
 *  @param imageSource The image reference to test.
 *
 *  @return YES if the image reference is an animated .gif.
 */
+ (BOOL)isAnimatedGIF:(CGImageSourceRef)imageSource;

/**
 *  Converts gif data into a @c UIImage instance.
 *
 *  @param gifData The data to convert into an image.
 *
 *  @return A @c UIImage instance converted from the data.
 */
+ (UIImage *)GIFToPng:(NSData *)gifData;

/**
 *  Returns a @c CGRect that has been scaled to the current view's size while respecting the @c UIImage aspect ratio.
 *
 *  @param image The image to scale.
 *
 *  @param view The view to scale the image's rect to.
 *
 *  @return A scaled CGRect that still considers the image's aspect ratio.
 */
+ (CGRect)scaleImage:(UIImage *)image toView:(UIView *)view;

@end
