//
//  BFRProfileTableViewCell.m
//  BFRComposer
//
//  Created by Andrew Yates on 04/06/2015.
//  Copyright (c) 2015 Andrew Yates. All rights reserved.
//

#import "BFRProfileTableViewCell.h"
#import "Masonry.h"
#import "BFRUtils.h"
#import "BFRThemeManager.h"

@interface BFRProfileTableViewCell()

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (strong, nonatomic) UIView *contentContainerView;
@property (strong, nonatomic) UIView *labelContainerView;
@property (strong, nonatomic) BFRProfileAvatar *avatarView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *serviceLabel;
@property (strong, nonatomic) UILabel *queueCountLabel;
@property (strong, nonatomic) UIImageView *checkmarkImageView;
@property (nonatomic, assign) BOOL profileSelected;
@property (strong, nonatomic) BKProfile *cellProfile;

@end

@implementation BFRProfileTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setAccessibilityTraits:UIAccessibilityTraitButton];
        
        self.backgroundColor = [[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.backgroundColor"];
        self.contentView.backgroundColor = [[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.backgroundColor"];
        
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        
        // Content Container
        self.contentContainerView = [UIView new];
        [self.contentContainerView setMas_key:@"contentContainerView"];
        [self.contentContainerView setBackgroundColor:[[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.backgroundColor"]];
        [self.contentView addSubview:self.contentContainerView];
        
        self.avatarView = [[BFRProfileAvatar alloc] init];
        [self.avatarView setIsAccessibilityElement:NO];
        [self.contentContainerView addSubview:self.avatarView];
        
        self.labelContainerView = [UIView new];
        [self.labelContainerView setMas_key:@"contentContainerView"];
        [self.labelContainerView setBackgroundColor:[[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.backgroundColor"]];
        [self.contentView addSubview:self.labelContainerView];
        
        self.nameLabel = [UILabel new];
        [self.nameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.nameLabel setNumberOfLines:1];
        [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.nameLabel setFont: [UIFont bfr_semiboldFontOfDynamicSize:14.0]];
        [self.nameLabel setTextColor:[[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.textLabelColor"]];
        [self.nameLabel setHighlightedTextColor: [UIColor bfr_primaryColor]];
        [self.nameLabel setBackgroundColor:[[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.backgroundColor"]];
        [self.labelContainerView addSubview:self.nameLabel];
        
        self.serviceLabel = [UILabel new];
        [self.serviceLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.serviceLabel setNumberOfLines:1];
        [self.serviceLabel setTextAlignment:NSTextAlignmentLeft];
        [self.serviceLabel setFont: [UIFont bfr_regularFontOfDynamicSize:12.0]];
        [self.serviceLabel setTextColor: [[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.detailLabelColor"]];
        [self.serviceLabel setHighlightedTextColor: [UIColor bfr_primaryColor]];
        [self.serviceLabel setBackgroundColor:[[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.backgroundColor"]];
        [self.serviceLabel setIsAccessibilityElement:NO];
        [self.labelContainerView addSubview:self.serviceLabel];
        
        self.queueCountLabel = [UILabel new];
        [self.queueCountLabel setNumberOfLines:1];
        [self.queueCountLabel setTextAlignment:NSTextAlignmentCenter];
        [self.queueCountLabel setFont: [UIFont bfr_regularFontOfDynamicSize:11.0]];
        [self.queueCountLabel setTextColor: [UIColor whiteColor]];
        [self.queueCountLabel setHighlightedTextColor: [UIColor whiteColor]];
        [self.queueCountLabel setBackgroundColor:[UIColor colorFromHexString:@"#9BA6AF"]];
        [self.queueCountLabel.layer setCornerRadius:10.0];
        [self.queueCountLabel.layer setMasksToBounds:YES];
        [self.labelContainerView addSubview:self.queueCountLabel];
        
        self.checkmarkImageView = [UIImageView new];
        [self.checkmarkImageView setImage:[UIImage imageNamed:@"check"]];
        [self.checkmarkImageView setHidden:YES];
        [self.contentView addSubview:self.checkmarkImageView];
        
        __weak BFRProfileTableViewCell *weakself = self;
        self.setViewsForSelectedState = ^{
            [weakself.avatarView setSelected:YES];
            [weakself.queueCountLabel setBackgroundColor:[UIColor bfr_primaryColor]];
        };
    }
    return self;
}

- (void)setProfile:(BKProfile *)newProfile {
    if(newProfile != self.cellProfile){
        self.cellProfile = newProfile;
        
        [self.nameLabel setText:self.cellProfile.serviceUsername];
        
        if(newProfile.isDisabled){
            [self.serviceLabel setText:@"Locked"];
        } else {
            [self.serviceLabel setText:self.cellProfile.formattedService];
        }
        
        [self.avatarView setProfile:self.cellProfile];
        [self.queueCountLabel setText:[NSString stringWithFormat:@"%@", [[self.cellProfile counts] valueForKey:@"pending"]]];
        
        [self setAccessibilityLabel:[NSString stringWithFormat:@"%@ %@ %@ pending posts", self.cellProfile.serviceUsername, self.cellProfile.formattedService, [[self.cellProfile counts] valueForKey:@"pending"]]];
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if(selected){
        self.backgroundColor = [[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.highlightedColor"];
        self.selectedBackgroundView.backgroundColor = [[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.highlightedColor"];
        self.topSeparatorColor = [[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.seperatorColor"];
    } else {
        self.backgroundColor = [[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.backgroundColor"];
        self.selectedBackgroundView.backgroundColor = [[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.highlightedColor"];
        self.topSeparatorColor = [[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.seperatorColor"];
    }
}

- (void)setProfileSelected:(BOOL)selected {
    if([self.queueCountLabel isHidden]){
        self.nameLabel.textColor = selected ? [[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.textLabelColor"] : [UIColor colorFromHexString:@"#9BA6AF"];
        self.serviceLabel.textColor = selected ? [[BFRThemeManager sharedManager] colorForKey:@"tableView.cell.detailLabelColor"] : [UIColor colorFromHexString:@"#CED7DF"];
        
        [self.checkmarkImageView setHidden:!selected];
        
        [self.avatarView setSelected:selected];
    } else {
        if(selected || self.isSelected){
            [self.queueCountLabel setBackgroundColor:[UIColor bfr_primaryColor]];
        } else {
            //The tableview reloads when a profile is tapped. This ensures the bfr_primaryColor stays (see setHighlight/Selected in superclass)
            [self.queueCountLabel setBackgroundColor:[UIColor colorFromHexString:@"#9BA6AF"]];
        }
    }
    
    if(selected){
        [self setAccessibilityTraits:UIAccessibilityTraitButton|UIAccessibilityTraitSelected];
    } else {
        [self setAccessibilityTraits:UIAccessibilityTraitButton];
    }
    
    [self.nameLabel setNeedsDisplay];
    [self.serviceLabel setNeedsDisplay];
    [self.avatarView setNeedsDisplay];
    [self.queueCountLabel setNeedsDisplay];
}

- (void)setProfileQueueCountHidden:(BOOL)hidden {
    [self.queueCountLabel setHidden:hidden];
    
    if(hidden){
        [self setAccessibilityLabel:[NSString stringWithFormat:@"%@ %@", self.cellProfile.serviceUsername, self.cellProfile.formattedService]];
    } else {
        [self setAccessibilityLabel:[NSString stringWithFormat:@"%@ %@ %@ pending posts", self.cellProfile.serviceUsername, self.cellProfile.formattedService, [[self.cellProfile counts] valueForKey:@"pending"]]];
    }
}

- (void)updateConstraints {
    if(!self.didSetupConstraints){
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
        }];
        
        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentContainerView.mas_centerY);
            make.left.equalTo(self.contentContainerView.mas_left).offset(18);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        
        [self.labelContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarView.mas_right).offset(16);
            make.right.equalTo(self.contentContainerView.mas_right).offset(-8);
            make.centerY.equalTo(self.contentContainerView.mas_centerY);
            make.height.equalTo(self.labelContainerView.mas_height);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.labelContainerView.mas_left);
            make.top.equalTo(self.labelContainerView.mas_top);
            make.right.equalTo(self.queueCountLabel.mas_left).offset(-10);
        }];
        
        [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.labelContainerView.mas_left);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(4);
            make.bottom.equalTo(self.labelContainerView.mas_bottom);
            make.right.equalTo(self.queueCountLabel.mas_left).offset(-10);
        }];
        
        [self.checkmarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-16);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@19);
            make.height.equalTo(@14);
        }];
        
        [self.queueCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-16);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@30);
            make.height.equalTo(@20);
        }];
    }
    
    [super updateConstraints];
}

@end
