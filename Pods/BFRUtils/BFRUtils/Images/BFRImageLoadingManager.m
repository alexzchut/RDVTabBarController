//
//  BFRImageLoadingManager.m
//  BFRUtils
//
//  Created by Andrew Yates on 03/05/2016.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import "BFRImageLoadingManager.h"
#import "UIImageView+AFNetworking.h"

@interface BFRImageLoadingManager()

@property (strong, nonnull) BFRImageProxies *imageProxies;

@end

@implementation BFRImageLoadingManager

#pragma mark - Manager

+ (BFRImageLoadingManager*)sharedManager {
    static BFRImageLoadingManager *sharedManager = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedManager = [[BFRImageLoadingManager alloc] initWithWidth:1000 height:1000];
    });
    return sharedManager;
}

#pragma mark - Defaults

- (id)initWithWidth:(NSUInteger)width height:(NSUInteger)height {
    self = [super init];
    
    if (self) {
        self.width = width;
        self.height = height;
        self.weServImageQuality = 100;
        self.imageProxies = [[BFRImageProxies alloc] init];
    }
    
    return self;
}

#pragma mark - Methods


- (void)setImageView:(UIImageView *)imageView url:(NSURL *)url completion:(nullable void (^)(UIImage *image, NSError *error))completion {
    [self setImageView:imageView url:url transformation:BFRImageProxyTransformationNone completion:completion];
}

- (void)setImageView:(UIImageView *)imageView url:(NSURL *)url transformation:(BFRImageProxyTransformation)transformationType completion:(nullable void (^)(UIImage *image, NSError *error))completion {
    [self setImageView:imageView url:url transformation:transformationType width:self.width height:self.height completion:completion];
}

- (void)setImageView:(UIImageView *)imageView url:(NSURL *)url transformation:(BFRImageProxyTransformation)transformationType width:(NSUInteger)width height:(NSUInteger)height completion:(nullable void (^)(UIImage *image, NSError *error))completion {
    
    NSURL *proxiedURL = [self.imageProxies proxyURLForURLString:url.absoluteString type:transformationType width:width height:height];
    
    __weak UIImageView *weakImageView = imageView;
    
    [imageView setImageWithURLRequest:[NSURLRequest requestWithURL:proxiedURL] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        
        if(image){
            dispatch_async(dispatch_get_main_queue(), ^{
                [imageView setImage:image];
                [imageView setNeedsLayout];
                if(completion)
                    completion(image, nil);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakImageView setImageWithURLRequest:[NSURLRequest requestWithURL:url] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakImageView setImage:image];
                        [weakImageView setNeedsLayout];
                        if(completion)
                            completion(image, nil);
                    });
                } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                    if(completion)
                        completion(nil, error);
                }];
            });
        }
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakImageView setImageWithURLRequest:[NSURLRequest requestWithURL:url] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakImageView setImage:image];
                    [weakImageView setNeedsLayout];
                });
                if(completion)
                    completion(image, nil);
            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                if(completion)
                    completion(nil, error);
            }];
        });
    }];
}

@end
