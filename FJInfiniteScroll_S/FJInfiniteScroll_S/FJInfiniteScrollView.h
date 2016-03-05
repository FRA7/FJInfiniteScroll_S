//
//  FJInfiniteScrollView.h
//  FJInfiniteScroll_S
//
//  Created by Francis on 16/3/5.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FJInfiniteScrollView;

@protocol FJInfiniteScrollViewDelegate <NSObject>
@optional
- (void)infiniteScrollView:(FJInfiniteScrollView *)infiniteScrollView didClickImageAtIndex:(NSInteger)index;

@end

typedef NS_ENUM(NSInteger, FJInfiniteScrollDirection) {
    /** 左右滑动 */
    FJInfiniteScrollDirectionHorizontal = 0,
    /** 上下滑动 */
    FJInfiniteScrollDirectionVertical = 1
};

@interface FJInfiniteScrollView : UIView
/** 图片数据(里面可以存放UIImage对象、NSString对象【本地图片名】、NSURL对象【远程图片的URL】) */
@property (nonatomic ,strong) NSArray *images;
/** 占位图片*/
@property (nonatomic ,strong) UIImage *placeHolder;
/** 每张图片之间的时间间隔*/
@property (nonatomic ,assign) NSTimeInterval timerInterval;

@property (nonatomic ,weak,readonly) UIPageControl *pageControl;
/** 滚动方向*/
@property (nonatomic ,assign) FJInfiniteScrollDirection scrollDirection;

/** 代理*/
@property (nonatomic ,weak) id<FJInfiniteScrollViewDelegate> delegate;
@end
