//
//  BFRImageLoadingManager.h
//  BFRUtils
//
//  Created by Andrew Yates on 03/05/2016.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFRImageProxies.h"
#import <UIKit/UIKit.h>

@interface BFRImageLoadingManager : NSObject

+ (id _Nonnull)sharedManager;

/**
 *  The default width that will be supplied to the image proxy requests.
 */
@property (nonatomic) NSInteger width;

/**
 *  The default height that will be supplued to the image proxy requets.
 */
@property (nonatomic) NSInteger height;

/**
 *  The quality of the image requested from WeServ. Default is 100.
 */
@property (nonatomic) NSInteger weServImageQuality;


- (void)setImageView:(UIImageView * _Nonnull)imageView url:(NSURL * _Nonnull)url completion:(nullable void (^)(UIImage * _Nullable image, NSError * _Nullable error))completion;

- (void)setImageView:(UIImageView * _Nonnull)imageView url:(NSURL * _Nonnull)url transformation:(BFRImageProxyTransformation)transformationType completion:(nullable void (^)(UIImage * _Nullable image, NSError * _Nullable error))completion;

- (void)setImageView:(UIImageView * _Nonnull)imageView url:(NSURL * _Nonnull)url transformation:(BFRImageProxyTransformation)transformationType width:(NSUInteger)width height:(NSUInteger)height completion:(nullable void (^)(UIImage * _Nullable image, NSError * _Nullable error))completion;

@end
