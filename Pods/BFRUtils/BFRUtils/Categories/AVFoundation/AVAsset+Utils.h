//
//  AVAsset+Utils.h
//  BFRUtils
//
//  Created by Jordan Morgan on 6/23/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVAsset (Utils)

/**
 *  Returns the true length of a slow motion video by adding the instance's track lengths together.
 *
 *  @return The duration of the slow motion video in seconds.
 */
- (NSString *)slowMotionVideoLength;

@end
