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
@property (strong, nonatomic) NSMutableArray *letterConstraints, *letterViews;
@property (strong, nonatomic) UIView *container;
@property (strong, nonatomic) NSMutableDictionary *views, *metrics;
@property (strong, nonatomic) UITextField *numTextField;
@property (strong, nonatomic) UIButton *numButton;
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

-(UITextField *)numTextField{
    if(!_numTextField){
        _numTextField = [[UITextField alloc]init];
        _numTextField.borderStyle = UITextBorderStyleLine;
        _numTextField.backgroundColor = [UIColor offWhite];
        [_numTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return  _numTextField;
}

-(UIButton *)numButton{
    if(!_numButton){
        _numButton = [[UIButton alloc]init];
        _numButton.backgroundColor = [UIColor hitched];
        [_numButton setTitle:@"Update" forState:UIControlStateNormal];
        [_numButton addTarget:self action:@selector(numButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_numButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _numButton;
}

- (void)numButtonAction:(id)sender {
    //first remove all views from container
    for (UIView *view in self.container.subviews)
    {
        [view removeFromSuperview];
    }
    
    [self.letterViews removeAllObjects];
    int count = [self.numTextField.text intValue];

    for (int i = 1; i <= count; i++)
    {
        ITestView *tView = [[ITestView alloc]initWithTitleAndColor:[NSString stringWithFormat:@"%d", i] color:[UIColor hitched]];
        //UIView *tView = [[UIView alloc]init];
        [tView setTranslatesAutoresizingMaskIntoConstraints:NO];
        //[tView setBackgroundColor:[UIColor redColor]];
        //[tView setAlpha:0.3];
        //tView.backgroundColor = [UIColor greenColor];
        [tView setTag:i];
        [self.letterViews addObject:tView];
        [self.container addSubview:tView];
    }
    
    [self addLetterConstraints];
}

-(NSMutableArray *)letterViews{
    if(!_letterViews){
        _letterViews = [[NSMutableArray alloc]init];
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
        
    }
    return _container;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.numButton];
    [self.view addSubview:self.numTextField];
    [self.view addSubview:self.container];

    [self addConstraints];
}


- (NSMutableDictionary *)views {
    if (!_views) {
        _views = [[NSMutableDictionary alloc]init];
        [_views setObject:self.container forKey:@"container"];
        [_views setObject:self.numTextField forKey:@"numTextField"];
        [_views setObject:self.numButton forKey:@"numButton"];
        
    }
    
    return _views;
}
-(void)addLetterConstraints{
    [self.view removeConstraints:self.letterConstraints];
    [self.letterConstraints removeAllObjects];
    
    if(self.letterViews.count>0){
        UIView *firstView = [self.letterViews firstObject];
        UIView *lastView = [self.letterViews lastObject];

        id firstLastViews = @{@"firstView": firstView,@"lastView": lastView};
        
        //pin the first view to the left edge
        [self.letterConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=10@450)-[firstView]" options:0 metrics:nil views:firstLastViews]];
        //pin the last view to the right edge with padding of at least 20 and a priority of 450
        [self.letterConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastView]-(>=10@450)-|" options:0 metrics:nil views:firstLastViews]];
        
        //constraint that says the letter is the same height to the container
        NSLayoutConstraint *letterHeight = [NSLayoutConstraint constraintWithItem:self.container
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:firstView
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
            
            //Make the view height the same size as the container
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.container
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:lview
                                                                                attribute:NSLayoutAttributeHeight
                                                                               multiplier:1
                                                                                 constant:0];
            
            [self.letterConstraints addObject:heightConstraint];
            [self.letterConstraints addObject:centerConstraint];
            
            
            
            if(previousView) {
                NSDictionary *tempViews = NSDictionaryOfVariableBindings(previousView,lview);
                
                //space out the views and make the equal widths
                [self.letterConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousView]-10-[lview]" options:0 metrics:nil views:tempViews]];
                
                [self.letterConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousView(==lview)]" options:0 metrics:nil views:tempViews]];
                
                
            }
            previousView = lview;
        }
        
        [self.view addConstraints:self.letterConstraints];
    }
}
-(void)addConstraints{
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[container(310)]-5-|" options:0 metrics:nil views:self.views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[numTextField]-|" options:0 metrics:nil views:self.views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[numButton]-|" options:0 metrics:nil views:self.views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[container(60)]-[numTextField(40)]-[numButton(46)]" options:0 metrics:nil views:self.views]];
}

@end
