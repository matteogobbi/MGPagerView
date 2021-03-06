//
//  MGPagerView.m
//  MGPagerViewExample
//
//  Created by admin on 23/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGPagerView.h"

CGFloat kMGPagerViewTitlesViewHeight = 50.0;

static const CGFloat kMGPagerViewTitlesMargin = 8.0;

@interface MGPagerView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *titlesScrollView;
@property (strong, nonatomic) UIScrollView *pagesScrollView;

@end

#pragma mark - MGPagerView Implementation
@implementation MGPagerView {
	NSUInteger _numberOfPage;
	NSMutableArray *_arrPageViews;
	NSMutableArray *_arrTitleLabels;
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
    _titlesScrollView.showsHorizontalScrollIndicator = NO;
    _titlesScrollView.delegate = self;
    
    _pagesScrollView.showsHorizontalScrollIndicator = NO;
    _pagesScrollView.pagingEnabled = YES;
    _pagesScrollView.delegate = self;
    
	_titlesViewBackgroundColor = _pagesViewBackgroundColor = _pagesScrollView.backgroundColor = _titlesScrollView.backgroundColor = [UIColor whiteColor];
	_titlesFont = [UIFont fontWithName:@"BanglaSangamMN" size:35];
	_titlesColor = [UIColor colorWithRed:0 green:.6 blue:1.0 alpha:.4];
	_selectedTitleColor = [UIColor colorWithRed:0 green:.6 blue:1.0 alpha:1.0];
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
	_arrTitleLabels = nil;
	
#warning remove view from scrollViews
}

- (void)mg_setupTitleScrollView
{
	_arrTitleLabels = [[NSMutableArray alloc] initWithCapacity:_numberOfPage];
	
	CGFloat nextPosX = 0;
	for (NSUInteger i = 0; i < _numberOfPage; ++i) {
		//Get the title
		NSString *title = [@" " stringByAppendingString:[self.datasource pagerView:self titleForRowAtIndex:i]];
		//Calculate the width
		CGSize titleSize = [title sizeWithAttributes:@{
													   NSFontAttributeName : _titlesFont
													   }];
		//Add a new label in the scrollView
		UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(nextPosX, 0, titleSize.width + kMGPagerViewTitlesMargin, _titlesScrollView.frame.size.height)];
		labelTitle.text = title;
		labelTitle.textColor = (i == 0) ? _selectedTitleColor : _titlesColor;
        labelTitle.font = _titlesFont;
        
		[_titlesScrollView addSubview:labelTitle];
        
		//Add it in the array
		[_arrTitleLabels addObject:labelTitle];
		
		//Calculate next position
		nextPosX += (i == _numberOfPage-1) ? 0 : labelTitle.frame.size.width;
	}
	
	//Add the rest of the screen to make the scrollView scrollable until the last title
	CGFloat contentSizeWidth = nextPosX + _titlesScrollView.frame.size.width;
	
	_titlesScrollView.contentSize = CGSizeMake(contentSizeWidth, _titlesScrollView.frame.size.height);
}

- (void)mg_setupPagesScrollView
{
    _arrPageViews = [[NSMutableArray alloc] initWithCapacity:_numberOfPage];
	
	for (NSUInteger i = 0; i < _numberOfPage; ++i) {
		//Get the view
        UIView *view = [self.datasource pagerView:self viewForPageAtIndex:i];
        
        view.frame = CGRectMake(i*_pagesScrollView.frame.size.width, 0, _pagesScrollView.frame.size.width, _pagesScrollView.frame.size.height);
		[_pagesScrollView addSubview:view];
        
		//Add it in the array
		[_arrPageViews addObject:view];
	}
	
	_pagesScrollView.contentSize = CGSizeMake(_numberOfPage*_pagesScrollView.frame.size.width, _pagesScrollView.frame.size.height);
}

#pragma mark - Public methods
- (void)reloadData
{
	[self mg_resetData];
	[self mg_loadData];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //CGFloat contentOffsetX = scrollView.contentOffset.x;
    
    //Calculate the index
    NSUInteger index = _pagesScrollView.contentOffset.x/_pagesScrollView.frame.size.width;
    
    //Get the label of the title
    UILabel *labelTitle = _arrTitleLabels[index];
    //Get the width of the label
    CGFloat titleWidth = labelTitle.frame.size.width;
    
    //Get the view of the page
    UIView *pageView = _arrPageViews[index];

    //Calculate the scale
    CGFloat scale = _pagesScrollView.frame.size.width/titleWidth;
    
    //Calculate the relative offset
    CGFloat relativeOffetX;
    if(scrollView == _pagesScrollView) {
        relativeOffetX = scrollView.contentOffset.x - pageView.frame.origin.x;

        //Set async scroll titles scroll view
        _titlesScrollView.contentOffset = CGPointMake(labelTitle.frame.origin.x + relativeOffetX/scale, 0);
    } else {
        
#warning To review and adjust
        
        relativeOffetX = scrollView.contentOffset.x - labelTitle.frame.origin.x;
        
        //Get the actual offset of the pagesView
        CGFloat pagesOffsetX = _pagesScrollView.contentOffset.x - pageView.frame.origin.x;
        //Calcualate the corrispettive for the titlesView
        CGFloat titlesOffestX = pagesOffsetX/scale; //This is the scaled offset until now, before consider the new scroll
        
        //Get just the new part of the relative offset for the titlesView
        CGFloat partialOffsetX = relativeOffetX - titlesOffestX; //This is the new scroll part not scaled
        
        //Set the offset for the pagesView
        _pagesScrollView.contentOffset = CGPointMake(_pagesScrollView.contentOffset.x + partialOffsetX, 0);
        
        //Set async scroll titles scroll view
        _titlesScrollView.contentOffset = CGPointMake(labelTitle.frame.origin.x + titlesOffestX + partialOffsetX/scale, 0);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView != _titlesScrollView)
        return;
    
    //Paging
    
    //Calculate the index
    CGFloat pagesFactor = _pagesScrollView.contentOffset.x/_pagesScrollView.frame.size.width;
    NSUInteger index = pagesFactor;
    
    CGFloat newOffsetX = _pagesScrollView.frame.size.width * ((index+1 - pagesFactor >= .5) ? index : index+1);
    
    [UIView animateWithDuration:.3 animations:^{
        _pagesScrollView.contentOffset = CGPointMake(newOffsetX, 0);
    }];
}


@end
