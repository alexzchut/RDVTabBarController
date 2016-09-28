//
//  BFRProfileAvatar.m
//  BFRStyleGuide
//
//  Created by Andrew Yates on 03/06/2015.
//  Copyright (c) 2015 Andrew Yates. All rights reserved.
//

#import "BFRProfileAvatar.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BFRStyleGuide.h"
#import "TTTAttributedLabel.h"

@interface BFRProfileAvatar()

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UIView *serviceContainer;
@property (strong, nonatomic) UIView *serviceBackground;
@property (strong, nonatomic) UILabel *serviceIconLabel;
@property (strong, nonatomic) BKProfile *avatarProfile;

@end

@implementation BFRProfileAvatar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.avatarImageView = [[UIImageView alloc] init];
        [self.avatarImageView setClipsToBounds:YES];
        [self.serviceBackground setBackgroundColor:[UIColor bfr_lightBorderColor]];
        [self addSubview:self.avatarImageView];
        
        self.serviceContainer = [UIView new];
        if([[[BFRThemeManager sharedManager] currentThemeName] isEqualToString:@"dark"]){
            [self.serviceContainer setBackgroundColor:[UIColor clearColor]];
        } else {
            [self.serviceContainer setBackgroundColor:[UIColor whiteColor]];
        }
        [self addSubview:self.serviceContainer];
        
        self.serviceBackground = [UIView new];
        [self addSubview:self.serviceBackground];
        
        self.serviceIconLabel = [UILabel new];
        [self.serviceIconLabel setTextColor:[UIColor whiteColor]];
        [self.serviceIconLabel setFont:[UIFont fontWithName:@"Socicon" size:70]];
        [self.serviceIconLabel setTextAlignment:NSTextAlignmentCenter];
        [self.serviceIconLabel setIsAccessibilityElement:NO];
        [self.serviceBackground addSubview:self.serviceIconLabel];
        
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [[UIScreen mainScreen] nativeScale];
    }
    return self;
}

#pragma mark - Population

- (void)setProfile:(BKProfile *)newProfile {
    if(!newProfile || [newProfile isKindOfClass:[NSNull class]]){
        [self.avatarImageView setImage:nil];
        [self.serviceBackground setBackgroundColor:[UIColor clearColor]];
        [self.serviceIconLabel setText:@""];
        return;
    }
    
    if([[[BFRThemeManager sharedManager] currentThemeName] isEqualToString:@"dark"]){
        [self.serviceContainer setBackgroundColor:[UIColor clearColor]];
    } else {
        [self.serviceContainer setBackgroundColor:[UIColor whiteColor]];
    }
    
    if(newProfile != self.avatarProfile){
        [self.avatarImageView setImage:nil];
        [self.avatarImageView setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    self.avatarProfile = newProfile;
    
    if(![self.avatarProfile.avatarHTTPS isKindOfClass:[NSNull class]]){
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        
        [manager downloadImageWithURL:self.avatarProfile.avatarHTTPS options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (image) {
                [self.avatarImageView setImage:image];
                [self.avatarImageView setBackgroundColor:[UIColor clearColor]];
            } else {
                [self.avatarImageView setBackgroundColor:[UIColor lightGrayColor]];
            }
        }];
    } else {
        [self.avatarImageView setImage:nil];
        [self.avatarImageView setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    CGFloat iconSize = 10.0f;
    if(self.size == BFRProfileAvatarSizeNavBar){
        iconSize = 8.0f;
    } else if(self.size == BFRProfileAvatarSizeCell){
        iconSize = 10.0f;
    } else if(self.size == BFRProfileAvatarSizeMeta) {
        iconSize = 10.0f;
    } else if(self.size == BFRProfileAvatarSizeOnboarding) {
        iconSize = 15.0f;
        [self.serviceBackground setBackgroundColor:[UIColor clearColor]];
    }
    
    NSString *serviceIconString = self.avatarProfile.service;
    
    if([newProfile.service isEqualToString:@"twitter"]){
        serviceIconString = @"";
    } else if([newProfile.service isEqualToString:@"facebook"]){
        serviceIconString = @"";
    } else if([newProfile.service isEqualToString:@"linkedin"]){
        serviceIconString = @"";
    } else if([newProfile.service isEqualToString:@"pinterest"]){
        serviceIconString = @"";
    } else if([newProfile.service isEqualToString:@"google"]){
        serviceIconString = @"";
    } else if([newProfile.service isEqualToString:@"appdotnet"]){
        serviceIconString = @"";
    } else if([newProfile.service isEqualToString:@"instagram"]){
        serviceIconString = @"";
    }
    
    [self.serviceIconLabel setFont:[UIFont fontWithName:@"Socicon" size:iconSize]];
    
    [self.serviceIconLabel setText:serviceIconString];
    
    if([self.avatarProfile.service isEqualToString:@"twitter"]){
        [self.serviceBackground setBackgroundColor:[UIColor bfr_twitterColor]];
    } else if([self.avatarProfile.service isEqualToString:@"facebook"]){
        [self.serviceBackground setBackgroundColor:[UIColor bfr_facebookColor]];
    } else if([self.avatarProfile.service isEqualToString:@"pinterest"]){
        [self.serviceBackground setBackgroundColor:[UIColor bfr_pinterestColor]];
    } else if([self.avatarProfile.service isEqualToString:@"linkedin"]){
        [self.serviceBackground setBackgroundColor:[UIColor bfr_linkedinColor]];
    } else if([self.avatarProfile.service isEqualToString:@"google"]){
        [self.serviceBackground setBackgroundColor:[UIColor bfr_googleColor]];
    } else if([self.avatarProfile.service isEqualToString:@"appdotnet"]){
        [self.serviceBackground setBackgroundColor:[UIColor bfr_adnColor]];
    } else if([self.avatarProfile.service isEqualToString:@"instagram"]){
        [self.serviceBackground setBackgroundColor:[UIColor bfr_instagramColor]];
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - Selected

- (void)setSelected:(BOOL)selected {
    if(!selected){
        [self.avatarImageView setAlpha:0.4];
        
        [self.serviceBackground setBackgroundColor:[UIColor colorFromHexString:@"#CED7DF"]];
    } else {
        if(![[[BFRThemeManager sharedManager] currentThemeName] isEqualToString:@"dark"]){
            [self.serviceContainer setBackgroundColor:[UIColor whiteColor]];
        }
        
        [self.avatarImageView setAlpha:1.0];
        
        if (self.avatarImageView.image == nil) {
            self.avatarImageView.backgroundColor = [UIColor lightGrayColor];
        }
        
        if([self.avatarProfile.service isEqualToString:@"twitter"]){
            [self.serviceBackground setBackgroundColor:[UIColor bfr_twitterColor]];
        } else if([self.avatarProfile.service isEqualToString:@"facebook"]){
            [self.serviceBackground setBackgroundColor:[UIColor bfr_facebookColor]];
        } else if([self.avatarProfile.service isEqualToString:@"pinterest"]){
            [self.serviceBackground setBackgroundColor:[UIColor bfr_pinterestColor]];
        } else if([self.avatarProfile.service isEqualToString:@"linkedin"]){
            [self.serviceBackground setBackgroundColor:[UIColor bfr_linkedinColor]];
        } else if([self.avatarProfile.service isEqualToString:@"google"]){
            [self.serviceBackground setBackgroundColor:[UIColor bfr_googleColor]];
        } else if([self.avatarProfile.service isEqualToString:@"appdotnet"]){
            [self.serviceBackground setBackgroundColor:[UIColor bfr_adnColor]];
        } else if([self.avatarProfile.service isEqualToString:@"instagram"]){
            [self.serviceBackground setBackgroundColor:[UIColor bfr_instagramColor]];
        }
    }
}

#pragma mark - Constraints

- (void)updateConstraints {
    if(!self.didSetupConstraints){
        
        if(self.size == BFRProfileAvatarSizeNavBar){
            [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left);
                make.top.equalTo(self.mas_top);
                make.width.equalTo(@30);
                make.height.equalTo(@30);
            }];
            
            [self.serviceContainer mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(7);
                make.bottom.equalTo(self.mas_bottom).offset(2);
                make.width.equalTo(@15);
                make.height.equalTo(@15);
            }];
            
            [self.serviceBackground mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.serviceContainer.mas_width).offset(-2);
                make.height.equalTo(self.serviceContainer.mas_height).offset(-2);
                make.center.equalTo(self.serviceContainer);
            }];
            
            [self.serviceIconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.serviceBackground.mas_width);
                make.center.equalTo(self.serviceBackground);
            }];
            
            self.avatarImageView.layer.cornerRadius = 30 / 2;
            self.serviceContainer.layer.cornerRadius = 15 / 2;
            self.serviceBackground.layer.cornerRadius = 13 / 2;
            
        } else if(self.size == BFRProfileAvatarSizeWidget){
            [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left);
                make.top.equalTo(self.mas_top);
                make.width.equalTo(@30);
                make.height.equalTo(@30);
            }];
            
            [self.serviceContainer mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(7);
                make.bottom.equalTo(self.mas_bottom).offset(2);
                make.width.equalTo(@15);
                make.height.equalTo(@15);
            }];
            
            [self.serviceBackground mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.serviceContainer.mas_width);
                make.height.equalTo(self.serviceContainer.mas_height);
                make.center.equalTo(self.serviceContainer);
            }];
            
            [self.serviceIconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.serviceBackground.mas_width);
                make.center.equalTo(self.serviceBackground);
            }];
            
            self.avatarImageView.layer.cornerRadius = 30 / 2;
            self.serviceContainer.layer.cornerRadius = 15 / 2;
            self.serviceBackground.layer.cornerRadius = 15 / 2;
            
        } else if (self.size == BFRProfileAvatarSizeCell){
            [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left);
                make.top.equalTo(self.mas_top);
                make.width.equalTo(@40);
                make.height.equalTo(@40);
            }];
            
            [self.serviceContainer mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(7);
                make.bottom.equalTo(self.mas_bottom).offset(2);
                make.width.equalTo(@20);
                make.height.equalTo(@20);
            }];
            
            [self.serviceBackground mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.serviceContainer.mas_width).offset(-2);
                make.height.equalTo(self.serviceContainer.mas_height).offset(-2);
                make.center.equalTo(self.serviceContainer);
            }];
            
            [self.serviceIconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.serviceBackground.mas_width);
                make.center.equalTo(self.serviceBackground);
            }];
            
            self.avatarImageView.layer.cornerRadius = 40 / 2;
            self.serviceContainer.layer.cornerRadius = 20 / 2;
            self.serviceBackground.layer.cornerRadius = 18 / 2;
        } else if (self.size == BFRProfileAvatarSizeOnboarding){
            [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left);
                make.top.equalTo(self.mas_top);
                make.width.equalTo(@50);
                make.height.equalTo(@50);
            }];
            
            [self.serviceContainer mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(7);
                make.bottom.equalTo(self.mas_bottom).offset(2);
                make.width.equalTo(@25);
                make.height.equalTo(@25);
            }];
            
            [self.serviceBackground mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.serviceContainer.mas_width).offset(0);
                make.height.equalTo(self.serviceContainer.mas_height).offset(0);
                make.center.equalTo(self.serviceContainer);
            }];
            
            [self.serviceIconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.serviceBackground.mas_width);
                make.center.equalTo(self.serviceBackground);
            }];
            
            self.avatarImageView.layer.cornerRadius = 50 / 2;
            self.serviceContainer.layer.cornerRadius = 25 / 2;
            self.serviceBackground.layer.cornerRadius = 25 / 2;
        }
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

@end
