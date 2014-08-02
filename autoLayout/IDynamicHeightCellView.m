//
//  IDynamicHeightCellView.m
//  autoLayout
//
//  Created by kgaddy on 8/2/14.
//  Copyright (c) 2014 com.ehi. All rights reserved.
//

#import "IDynamicHeightCellView.h"
@interface IDynamicHeightCellView ()
@property (strong, nonatomic) NSMutableDictionary *views, *metrics;
@property (strong, nonatomic) UILabel *textDescrLabel;
@property (assign, nonatomic) CGFloat cellWidth;
@property (strong, nonatomic) NSString *text;
@end
@implementation IDynamicHeightCellView

#define FONT_SIZE 14.0f

- (id)initWithTextAndWidth:(NSString *)text width:(CGFloat)width {
	self = [super init];
	if (self) {
		_cellWidth = width;
		_text = text;
		self.backgroundColor = [UIColor whiteColor];
		[self addSubview:self.textDescrLabel];
		[self addConstraints];
	}
	return self;
}

- (UILabel *)textDescrLabel {
	if (!_textDescrLabel) {
		_textDescrLabel = [[UILabel alloc]init];
		_textDescrLabel.text = self.text;
		_textDescrLabel.backgroundColor = [UIColor clearColor];
		_textDescrLabel.textColor = [UIColor grayColor];
		_textDescrLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
		_textDescrLabel.numberOfLines = 0;
		_textDescrLabel.preferredMaxLayoutWidth = self.cellWidth;
		[_textDescrLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
	}
	return _textDescrLabel;
}

- (NSMutableDictionary *)views {
	if (!_views) {
		_views = [[NSMutableDictionary alloc]init];
		[_views setObject:self.textDescrLabel forKey:@"textDescrLabel"];
	}
	return _views;
}

- (NSMutableDictionary *)metrics {
	if (!_metrics) {
		_metrics = [[NSMutableDictionary alloc]init];
		[_metrics setObject:@(self.cellWidth) forKey:@"cellWidth"];
	}
	return _metrics;
}

- (void)addConstraints {
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[textDescrLabel]" options:0 metrics:self.metrics views:self.views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textDescrLabel(cellWidth)]" options:0 metrics:self.metrics views:self.views]];
}

@end
