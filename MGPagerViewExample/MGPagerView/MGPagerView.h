//
//  MGPagerView.h
//  MGPagerViewExample
//
//  Created by admin on 23/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGPagerView;

#pragma mark - Delegate protocol
@protocol MGPagerViewDelegate <NSObject>

@end

#pragma mark - Datasource protocol
@protocol MGPagerViewDatasource <NSObject>

- (NSUInteger)numberOfPageInPagerView:(MGPagerView *)pagerView;
- (UIView *)pagerView:(MGPagerView *)pagerView viewForPageAtIndex:(NSUInteger)index;
- (UIView *)pagerView:(MGPagerView *)pagerView titleForRowAtIndex:(NSUInteger)index;
- (UIView *)pagerView:(MGPagerView *)pagerView fontForTitleAtIndex:(NSUInteger)index;

@end


extern CGFloat kMGPagerViewTitlesViewHeight;

#pragma mark - MGPagerView Interface
@interface MGPagerView : UIView

@property (strong, nonatomic) UIColor *titlesViewBackgroundColor;
@property (strong, nonatomic) UIColor *pagesViewBackgroundColor;
@end
