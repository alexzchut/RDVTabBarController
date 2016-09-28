//
//  BFRImageProxies.h
//  BFRUtils
//
//  Created by Jordan Morgan on 2/22/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

/**
 If using the WeServ proxy, this enum represents the desired shape of the image.
 */
typedef enum : NSUInteger {
    /**
     *  The default shape.
     */
    BFRImageProxyTransformationNone,
    /**
     *  Requests the image to be in a 1:1 square shape.
     */
    BFRImageProxyTransformationSquare,
} BFRImageProxyTransformation;

/**
 Represents the two types of image proxy services supported, WeServ and Google Image Proxy.
 */
typedef enum : NSUInteger {
    /**
     *  The WeServ image proxy service.
     */
    BFRImageProxyServiceTypeWeServ,
    /**
     *  The Google Image Proxy service.
     */
    BFRImageProxyServiceTypeGoogle,
    /**
     *  If used, this will fall back to the default service, which is WeServ.
     */
    BFRImageProxyServiceDefault,
} BFRImageProxyServiceType;


/**
 *  This class exposes functionality for the WeServ and Google image proxies.
 */
@interface BFRImageProxies : NSObject

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

#pragma mark - Initializers
/**
 *  Initializes an instance of this class with the preferred service, height and width to use for proxy requests.
 *
 *  @param service The desired service to default to.
 *  @param width The default width to use for image proxy requests.
 *  @param height The default height to use for image proxy requests.
 *
 *  @return An instance of this class configured to use for a particular proxy service.
 */
- (instancetype _Nonnull)initWithWidth:(NSUInteger)width height:(NSUInteger)height;

- (instancetype _Nonnull)initWithService:(BFRImageProxyServiceType)service width:(NSUInteger)width height:(NSUInteger)height; // Just keeping this here for now.

# pragma mark - Media helpers

/**
 *  Obtains a URL string from a media dictionary. The first value found by the following order is returned: "picture" > "photo" > "fullsize" > "imageURL" > "thumbnail".
 *
 *  @param media The dictionary containing all of the information about the media.
 *
 *  @return The first string value found in the media dictionary.
 */
+ (NSString *_Nullable)URLStringFromMedia:(NSDictionary *_Nonnull)media;

/**
 *  Attempts to retrieve the URL from the supplied media dictionary.
 *
 *  @param media The dictionary containing all of the information about the media.
 *
 *  @return The @c NSURL for the proxy representation of the media, if it exists.
 */
- (NSURL *_Nullable)proxyURLForMedia:(NSDictionary *_Nonnull)media;

# pragma mark - GIF check
// Utility method to check if the media has a URL (from URLStringFromMedia) that is a GIF

/**
 *  Determines if the media contains a GIF representation.
 *
 *  @param media The dictionary containing all of the information about the media.
 *
 *  @return Returnes YES if the media contains a GIF.
 */
+ (BOOL)mediaIsGIF:(NSDictionary *_Nonnull)media;

// Utility method that checks the path extension of the URL to verify that the URL is a GIF resource

/**
 *  Checks the path extension of the supplied @c NSString to determine if it's a GIF resource.
 *
 *  @param urlString The @c NSString to check against to determine if it's a GIF resource.
 *
 *  @return Returns YES if the @param urlString is a GIF.
 */
+ (BOOL)URLStringIsGIF:(NSString *_Nonnull)urlString;

/**
 *  Checks the path extension of the supplied @c NSURL to determine if it's a GIF resource.
 *
 *  @param url The @c NSURL to check against to determine if it's a GIF resource.
 *
 *  @return Returns YES if the @param urlString is a GIF.
 */
+ (BOOL)URLIsGIF:(NSURL *_Nonnull)url;

/**
 *  Checks the UTI string of the @c PHAsset instance to determine whether or not it's a GIF resource.
 *
 *  @param asset The @c PHAsset to check against to determine if it's a GIF resource.
 *
 *  @return Returns YES if the @param asset is a GIF.
 */
+ (BOOL)assetIsGif:(PHAsset *_Nonnull)asset;

# pragma mark - Proxy helpers
/**
 *  Returns the proxy URL from the supplied image URL. NOTE - this will use the instance's height, width and default transformation type for the request.
 *
 *  @param imageURL The URL for the image to be proxied.
 *
 *  @return The proxy URL for the image.
 */
- (NSURL *_Nonnull)proxyURLForURL:(NSURL *_Nonnull)imageURL;

/**
 *  Returns the proxy URL for the supplied image string if it exists for the transformation type. The values for the instance's height, width and service properties will be used to generate the proxy URL.
 *
 *  @param imageURLString     The string of the image URL.
 *  @param transformationType The type of transformation to query for.
 *
 *  @return The URL for the image and transformation type, if it exists.
 */
- (NSURL *_Nullable)proxyURLForURLString:(NSString *_Nonnull)imageURLString type:(BFRImageProxyTransformation)transformationType;

- (NSURL *_Nullable)proxyURLForURLString:(NSString *_Nonnull)imageURLString type:(BFRImageProxyTransformation)transformationType service:(BFRImageProxyServiceType)type;  // Keeping this here for now


/**
 *  Returns the proxy URL for the supplied image string if it exists for the transformation type. This will use the instance's service property when creating the proxy URL.
 *
 *  @param imageURLString     The string of the image URL.
 *  @param transformationType The type of transformation to query for.
 *  @param width The desired width of the image.
 *  @param height The desired height of the image.
 *
 *  @return The URL for the image and transformation type, if it exists.
 */
- (NSURL *_Nullable)proxyURLForURLString:(NSString *_Nonnull)imageURLString type:(BFRImageProxyTransformation)transformationType width:(NSUInteger)width height:(NSUInteger)height;

- (NSURL *_Nullable)proxyURLForURLString:(NSString *_Nullable)imageURLString type:(BFRImageProxyTransformation)transformationType width:(NSUInteger)width height:(NSUInteger)height service:(BFRImageProxyServiceType)type;

/**
 *  Returns a nonmutable collection of the proxy URLs for the image URLs passed in.
 *
 *  @param imageURLList The @ NSURL representations of the image URLs to check for proxies for.
 *  @param skipGIF            Is YES, GIFs will not be included.
 *
 *  @return An @c NSArray of @c NSURL instances that point to each image's proxy.
 */
- (NSArray *_Nonnull)proxyURLsForURLList:(NSArray *_Nonnull)imageURLList skipGIF:(BOOL)skipGIF;

- (NSArray *_Nonnull)proxyURLsForURLList:(NSArray *_Nonnull)imageURLList skipGIF:(BOOL)skipGIF service:(BFRImageProxyServiceType)service;

/**
 *  Returns a nonmutable collection of the proxy URLs for the image URLs passed in, which are constructed according to the options sent in from the parameters.
 *
 *  @param imageURLStringList The strings representations of the image URLs to check for proxies for.
 *  @param skipGIF            Is YES, GIFs will not be included.
 *  @param transformationType The type of transformation to query for.
 *  @param width The desired width of the image.
 *  @param height The desired height of the image.
 *  @param service The proxy service to use.
 *
 *  @return An @c NSArray of @c NSURL instances that point to each image's proxy.
 */
- (NSArray *_Nonnull)proxyURLsForURLList:(NSArray *_Nonnull)imageURLStringList skipGIF:(BOOL)skipGIF type:(BFRImageProxyTransformation)transformationType width:(NSUInteger)width height:(NSUInteger)height;

- (NSArray *_Nullable)proxyURLsForURLList:(NSArray *_Nonnull)imageURLList skipGIF:(BOOL)skipGIF type:(BFRImageProxyTransformation)transformationType width:(NSUInteger)width height:(NSUInteger)height service:(BFRImageProxyServiceType)service; // Keeping this here for now

@end
