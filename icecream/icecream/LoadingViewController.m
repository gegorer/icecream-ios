//
//  LoadingViewController.m
//  icecream
//
//  Created by Shao Hang Kao on 2013/11/12.
//  Copyright (c) 2013年 gegorer. All rights reserved.
//

#import "LoadingViewController.h"
#import "Stores.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    dispatch_queue_t queue = dispatch_queue_create("org.gegorer.icecream", NULL);
    dispatch_async(queue, ^{
        [[Stores singleton] checkData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"loadCompleteSegue" sender:self];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
