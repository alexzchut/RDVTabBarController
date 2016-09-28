//
//  BFRNoticeControl.m
//  Buffer
//
//  Created by Andrew Yates on 20/12/2013.
//
//

#import "BFRButton.h"
#import "TTTAttributedLabel.h"
#import "UIColor+BFRColors.h"
#import "UIFont+BFRFonts.h"

@interface BFRButton()

@property (strong) TTTAttributedLabel *countLabel;
@property (strong) UIView *countLabelBackground;
@property (strong) TTTAttributedLabel *titleLabel;
@property (strong) TTTAttributedLabel *iconLabel;

@end

@implementation BFRButton

@synthesize countLabel, countLabelBackground, titleLabel, iconLabel, buttonStyle, buttonIconFont;

static const CGFloat kCornerRadius = 3.0;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeRedraw;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        
        // Count Label
        self.countLabelBackground = [[UIView alloc] initWithFrame:CGRectZero];
        [self.countLabelBackground setBackgroundColor:[UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f]];
        [self.countLabelBackground.layer setCornerRadius:3.0];
        [self addSubview:self.countLabelBackground];
        
        self.countLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        self.countLabel.font = [UIFont bfr_semiboldFontOfSize:13.0];
        self.countLabel.textColor = [UIColor whiteColor];
        self.countLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.userInteractionEnabled = NO;
        [self.countLabelBackground addSubview:self.countLabel];
        
        // Title Label
        self.titleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.font = [UIFont bfr_regularFontOfSize:15.0];
        self.titleLabel.textColor = [UIColor bfr_primaryColor];
        self.titleLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
        self.titleLabel.userInteractionEnabled = NO;
        [self addSubview:self.titleLabel];
        
        // Icon Label
        self.iconLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        self.iconLabel.font = [UIFont fontWithName:@"SS Standard" size:15.0];
        self.iconLabel.textColor = [UIColor bfr_primaryColor];
        self.iconLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
        self.iconLabel.textAlignment = NSTextAlignmentRight;
        self.iconLabel.userInteractionEnabled = NO;
        [self addSubview:self.iconLabel];
        
        [self setExclusiveTouch:YES];
        
        [self addTarget:self action:@selector(highlightRemoval) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)highlightRemoval {
    [self performSelector:@selector(setHighlighted:) withObject:NO afterDelay:0.1];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [self.countLabel setHighlighted:highlighted];
    [self.titleLabel setHighlighted:highlighted];
    [self.iconLabel setHighlighted:highlighted];
    
    [self.countLabel setNeedsDisplay];
    [self.titleLabel setNeedsDisplay];
    [self.iconLabel setNeedsDisplay];
}

- (void)setTitle:(NSString *)title {
    UIColor *textColor = [UIColor blackColor];
    UIColor *highlightedColor = [UIColor bfr_primaryColor];
    if(buttonStyle == BFRButtonStyleGreen){
        textColor = [UIColor colorWithRed:79.0/255.0f green:149.0/255.0f blue:39.0/255.0f alpha:1.0];
        highlightedColor = [UIColor colorWithRed:127.0/255.0f green:209.0/255.0f blue:81.0/255.0f alpha:1.0];
    } else if(buttonStyle == BFRButtonStyleYellow){
        textColor = [UIColor colorWithRed:187.0/255.0f green:149.0/255.0f blue:15.0/255.0f alpha:1.0];
        highlightedColor = [UIColor colorWithRed:172.0/255.0f green:130.0/255.0f blue:58.0/255.0f alpha:1.0];
    } else if(buttonStyle == BFRButtonStyleRed){
        textColor = [UIColor colorWithRed:211.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0];
        highlightedColor = [UIColor colorWithRed:255.0/255.0f green:134.0/255.0f blue:134.0/255.0f alpha:1.0];
    } else if(buttonStyle == BFRButtonStyleWhite) {
        textColor = [UIColor bfr_bodyColor];
        highlightedColor = [UIColor bfr_primaryColor];
    } else if(buttonStyle == BFRButtonStyleWhiteText) {
        textColor = [UIColor whiteColor];
        highlightedColor = [UIColor whiteColor];
    } else if(buttonStyle == BFRButtonStyleBlue) {
        textColor = [UIColor whiteColor];
        highlightedColor = [UIColor whiteColor];
    } else if(buttonStyle == BFRButtonStyleLink) {
        textColor = [UIColor bfr_primaryColor];
        highlightedColor = [UIColor bfr_primaryColor];
    } else if(buttonStyle == BFRButtonStyleDelete) {
        textColor = [UIColor bfr_errorColor];
        highlightedColor = [UIColor bfr_primaryColor];
    } else if(buttonStyle == BFRButtonStyleText) {
        textColor = [UIColor bfr_bodyColor];
        highlightedColor = [UIColor bfr_primaryColor];
    }
    
    self.titleLabel.textColor = textColor;
    self.titleLabel.highlightedTextColor = highlightedColor;
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.titleLabel.font = [UIFont bfr_semiboldFontOfSize:15.0];
    
    [self.titleLabel setText:title afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        return mutableAttributedString;
    }];
    
    self.accessibilityLabel = title;
}

- (void)setTitle:(NSString *)title withCount:(NSString *)count {
    UIColor *textColor = [UIColor blackColor];
    UIColor *highlightedColor = [UIColor greenColor];
    UIColor *countColor = [UIColor whiteColor];
    UIColor *highlightedCountColor = [UIColor whiteColor];
    
    if(buttonStyle == BFRButtonStyleGreen){
        textColor = [UIColor colorWithRed:79.0/255.0f green:149.0/255.0f blue:39.0/255.0f alpha:1.0];
        highlightedColor = [UIColor colorWithRed:127.0/255.0f green:209.0/255.0f blue:81.0/255.0f alpha:1.0];
    } else if(buttonStyle == BFRButtonStyleYellow){
        textColor = [UIColor colorWithRed:187.0/255.0f green:149.0/255.0f blue:15.0/255.0f alpha:1.0];
        highlightedColor = [UIColor colorWithRed:172.0/255.0f green:130.0/255.0f blue:58.0/255.0f alpha:1.0];
    } else if(buttonStyle == BFRButtonStyleRed){
        textColor = [UIColor colorWithRed:211.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0];
        highlightedColor = [UIColor colorWithRed:255.0/255.0f green:134.0/255.0f blue:134.0/255.0f alpha:1.0];
    } else if(buttonStyle == BFRButtonStyleWhite) {
        textColor = [UIColor bfr_primaryColor];
        highlightedColor = [UIColor bfr_primaryColor];
        
        countColor = [UIColor bfr_bodyColor];
        highlightedCountColor = [UIColor bfr_bodyColor];
        [countLabelBackground setBackgroundColor:[UIColor bfr_fillColor]];
        
    } else if(buttonStyle == BFRButtonStyleBlue) {
        textColor = [UIColor whiteColor];
        highlightedColor = [UIColor whiteColor];
    } else if(buttonStyle == BFRButtonStyleLink) {
        textColor = [UIColor bfr_primaryColor];
        highlightedColor = [UIColor bfr_primaryColor];
    } else if(buttonStyle == BFRButtonStyleDelete) {
        textColor = [UIColor bfr_errorColor];
        highlightedColor = [UIColor bfr_primaryColor];
    } else if(buttonStyle == BFRButtonStyleText) {
        textColor = [UIColor bfr_bodyColor];
        highlightedColor = [UIColor bfr_primaryColor];
    }
    
    self.titleLabel.textColor = textColor;
    self.titleLabel.highlightedTextColor = highlightedColor;
    
    self.countLabel.textColor = countColor;
    self.countLabel.highlightedTextColor = highlightedCountColor;
    
    [self.titleLabel setText:title];
    [self.countLabel setText:count];
    
    self.accessibilityLabel = title;
}

- (void)setTitle:(NSString *)title withIcon:(NSString *)icon {
    
    if(buttonIconFont == BFRButtonIconFontSSStandard){
        self.iconLabel.font = [UIFont fontWithName:@"SS Standard" size:15.0];
    } else if(buttonIconFont == BFRButtonIconFontIon){
        self.iconLabel.font = [UIFont fontWithName:@"Ionicons" size:28.0];
    } else if(buttonIconFont == BFRButtonIconFontIonLarger){
        self.iconLabel.font = [UIFont fontWithName:@"Ionicons" size:33.0];
    }
    
    UIColor *textColor = [UIColor blackColor];
    UIColor *highlightedColor = [UIColor greenColor];
    if(buttonStyle == BFRButtonStyleGreen){
        textColor = [UIColor colorWithRed:79.0/255.0f green:149.0/255.0f blue:39.0/255.0f alpha:1.0];
        highlightedColor = [UIColor colorWithRed:127.0/255.0f green:209.0/255.0f blue:81.0/255.0f alpha:1.0];
    } else if(buttonStyle == BFRButtonStyleYellow){
        textColor = [UIColor colorWithRed:187.0/255.0f green:149.0/255.0f blue:15.0/255.0f alpha:1.0];
        highlightedColor = [UIColor colorWithRed:172.0/255.0f green:130.0/255.0f blue:58.0/255.0f alpha:1.0];
    } else if(buttonStyle == BFRButtonStyleRed){
        textColor = [UIColor colorWithRed:211.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0];
        highlightedColor = [UIColor colorWithRed:255.0/255.0f green:134.0/255.0f blue:134.0/255.0f alpha:1.0];
    } else if(buttonStyle == BFRButtonStyleWhite) {
        textColor = [UIColor bfr_primaryColor];
        highlightedColor = [UIColor bfr_primaryColor];
    } else if(buttonStyle == BFRButtonStyleWhiteText) {
        textColor = [UIColor whiteColor];
        highlightedColor = [UIColor whiteColor];
    } else if(buttonStyle == BFRButtonStyleBlue) {
        textColor = [UIColor whiteColor];
        highlightedColor = [UIColor whiteColor];
    } else if(buttonStyle == BFRButtonStyleLink) {
        textColor = [UIColor bfr_primaryColor];
        highlightedColor = [UIColor bfr_primaryColor];
    } else if(buttonStyle == BFRButtonStyleDelete) {
        textColor = [UIColor bfr_errorColor];
        highlightedColor = [UIColor bfr_primaryColor];
    } else if(buttonStyle == BFRButtonStyleText) {
        textColor = [UIColor bfr_bodyColor];
        highlightedColor = [UIColor bfr_primaryColor];
    }
    
    self.titleLabel.textColor = textColor;
    self.iconLabel.textColor = textColor;
    
    self.titleLabel.highlightedTextColor = highlightedColor;
    self.iconLabel.highlightedTextColor = highlightedColor;
    
    [self.titleLabel setText:title afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        return mutableAttributedString;
    }];
    
    [self.iconLabel setText:icon afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        return mutableAttributedString;
    }];
    
    self.accessibilityLabel = title;
}


- (void)setTitle:(NSString *)title withCount:(NSString *)count withIcon:(NSString *)icon {
    if(buttonIconFont == BFRButtonIconFontSSStandard){
        self.iconLabel.font = [UIFont fontWithName:@"SS Standard" size:15.0];
    } else if(buttonIconFont == BFRButtonIconFontIon){
        self.iconLabel.font = [UIFont fontWithName:@"Ionicons" size:28.0];
    } else if(buttonIconFont == BFRButtonIconFontIonLarger){
        self.iconLabel.font = [UIFont fontWithName:@"Ionicons" size:33.0];
    }
    
    UIColor *textColor = [UIColor blackColor];
    UIColor *highlightedColor = [UIColor greenColor];
    if(buttonStyle == BFRButtonStyleGreen){
        textColor = [UIColor colorWithRed:79.0/255.0f green:149.0/255.0f blue:39.0/255.0f alpha:1.0];
        highlightedColor = [UIColor colorWithRed:127.0/255.0f green:209.0/255.0f blue:81.0/255.0f alpha:1.0];
    } else if(buttonStyle == BFRButtonStyleYellow){
        textColor = [UIColor colorWithRed:187.0/255.0f green:149.0/255.0f blue:15.0/255.0f alpha:1.0];
        highlightedColor = [UIColor colorWithRed:172.0/255.0f green:130.0/255.0f blue:58.0/255.0f alpha:1.0];
    } else if(buttonStyle == BFRButtonStyleRed){
        textColor = [UIColor colorWithRed:211.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0];
        highlightedColor = [UIColor colorWithRed:255.0/255.0f green:134.0/255.0f blue:134.0/255.0f alpha:1.0];
    } else if(buttonStyle == BFRButtonStyleWhite) {
        textColor = [UIColor bfr_primaryColor];
        highlightedColor = [UIColor bfr_primaryColor];
    } else if(buttonStyle == BFRButtonStyleBlue) {
        textColor = [UIColor whiteColor];
        highlightedColor = [UIColor whiteColor];
    } else if(buttonStyle == BFRButtonStyleLink) {
        textColor = [UIColor bfr_primaryColor];
        highlightedColor = [UIColor bfr_primaryColor];
    } else if(buttonStyle == BFRButtonStyleDelete) {
        textColor = [UIColor bfr_errorColor];
        highlightedColor = [UIColor bfr_primaryColor];
    } else if(buttonStyle == BFRButtonStyleText) {
        textColor = [UIColor bfr_bodyColor];
        highlightedColor = [UIColor bfr_primaryColor];
    }
    
    self.titleLabel.textColor = textColor;
    self.iconLabel.textColor = textColor;
    
    self.titleLabel.highlightedTextColor = highlightedColor;
    self.iconLabel.highlightedTextColor = highlightedColor;
    
    [self.countLabel setText:count afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        return mutableAttributedString;
    }];
    
    [self.titleLabel setText:title afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        return mutableAttributedString;
    }];
    
    [self.iconLabel setText:icon afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        return mutableAttributedString;
    }];
    
    NSString *countString = [NSString stringWithFormat:@" %@ ", count];
    NSString *titleString = [NSString stringWithFormat:@" %@  %@", countString, title];
    
    self.accessibilityLabel = titleString;
}

- (void)drawRect:(CGRect)rect {
    UIColor *backgroundColor = [UIColor whiteColor];
    UIColor *borderColor = [UIColor bfr_borderColor];
    
    if(buttonStyle == BFRButtonStyleGreen){
        backgroundColor = [UIColor colorFromHexString:@"#d8f1ca"];
        borderColor = [UIColor colorFromHexString:@"#7fd151"];
    } else if(buttonStyle == BFRButtonStyleYellow){
        backgroundColor = [UIColor colorFromHexString:@"#fbf1ce"];
        borderColor = [UIColor colorFromHexString:@"#efc941"];
    } else if(buttonStyle == BFRButtonStyleRed){
        backgroundColor = [UIColor colorFromHexString:@"#ffd3d3"];
        borderColor = [UIColor colorFromHexString:@"#ff8686"];
    } else if(buttonStyle == BFRButtonStyleBlue) {
        backgroundColor = [UIColor bfr_primaryColor];
        borderColor = [UIColor bfr_primaryColor];
    } else if(buttonStyle == BFRButtonStyleLink || buttonStyle == BFRButtonStyleText || buttonStyle == BFRButtonStyleDelete || buttonStyle == BFRButtonStyleWhiteText){
        borderColor = [UIColor clearColor];
        backgroundColor = [UIColor clearColor];
        return;
    }
    
    
    UIEdgeInsets backgroundInsets = UIEdgeInsetsMake(0, -2, 0, -2);
    CGRect backgroundRect = UIEdgeInsetsInsetRect(self.bounds, backgroundInsets);
    
    CGRect bounds = CGRectInset(backgroundRect, 0.5 / [UIScreen mainScreen].scale, 0.5 / [UIScreen mainScreen].scale);
    
    UIBezierPath *path;
    [path setLineWidth:1.0];
    
    path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:0.0];
    
    [backgroundColor setFill];
    [borderColor setStroke];
    
    [path fill];
    [path stroke];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(self.countLabel.text && [self.countLabel.text isKindOfClass:[NSString class]]){
        [self.countLabel sizeToFit];
        
        [self.countLabelBackground setFrame:CGRectMake(20, 12, self.countLabel.frame.size.width+15, self.bounds.size.height-25)];
        
        [self.countLabel setFrame:CGRectMake(0, 0, self.countLabelBackground.frame.size.width, self.countLabelBackground.frame.size.height)];
        
        [self.titleLabel setFrame:CGRectMake(20+self.countLabelBackground.frame.size.width+10, 5, self.bounds.size.width-40, self.bounds.size.height-12)];
    } else {
        [self.titleLabel setFrame:CGRectMake(20, 0, self.bounds.size.width-40, self.bounds.size.height)];
    }
    
    if(buttonIconFont == BFRButtonIconFontSSStandard){
        [self.iconLabel setFrame:CGRectMake(self.bounds.size.width-50, 5, 30, self.bounds.size.height-2)];
    } else {
        [self.iconLabel setFrame:CGRectMake(self.bounds.size.width-52, 0, 30, self.bounds.size.height)];
    }
}




#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

@end
