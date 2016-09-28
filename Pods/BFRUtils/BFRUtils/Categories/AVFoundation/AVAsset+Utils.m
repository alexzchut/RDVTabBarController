//
//  AVAsset+Utils.m
//  BFRUtils
//
//  Created by Jordan Morgan on 6/23/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import "AVAsset+Utils.h"

@implementation AVAsset (Utils)
- (NSString *)slowMotionVideoLength {
    
    if (self.tracks.count >= 2 && [self.tracks.firstObject isKindOfClass:[AVCompositionTrack class]]) {
        AVCompositionTrack *videoTrack = (AVCompositionTrack *)self.tracks.firstObject;
        if ([videoTrack.mediaType isEqualToString:AVMediaTypeVideo]) {
            NSInteger minutes;
            NSInteger seconds;
            
            CMTimeMapping lastTrackLength = videoTrack.segments.lastObject.timeMapping;
            float videoLength = CMTimeGetSeconds(CMTimeAdd(lastTrackLength.source.duration, lastTrackLength.target.start));
            minutes = (NSInteger)(videoLength/60.0f);
            seconds = (NSInteger)ceil(videoLength - 60.0f * (double)minutes);
            
            return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
        }
    } else {
        return @"00:00";
    }
    
    return @"00:00";
}

@end
