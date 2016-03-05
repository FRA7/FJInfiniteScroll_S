//
//  ViewController.m
//  FJInfiniteScroll_S
//
//  Created by Francis on 16/3/5.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "ViewController.h"
#import "FJInfiniteScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FJInfiniteScrollView *infiniteScrolView = [[FJInfiniteScrollView alloc] init];
    infiniteScrolView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    infiniteScrolView.images = @[
                                 [UIImage imageNamed:@"img_00"],
                                 [UIImage imageNamed:@"img_01"],
                                 [UIImage imageNamed:@"img_02"],
                                 [UIImage imageNamed:@"img_03"],
                                 [UIImage imageNamed:@"img_04"]
                                 ];
    
    [self.view addSubview:infiniteScrolView];
}

@end
