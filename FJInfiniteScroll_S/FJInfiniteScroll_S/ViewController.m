//
//  ViewController.m
//  FJInfiniteScroll_S
//
//  Created by Francis on 16/3/5.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "ViewController.h"
#import "FJInfiniteScrollView.h"
#import "FJScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FJInfiniteScrollView *infiniteScrolView = [[FJInfiniteScrollView alloc] init];
    infiniteScrolView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    infiniteScrolView.images = @[
//                                 [UIImage imageNamed:@"img_00"],
                                 
                                 @"img_01",
                                 [UIImage imageNamed:@"img_02"],
                                 [NSURL URLWithString:@"http://img1.bdstatic.com/static/home/widget/search_box_home/logo/home_white_logo_0ddf152.png"],
                                 [UIImage imageNamed:@"img_03"],
                                 [UIImage imageNamed:@"img_04"]
                                 ];
    
    
    infiniteScrolView.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    infiniteScrolView.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    infiniteScrolView.placeHolder = [UIImage imageNamed:@"fj_placeHolderI"];
    
    [self.view addSubview:infiniteScrolView];
}

@end
