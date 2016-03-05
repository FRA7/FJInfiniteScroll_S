//
//  FJScrollView.m
//  FJInfiniteScroll_S
//
//  Created by Francis on 16/3/5.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJScrollView.h"

@implementation FJScrollView

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.pageControl.frame = CGRectMake(0, 0, 100, 20);
}

@end
