//
//  ITableViewDynamicHeightViewController.m
//  autoLayout
//
//  Created by kgaddy on 8/2/14.
//  Copyright (c) 2014 com.ehi. All rights reserved.
//

#import "ITableViewDynamicHeightViewController.h"
#import "IDynamicHeightCellView.h"

@interface ITableViewDynamicHeightViewController ()
@property (strong, nonatomic) NSMutableDictionary *metrics, *views;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *stringArray;
@property (assign, nonatomic) CGFloat *cellTextWidth;
@end

#define FONT_SIZE 14.0f
#define CELL_CONTENT_MARGIN 40.0f

@implementation ITableViewDynamicHeightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	}
	return self;
}

- (NSArray *)stringArray {
	if (!_stringArray) {
		_stringArray = [[NSArray alloc] initWithObjects:@"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.-END", @"Sed ut perspiciatis unde omnis iste natus.-END", @"Pound-END", @"On a sunny May afternoon, Richt sat in a black leather chair in a lounge adjacent to his office, which overlooks Georgia’s indoor and outdoor practice facilities. He is familiar with his varying reputations. That’s the nature of a coach who, entering his 14th season in his current role, has experienced more ups and downs at a single school than many coaches do over the course of their careers. For better or worse, the methodology behind his approach has remained constant.-END", @"If the SEC is a hurricane, Richt has been resting calmly in the eye of the storm for longer than a decade.", nil];
	}
	return _stringArray;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc]init];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.backgroundColor = [UIColor whiteColor];
		[_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
	}
	return _tableView;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	self.view.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.tableView];
	[self addConstraints];
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
		[_views setObject:self.tableView forKey:@"tableView"];
	}

	return _views;
}

- (void)addConstraints {
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tableView]|" options:0 metrics:nil views:self.views]];

	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:self.metrics views:self.views]];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return 1;
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	// Return YES if you want the specified item to be editable.
	return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"cell";

	IDynamicHeightCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (cell == nil) {
		CGRect screenRect = [[UIScreen mainScreen] bounds];
		CGFloat screenWidth = screenRect.size.width - 40;
		cell = [[IDynamicHeightCellView alloc]initWithTextAndWidth:[self.stringArray objectAtIndex:[indexPath row]] width:screenWidth];
	}

	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.stringArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	NSString *text = [self.stringArray objectAtIndex:[indexPath row]];

	NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:FONT_SIZE] };
	CGRect screenRect = [[UIScreen mainScreen] bounds];
	CGFloat screenWidth = screenRect.size.width - 40;
	CGRect rect = [text boundingRectWithSize:CGSizeMake(screenWidth, CGFLOAT_MAX)
	                                 options:NSStringDrawingUsesLineFragmentOrigin
	                              attributes:attributes
	                                 context:nil];

	CGSize size = rect.size;
	CGFloat height = MAX(size.height, 20.0f);

	height += (CELL_CONTENT_MARGIN);

	return height;
}


@end
