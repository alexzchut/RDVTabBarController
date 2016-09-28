//
//  BFRCustomSelectTableViewCell.m
//  BFRStyleGuide
//
//  Created by Jordan Morgan on 6/16/16.
//  Copyright © 2016 Andrew Yates. All rights reserved.
//

#import "BFRCustomSelectTableViewCell.h"
#import "Masonry.h"
#import "BFRUtils.h"

@interface BFRCustomSelectTableViewCell()

@property (strong, nonatomic) UIView *topSeparatorView;

@end

@implementation BFRCustomSelectTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UIColor *topSeperatorColor = self.topSeparatorColor ?: [UIColor bfr_borderColor];
        UIColor *selectedBackgroundColor = self.selectedBackgroundColor ?: [UIColor universalColorFromHexString:@"f4f7f9"];
        
        self.topSeparatorView = [UIView new];
        self.topSeparatorView.hidden = YES;
        self.topSeparatorView.backgroundColor = topSeperatorColor;
        [self.contentView addSubview:self.topSeparatorView];
        
        UIView *selectedBackgroundview = [UIView new];
        selectedBackgroundview.backgroundColor = selectedBackgroundColor;
        self.selectedBackgroundView = selectedBackgroundview;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Ref: http://stackoverflow.com/questions/18924589/uitableviewcell-separator-disappearing-in-ios7
    for (UIView *subview in self.contentView.superview.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
            subview.hidden = NO;
        }
    }
}

- (void)updateConstraints {
    [self.topSeparatorView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.contentView.mas_top).offset(-0.5);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(.95);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@0.5);
    }];
    
    [super updateConstraints];
}

#pragma mark - Tableview APIs
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];

    if (self.selectionStyle != UITableViewCellSelectionStyleDefault) {
        return;
    }
    
    if (self.hideTopSeparator) {
        self.topSeparatorView.hidden = YES;
    } else {
        self.topSeparatorView.hidden = !highlighted;
    }
    
    if (self.setViewsForSelectedState && highlighted) {
        self.topSeparatorView.backgroundColor = self.topSeparatorColor ?: [UIColor bfr_borderColor];
        self.setViewsForSelectedState();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (self.selectionStyle != UITableViewCellSelectionStyleDefault) {
        return;
    }
    
    if (self.hideTopSeparator) {
        self.topSeparatorView.hidden = YES;
    } else {
        self.topSeparatorView.hidden = !selected;
    }
    
    if (self.setViewsForSelectedState && selected) {
        self.topSeparatorView.backgroundColor = self.topSeparatorColor ?: [UIColor bfr_borderColor];
        self.setViewsForSelectedState();
    }
}

@end
