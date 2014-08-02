//
//  IViewController.m
//  autoLayout
//
//  Created by kgaddy on 5/5/14.
//  Copyright (c) 2014 com.ehi. All rights reserved.
//

#import "IViewController.h"
#import "IScrollViewController.h"
#import "ISideBySideViewController.h"
#import "ITableViewDynamicHeightViewController.h"

@interface IViewController ()
@property (strong, nonatomic) UIButton *scrollExampleButton, *sideBySideButton, *dynmaicCellHeight;
@property (strong, nonatomic) NSMutableDictionary *views, *metrics;

@end

@implementation IViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view addSubview:self.scrollExampleButton];
	[self.view addSubview:self.sideBySideButton];
	[self.view addSubview:self.dynmaicCellHeight];
	self.view.backgroundColor = [UIColor offWhite];
	[self addConstraints];
}

- (UIButton *)dynmaicCellHeight {
	if (!_dynmaicCellHeight) {
		_dynmaicCellHeight = [[UIButton alloc]init];
		_dynmaicCellHeight.backgroundColor = [UIColor hitched];
		[_dynmaicCellHeight setTitle:@"Dynamic Cell Table View" forState:UIControlStateNormal];
		[_dynmaicCellHeight addTarget:self action:@selector(openDynamicView:) forControlEvents:UIControlEventTouchUpInside];
		[_dynmaicCellHeight setTranslatesAutoresizingMaskIntoConstraints:NO];
	}
	return _dynmaicCellHeight;
}

- (UIButton *)scrollExampleButton {
	if (!_scrollExampleButton) {
		_scrollExampleButton = [[UIButton alloc]init];
		_scrollExampleButton.backgroundColor = [UIColor hitched];
		[_scrollExampleButton setTitle:@"Scroll View" forState:UIControlStateNormal];
		[_scrollExampleButton addTarget:self action:@selector(openScrollView:) forControlEvents:UIControlEventTouchUpInside];
		[_scrollExampleButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	}
	return _scrollExampleButton;
}

- (UIButton *)sideBySideButton {
	if (!_sideBySideButton) {
		_sideBySideButton = [[UIButton alloc]init];
		_sideBySideButton.backgroundColor = [UIColor hitched];
		[_sideBySideButton setTitle:@"Side By Side View" forState:UIControlStateNormal];
		[_sideBySideButton addTarget:self action:@selector(openSideBySide:) forControlEvents:UIControlEventTouchUpInside];
		[_sideBySideButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	}
	return _sideBySideButton;
}

- (void)openDynamicView:(id)sender {
	ITableViewDynamicHeightViewController *vc = [[ITableViewDynamicHeightViewController alloc] init];
	[self.navigationController pushViewController:vc animated:NO];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openScrollView:(id)sender {
	IScrollViewController *foundVC = [[IScrollViewController alloc] init];
	[self.navigationController pushViewController:foundVC animated:NO];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openSideBySide:(id)sender {
	ISideBySideViewController *foundVC = [[ISideBySideViewController alloc] init];
	[self.navigationController pushViewController:foundVC animated:NO];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (NSMutableDictionary *)metrics {
	if (!_metrics) {
		_metrics = [[NSMutableDictionary alloc]init];

		if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
			[_metrics setObject:@74 forKey:@"topMargin"];
		}
		else {
			[_metrics setObject:@64 forKey:@"topMargin"];
		}

		[_metrics setObject:@14 forKey:@"blockHeight"];
		[_metrics setObject:@6 forKey:@"blockSpacing"];
	}

	return _metrics;
}

- (NSMutableDictionary *)views {
	if (!_views) {
		_views = [[NSMutableDictionary alloc]init];
		[_views setObject:self.scrollExampleButton forKey:@"scrollExampleButton"];
		[_views setObject:self.sideBySideButton forKey:@"sideBySideButton"];
		[_views setObject:self.dynmaicCellHeight forKey:@"dynmaicCellHeight"];
	}

	return _views;
}

- (void)addConstraints {
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollExampleButton]|" options:0 metrics:self.metrics views:self.views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[sideBySideButton]|" options:0 metrics:self.metrics views:self.views]];

	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[dynmaicCellHeight]|" options:0 metrics:self.metrics views:self.views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topMargin-[scrollExampleButton(46)]-[sideBySideButton(46)]-[dynmaicCellHeight(46)]" options:0 metrics:self.metrics views:self.views]];
}

@end
