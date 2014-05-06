//
//  IViewController.m
//  autoLayout
//
//  Created by kgaddy on 5/5/14.
//  Copyright (c) 2014 com.ehi. All rights reserved.
//

#import "IViewController.h"
#import "IScrollViewController.h"

@interface IViewController ()
@property (strong,nonatomic) UIButton *scrollExampleButton;
@property (strong, nonatomic) NSMutableDictionary *views, *metrics;

@end

@implementation IViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.scrollExampleButton];
    self.view.backgroundColor = [UIColor offWhite];
    [self addConstraints];
}

-(UIButton *)scrollExampleButton{
    if(!_scrollExampleButton){
        _scrollExampleButton = [[UIButton alloc]init];
        _scrollExampleButton.backgroundColor = [UIColor hitched];
        [_scrollExampleButton setTitle:@"Scroll View" forState:UIControlStateNormal];
        [_scrollExampleButton addTarget:self action:@selector(openScrollView:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollExampleButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _scrollExampleButton;
}

- (void)openScrollView:(id)sender {
    
    IScrollViewController *foundVC = [[IScrollViewController alloc] init];
    [self.navigationController pushViewController:foundVC animated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (NSMutableDictionary *)metrics {
    if (!_metrics) {
        _metrics = [[NSMutableDictionary alloc]init];
        
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [_metrics setObject:@74 forKey:@"topMargin"];
        } else {
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

    }
    
    return _views;
}
- (void)addConstraints {
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollExampleButton]|" options:0 metrics:self.metrics views:self.views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topMargin-[scrollExampleButton(46)]" options:0 metrics:self.metrics views:self.views]];
}

@end
