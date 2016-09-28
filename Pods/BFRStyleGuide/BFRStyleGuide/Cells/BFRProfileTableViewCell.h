//
//  BFRProfileTableViewCell.h
//  BFRComposer
//
//  Created by Andrew Yates on 04/06/2015.
//  Copyright (c) 2015 Andrew Yates. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFRStyleGuide.h"
#import "BFRCustomSelectTableViewCell.h"

@interface BFRProfileTableViewCell : BFRCustomSelectTableViewCell

- (void)setProfile:(BKProfile *)profile;
- (void)setProfileSelected:(BOOL)selected;
- (void)setProfileQueueCountHidden:(BOOL)hidden;

@end
