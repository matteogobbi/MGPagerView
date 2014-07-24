//
//  MGViewController.m
//  MGPagerViewExample
//
//  Created by admin on 23/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGViewController.h"

@interface MGViewController ()

@end

@implementation MGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	MGPagerView *pagerView = [[MGPagerView alloc] initWithFrame:CGRectMake(0, 10, 320, 558)];
	pagerView.delegate = self;
	pagerView.datasource = self;
	[self.view addSubview:pagerView];
}

- (NSUInteger)numberOfPageInPagerView:(MGPagerView *)pagerView
{
	return 5;
}

- (NSString *)pagerView:(MGPagerView *)pagerView titleForRowAtIndex:(NSUInteger)index
{
	switch (index) {
		case 0:
			return @"Posts";
		case 1:
			return @"Messages";
		case 2:
			return @"Notifies";
		case 3:
			return @"Profile";
		case 4:
			return @"Settings";
		default:
			return @"";
	}
}

- (UIView *)pagerView:(MGPagerView *)pagerView viewForPageAtIndex:(NSUInteger)index
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pagerView.frame.size.width, pagerView.frame.size.height-kMGPagerViewTitlesViewHeight)];
    
    switch (index) {
        case 0:
            view.backgroundColor = [UIColor redColor];
            break;
        case 1:
            view.backgroundColor = [UIColor yellowColor];
            break;
        case 2:
            view.backgroundColor = [UIColor cyanColor];
            break;
        case 3:
            view.backgroundColor = [UIColor blueColor];
            break;
        case 4:
            view.backgroundColor = [UIColor orangeColor];
            break;
        default:
            break;
    }
    
    return view;
}

@end
