//
//  MGPagerView.m
//  MGPagerViewExample
//
//  Created by admin on 23/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGPagerView.h"

CGFloat kMGPagerViewTitlesViewHeight = 40.0;
CGFloat kMGPagerViewTitlesMargin = 15.0;

@interface MGPagerView ()

@property (strong, nonatomic) UIScrollView *titlesScrollView;
@property (strong, nonatomic) UIScrollView *pagesScrollView;

@end

@implementation MGPagerView {
	NSUInteger _numberOfPage;
	NSMutableArray *_arrPageViews;
	NSMutableArray *_arrTitles;
}

#pragma mark - Class and overriding methods
- (instancetype)initWithFrame:(CGRect)frame
{
	NSAssert(frame.size.height >= 2*kMGPagerViewTitlesViewHeight, @"The height of the MGPagerView should be at least %1.2fpt", 2*kMGPagerViewTitlesViewHeight);
	
    self = [super initWithFrame:frame];
    if (self) {
		
		//Exposed for the customer
		_titlesViewHeight = kMGPagerViewTitlesViewHeight;
		
		//Init frames
        _titlesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(frame.origin.x,
																		   frame.origin.y,
																		   frame.size.width,
																		   kMGPagerViewTitlesViewHeight)];
		
		_pagesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(_titlesScrollView.frame.origin.x,
																		  _titlesScrollView.frame.origin.y + _titlesScrollView.frame.size.height,
																		  _titlesScrollView.frame.size.width,
																		  frame.size.height-_titlesScrollView.frame.size.height)];
		
		
		[self addSubview:_titlesScrollView];
		[self addSubview:_pagesScrollView];
		
		[self mg_setDefaultValue];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self mg_loadData];
}


#pragma mark - Private methods
- (void)mg_setDefaultValue {
	_titlesViewBackgroundColor = _pagesViewBackgroundColor = _pagesScrollView.backgroundColor = _titlesScrollView.backgroundColor = [UIColor whiteColor];
	_titlesFont = [UIFont fontWithName:@"Verdana" size:16.0];
	_titlesColor = [UIColor colorWithRed:0 green:.3 blue:1.0 alpha:.6];
	_selectedTitleColor = [UIColor colorWithRed:0 green:.3 blue:1.0 alpha:1.0];
	_selectedPageIndex = 0;
}

- (void)mg_loadData
{
	_numberOfPage = [self.datasource numberOfPageInPagerView:self];
	
	[self mg_setupTitleScrollView];
	[self mg_setupPagesScrollView];
}

- (void)mg_resetData
{
	_selectedPageIndex = 0;
	_numberOfPage = 0;
	_arrPageViews = nil;
	_arrTitles = nil;
	
#warning remove view from scrollViews
}

- (void)mg_setupTitleScrollView
{
	_arrTitles = [[NSMutableArray alloc] initWithCapacity:_numberOfPage];
	
	for (NSUInteger i = 0; i < _numberOfPage; ++i) {
		NSString *title = [self.datasource pagerView:self titleForRowAtIndex:i];
	}
}

- (void)mg_setupPagesScrollView
{
	
}

#pragma mark - Public methods
- (void)reloadData
{
	[self mg_resetData];
	[self mg_loadData];
}

@end
