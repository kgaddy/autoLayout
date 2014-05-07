//
//  ITestView.m
//  autoLayout
//
//  Created by kgaddy on 5/5/14.
//  Copyright (c) 2014 com.ehi. All rights reserved.
//

#import "ITestView.h"

@interface ITestView ()
@property (strong, nonatomic) UILabel *myViewTitleLabel;
@property (strong, nonatomic) NSString *viewTitle;
@property (strong, nonatomic) NSMutableDictionary *views, *metrics;
@end

@implementation ITestView

- (id)initWithTitleAndColor:(NSString *)title color:(UIColor *)color
{
    self = [super init];
    if (self) {
        self.viewTitle = title;
        [self addSubview:self.myViewTitleLabel];
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 3.0f;
        [self addConstraints];
        [self setBackgroundColor:color];
    }
    return self;
}

- (UILabel *)myViewTitleLabel {
    if (!_myViewTitleLabel) {
        _myViewTitleLabel = [[UILabel alloc]init];
        _myViewTitleLabel.numberOfLines = 0;
        _myViewTitleLabel.textColor = [UIColor blackColor];
       // _myViewTitleLabel.backgroundColor = [UIColor clearColor];
        [_myViewTitleLabel setFont:[UIFont systemFontOfSize:12.0]];
        _myViewTitleLabel.text = self.viewTitle;
        [_myViewTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    return _myViewTitleLabel;
}

- (NSMutableDictionary *)metrics {
    if (!_metrics) {
        _metrics = [[NSMutableDictionary alloc]init];
    }
    
    return _metrics;
}

- (NSMutableDictionary *)views {
    if (!_views) {
        _views = [[NSMutableDictionary alloc]init];
        [_views setObject:self.myViewTitleLabel forKey:@"myViewTitleLabel"];
    }
    return _views;
}

- (void)addConstraints {


    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.myViewTitleLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.myViewTitleLabel.superview
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.myViewTitleLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.myViewTitleLabel.superview
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];
    
}

@end
