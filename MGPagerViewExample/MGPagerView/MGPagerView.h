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
- (NSString *)pagerView:(MGPagerView *)pagerView titleForRowAtIndex:(NSUInteger)index;

@end

#pragma mark - Var exposed (for inherit classes)
extern CGFloat kMGPagerViewTitlesViewHeight;
extern CGFloat kMGPagerViewTitlesMargin;

#pragma mark - MGPagerView Interface
@interface MGPagerView : UIView

@property (weak, nonatomic) id<MGPagerViewDelegate> delegate;
@property (weak, nonatomic) id<MGPagerViewDatasource> datasource;

@property (readonly) CGFloat titlesViewHeight;

@property (readonly) NSUInteger selectedPageIndex;

@property (strong, nonatomic) UIColor *titlesViewBackgroundColor;
@property (strong, nonatomic) UIColor *pagesViewBackgroundColor;
@property (strong, nonatomic) UIColor *titlesColor;
@property (strong, nonatomic) UIColor *selectedTitleColor;
@property (strong, nonatomic) UIFont *titlesFont;

- (void)reloadData;

@end
