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
        [_scrollView setContentSize:CGSizeMake(300, 900)];
        [_scrollView addSubview:self.contentView];
        [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _scrollView;
}

-(UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        [_contentView addSubview:self.testBlockOne];
        [_contentView addSubview:self.testBlockTwo];
        [_contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _contentView;
}

-(ITestView *)testBlockOne {
    if (!_testBlockOne) {
        _testBlockOne = [[ITestView alloc]initWithTitle:@"BLock One"];
        _testBlockOne.backgroundColor = [UIColor hitched];
   
        [_testBlockOne setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _testBlockOne;
}

-(ITestView *)testBlockTwo {
    if (!_testBlockTwo) {
        _testBlockTwo = [[ITestView alloc]initWithTitle:@"BLock Two"];
        _testBlockTwo.backgroundColor = [UIColor liptonYellow];
        
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
        
        //This is the height of testBlockOne and testBlockTwo views
        [_metrics setObject:@900 forKey:@"contentHeight"];
        
    }
    
    return _metrics;
}

- (NSMutableDictionary *)views {
    if (!_views) {
        _views = [[NSMutableDictionary alloc]init];
        [_views setObject:self.testBlockOne forKey:@"testBlockOne"];
        [_views setObject:self.testBlockTwo forKey:@"testBlockTwo"];
        [_views setObject:self.scrollView forKey:@"scrollView"];
        [_views setObject:self.contentView forKey:@"contentView"];
        
    }
    
    return _views;
}

- (void)addConstraints {
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:self.metrics views:self.views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:self.metrics views:self.views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView(320)]|" options:0 metrics:nil views:self.views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView(contentHeight)]|" options:0 metrics:self.metrics views:self.views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[testBlockOne(320)]|" options:0 metrics:nil views:self.views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[testBlockTwo(320)]|" options:0 metrics:nil views:self.views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[testBlockOne(200)][testBlockTwo(700)]" options:0 metrics:nil views:self.views]];
}

@end
