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
	
	MGPagerView *pagerView = [[MGPagerView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	pagerView.delegate = self;
	pagerView.datasource = self;
	[self.view addSubview:pagerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
