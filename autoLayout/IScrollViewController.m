//
//  IScrollViewController.m
//  autoLayout
//
//  Created by kgaddy on 5/5/14.
//  Copyright (c) 2014 com.ehi. All rights reserved.
//

#import "IScrollViewController.h"
#import "ITestView.h"

@interface IScrollViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIView *contentView;
@property (strong,nonatomic) ITestView *testBlockOne, *testBlockTwo;
@property (strong, nonatomic) NSMutableDictionary *views, *metrics;
@end

@implementation IScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    
    [self addConstraints];
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [_scrollView addSubview:self.testBlockOne];
        [_scrollView addSubview:self.testBlockTwo];
        [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _scrollView;
}

-(ITestView *)testBlockOne {
    if (!_testBlockOne) {
        _testBlockOne = [[ITestView alloc]initWithTitleAndColor:@"One" color:[UIColor hitched]];
       
        [_testBlockOne setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _testBlockOne;
}

-(ITestView *)testBlockTwo {
    if (!_testBlockTwo) {
        _testBlockTwo = [[ITestView alloc]initWithTitleAndColor:@"One" color:[UIColor redColor]];
   
        
        [_testBlockTwo setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _testBlockTwo;
}

- (NSMutableDictionary *)metrics {
    if (!_metrics) {
        _metrics = [[NSMutableDictionary alloc]init];
        
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            [_metrics setObject:@64 forKey:@"topMargin"];
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
        [_views setObject:self.testBlockOne forKey:@"testBlockOne"];
        [_views setObject:self.testBlockTwo forKey:@"testBlockTwo"];
        [_views setObject:self.scrollView forKey:@"scrollView"];
        
    }
    
    return _views;
}

- (void)addConstraints {
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:self.metrics views:self.views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:self.metrics views:self.views]];
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[testBlockOne(320)]|" options:0 metrics:nil views:self.views]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[testBlockTwo(320)]|" options:0 metrics:nil views:self.views]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[testBlockOne(200)][testBlockTwo(700)]|" options:0 metrics:nil views:self.views]];
}

@end
