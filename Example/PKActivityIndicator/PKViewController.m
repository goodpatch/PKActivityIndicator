//
//  PKViewController.m
//  PKActivityIndicator
//
//  Created by Seiya Shimokawa on 07/09/2015.
//  Copyright (c) 2015 Seiya Shimokawa. All rights reserved.
//

#import "PKViewController.h"
#import "PKActivityIndicator.h"

@interface PKViewController ()

@end

@implementation PKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    PKActivityIndicator *indicator = [[PKActivityIndicator alloc] init];
    [self.view addSubview:indicator];
    indicator.center = CGPointMake(self.view.center.x + 64, self.view.center.y);
    [indicator startAnimating];
    
    indicator = [[PKActivityIndicator alloc] init];
    indicator.barColor = [UIColor colorWithRed:1./255. green:138./255. blue:218./255. alpha:1.0];
    indicator.barWidth = 8;
    indicator.barHeight = 8;
    indicator.aperture = 14;
    indicator.numberOfBars = 8;
    indicator.anmDuration = 0.5;
    [self.view addSubview:indicator];
    indicator.center = CGPointMake(self.view.center.x - 64, self.view.center.y);
    [indicator startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
