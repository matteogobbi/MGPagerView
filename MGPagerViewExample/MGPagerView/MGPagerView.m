//
//  MGPagerView.m
//  MGPagerViewExample
//
//  Created by admin on 23/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGPagerView.h"

CGFloat kMGPagerViewTitlesViewHeight = 40.0;
CGFloat kMGPagerViewTitlesMargin = 25.0;

@interface MGPagerView ()

@property (strong, nonatomic) UIScrollView *titlesScrollView;
@property (strong, nonatomic) UIScrollView *pagesScrollView;

@end

#pragma mark - MGPagerView Implementation
@implementation MGPagerView {
	NSUInteger _numberOfPage;
	NSMutableArray *_arrPageViews;
	NSMutableArray *_arrTitleButtons;
}

#pragma mark - Class and overriding methods
- (instancetype)initWithFrame:(CGRect)frame
{
	if(frame.size.height < 2*kMGPagerViewTitlesViewHeight) {
		@throw [NSException exceptionWithName:@"Height not valid"
									   reason:[NSString stringWithFormat:@"The height of the MGPagerView should be at least %1.2fpt", 2*kMGPagerViewTitlesViewHeight]
									 userInfo:nil];
	}
	
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
- (void)mg_setDefaultValue
{
	_titlesViewBackgroundColor = _pagesViewBackgroundColor = _pagesScrollView.backgroundColor = _titlesScrollView.backgroundColor = [UIColor whiteColor];
	_titlesFont = [UIFont fontWithName:@"HelveticaNeue" size:16];
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
	_arrTitleButtons = nil;
	
#warning remove view from scrollViews
}

- (void)mg_setupTitleScrollView
{
	_arrTitleButtons = [[NSMutableArray alloc] initWithCapacity:_numberOfPage];
	
	CGFloat nextPosX = 0;
	for (NSUInteger i = 0; i < _numberOfPage; ++i) {
		//Get the title
		NSString *title = [self.datasource pagerView:self titleForRowAtIndex:i];
		//Calculate the width
		CGSize titleSize = [title sizeWithAttributes:@{
													   NSFontAttributeName : _titlesFont
													   }];
		//Add a new Button in the scrollView
		UIButton *buttonTitle = [[UIButton alloc] initWithFrame:CGRectMake(nextPosX, 0, titleSize.width + kMGPagerViewTitlesMargin, _titlesScrollView.frame.size.height)];
		[buttonTitle setTitle:title forState:UIControlStateNormal];
		[buttonTitle setTitleColor:_selectedTitleColor forState:UIControlStateSelected];
		[buttonTitle setTitleColor:_titlesColor forState:UIControlStateNormal];
		buttonTitle.selected = (i == 0);
		
		[_titlesScrollView addSubview:buttonTitle];
		//Add it in the array
		[_arrTitleButtons addObject:buttonTitle];
		
		//Calculate next position
		nextPosX += (i == _numberOfPage-1) ? 0 : buttonTitle.frame.size.width;
	}
	
	//Add the rest of the screen to make the scrollView scrollable until the last title
	CGFloat contentSizeWidth = nextPosX + _titlesScrollView.frame.size.width;
	
	_titlesScrollView.contentSize = CGSizeMake(contentSizeWidth, _titlesScrollView.frame.size.height);
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
