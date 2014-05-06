//
//  ISideBySideViewController.m
//  autoLayout
//
//  Created by kgaddy on 5/6/14.
//  Copyright (c) 2014 com.ehi. All rights reserved.
//

#import "ISideBySideViewController.h"
#import "ITestView.h"

@interface ISideBySideViewController ()
@property (strong, nonatomic) ITestView *a, *b, *c, *d,*e,*f;
@property (strong, nonatomic) NSMutableArray *letterConstraints, *letterViews;
@property (strong, nonatomic) UIView *container;
@property (strong, nonatomic) NSMutableDictionary *views, *metrics;

@end

@implementation ISideBySideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor offWhite];
    }
    return self;
}

-(NSMutableArray *)letterViews{
    if(!_letterViews){
        _letterViews = [[NSMutableArray alloc]init];
        [_letterViews addObject:self.a];
        [_letterViews addObject:self.b];
        [_letterViews addObject:self.c];
        [_letterViews addObject:self.d];
        [_letterViews addObject:self.e];
        [_letterViews addObject:self.f];
    }
    return _letterViews;
}

-(NSMutableArray *)letterConstraints{
    if(!_letterConstraints){
        _letterConstraints = [[NSMutableArray alloc]init];
    }
    return _letterConstraints;
}

-(UIView *)container {
    if (!_container) {
        _container = [[UIView alloc]init];
        _container.backgroundColor = [UIColor liptonYellow];
        [_container setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_container addSubview:self.a];
        [_container addSubview:self.b];
        [_container addSubview:self.c];
        [_container addSubview:self.d];
        [_container addSubview:self.e];
        [_container addSubview:self.f];
        
    }
    return _container;
}

-(ITestView *)a {
    if (!_a) {
        _a = [[ITestView alloc]initWithTitle:@"A"];
        _a.backgroundColor = [UIColor hitched];
        
        NSLayoutConstraint *wConstraint = [NSLayoutConstraint constraintWithItem:_a
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:_a
                                                                            attribute:NSLayoutAttributeHeight
                                                                           multiplier:1
                                                                             constant:20];

        //[self.view addConstraint:wConstraint];
       // [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[self.a(60)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.a)]];

        
        [_a setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _a;
}

-(ITestView *)b {
    if (!_b) {
        _b = [[ITestView alloc]initWithTitle:@"B"];
        _b.backgroundColor = [UIColor hLightGreen];
        
        [_b setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _b;
}

-(ITestView *)c {
    if (!_c) {
        _c = [[ITestView alloc]initWithTitle:@"C"];
        _c.backgroundColor = [UIColor hitched];
        
        [_c setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _c;
}

-(ITestView *)d {
    if (!_d) {
        _d = [[ITestView alloc]initWithTitle:@"D"];
        _d.backgroundColor = [UIColor hitched];
        
        [_d setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _d;
}

-(ITestView *)e {
    if (!_e) {
        _e = [[ITestView alloc]initWithTitle:@"E"];
        _e.backgroundColor = [UIColor hitched];
        
        [_e setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _e;
}

-(ITestView *)f {
    if (!_f) {
        _f = [[ITestView alloc]initWithTitle:@"F"];
        _f.backgroundColor = [UIColor hitched];
        
        [_f setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _f;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.container];

    [self addConstraints];
}


- (NSMutableDictionary *)views {
    if (!_views) {
        _views = [[NSMutableDictionary alloc]init];
        [_views setObject:self.container forKey:@"container"];

        [_views setObject:self.a forKey:@"a"];
        [_views setObject:self.b forKey:@"b"];
        [_views setObject:self.c forKey:@"c"];
        [_views setObject:self.d forKey:@"d"];
        [_views setObject:self.e forKey:@"e"];
        [_views setObject:self.e forKey:@"f"];
        
    }
    
    return _views;
}

-(void)addConstraints{

    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[container(310)]-5-|" options:0 metrics:nil views:self.views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[container(60)]" options:0 metrics:nil views:self.views]];
    
    //pin the first view to the left edge
    [self.letterConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[a]" options:0 metrics:nil views:self.views]];
    //pin the last view to the right edge with padding of at least 20 and a priority of 450
    [self.letterConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[f]-(>=10@450)-|" options:0 metrics:nil views:self.views]];
    
    //constraint that says the letter is the same height to the container
    NSLayoutConstraint *letterHeight = [NSLayoutConstraint constraintWithItem:self.container
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.a
                                                                             attribute:NSLayoutAttributeHeight
                                                                            multiplier:1
                                                                              constant:0];
    
    [self.letterConstraints addObject:letterHeight];
    
    
    UIView *previousView = nil;
    //add the constraints to each letter view;
    for(ITestView *lview in self.letterViews){
        
        //center the letter vertically in the conatiner
        NSLayoutConstraint *centerConstraint = [NSLayoutConstraint constraintWithItem:self.container
                                                                            attribute:NSLayoutAttributeCenterY
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:lview
                                                                            attribute:NSLayoutAttributeCenterY
                                                                           multiplier:1
                                                                             constant:0];
        
        [self.letterConstraints addObject:centerConstraint];
        
        
        if(previousView) {
            NSDictionary *tempViews = NSDictionaryOfVariableBindings(previousView,lview);
            //space out the views and make the equal widths
            [self.letterConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousView]-(10)-[lview]" options:0 metrics:nil views:tempViews]];
            
            [self.letterConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousView(==lview)]" options:0 metrics:nil views:tempViews]];
            
            
        }
        previousView = lview;
    }
    
    [self.view addConstraints:self.letterConstraints];

}

@end
