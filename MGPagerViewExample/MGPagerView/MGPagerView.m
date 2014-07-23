//
//  MGPagerView.m
//  MGPagerViewExample
//
//  Created by admin on 23/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGPagerView.h"

CGFloat kMGPagerViewTitlesViewHeight = 40.0;

@interface MGPagerView ()

@property (strong, nonatomic) UIScrollView *titlesScrollView;
@property (strong, nonatomic) UIScrollView *pagesScrollView;

@end

@implementation MGPagerView

#pragma mark - Class and overriding methods
- (instancetype)initWithFrame:(CGRect)frame
{
	NSAssert(frame.size.height >= 2*kMGPagerViewTitlesViewHeight, @"The height of the MGPagerView should be at least %1.2fpt", 2*kMGPagerViewTitlesViewHeight);
	
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
		
		_titlesViewBackgroundColor = _pagesViewBackgroundColor = _pagesScrollView.backgroundColor = _titlesScrollView.backgroundColor = [UIColor whiteColor];
		
		[self addSubview:_titlesScrollView];
		[self addSubview:_pagesScrollView];
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[self mg_loadData];
}


#pragma mark - Private methods
- (void)mg_loadData {
	[self mg_clearDataIfNeeded];
}

- (void)mg_clearDataIfNeeded {
#warning to implement
}

@end
