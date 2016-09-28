//
//  BFRProfileAvatar.h
//  BFRStyleGuide
//
//  Created by Andrew Yates on 03/06/2015.
//  Copyright (c) 2015 Andrew Yates. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BufferKit.h"

@interface BFRProfileAvatar : UIView

typedef enum BFRProfileAvatarSize : NSInteger BFRProfileAvatarSize;
enum BFRProfileAvatarSize : NSInteger {
    BFRProfileAvatarSizeCell,
    BFRProfileAvatarSizeNavBar,
    BFRProfileAvatarSizeMeta,
    BFRProfileAvatarSizeOnboarding,
    BFRProfileAvatarSizeWidget
};

@property (nonatomic) BFRProfileAvatarSize size;

- (void)setProfile:(BKProfile *)p;
- (void)setSelected:(BOOL)selected;

@end
