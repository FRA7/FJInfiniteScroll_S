//
//  FJInfiniteScrollView.h
//  FJInfiniteScroll_S
//
//  Created by Francis on 16/3/5.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJInfiniteScrollView : UIView
/** 图片数据(里面可以存放UIImage对象、NSString对象【本地图片名】、NSURL对象【远程图片的URL】) */
@property (nonatomic ,strong) NSArray *images;
/** 占位图片*/
@property (nonatomic ,strong) UIImage *placeHolder;
/** 每张图片之间的时间间隔*/
@property (nonatomic ,assign) NSTimeInterval timerInterval;

@property (nonatomic ,weak,readonly) UIPageControl *pageControl;
@end
