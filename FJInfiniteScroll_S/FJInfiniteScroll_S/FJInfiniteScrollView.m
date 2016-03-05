//
//  FJInfiniteScrollView.m
//  FJInfiniteScroll_S
//
//  Created by Francis on 16/3/5.
//  Copyright © 2016年 FRAJ. All rights reserved.
//

#import "FJInfiniteScrollView.h"
#import "UIImageView+WebCache.h"

@interface FJInfiniteScrollView()<UIScrollViewDelegate>

@property (nonatomic ,weak) UIScrollView *scrollView;
@property (nonatomic ,weak) UIPageControl *pageControl;
/** 定时器*/
@property (nonatomic ,weak) NSTimer *timer;


@end

@implementation FJInfiniteScrollView
/** scrollView中UIImageView的数量 */

static NSInteger FJImageViewCount = 3;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //scrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.backgroundColor = [UIColor orangeColor];
        [self addSubview:scrollView];
        
        self.scrollView = scrollView;
        
        //UIImageView
        for (NSInteger i = 0; i < FJImageViewCount; i++) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [scrollView addSubview:imageView];
            
        }
        
        //UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        
        //时间间隔
        self.timerInterval = 1.5;
        
        //滚动方向
        self.scrollDirection = FJInfiniteScrollDirectionHorizontal;
    
    }
    return self;
}

-(void)layoutSubviews{
 
    [super layoutSubviews];
    
    CGFloat selfW = self.frame.size.width;
    CGFloat selfH = self.frame.size.height;
    
    //UIScrollView
    self.scrollView.frame = self.bounds;
    if (self.scrollDirection == FJInfiniteScrollDirectionHorizontal) {
        self.scrollView.contentSize  = CGSizeMake(FJImageViewCount * selfW, 0);
    }else if (self.scrollDirection == FJInfiniteScrollDirectionVertical){
        self.scrollView.contentSize  = CGSizeMake(0, FJImageViewCount * selfH);
    }
    
    
    //UIImageView
    for (NSInteger i = 0; i < FJImageViewCount; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
        
        if (self.scrollDirection == FJInfiniteScrollDirectionHorizontal) {
            imageView.frame = CGRectMake(i * selfW, 0, selfW, selfH);
        }else if (self.scrollDirection == FJInfiniteScrollDirectionVertical){
            imageView.frame = CGRectMake(0, i * selfH, selfW, selfH);
        }
        
        
    }
    
    //UIPageControl
    CGFloat pageControlW = 100;
    CGFloat pageControlH = 25;
    self.pageControl.frame = CGRectMake(selfW - pageControlW, selfH - pageControlH, pageControlW, pageControlH);
    
    //更新内容
    [self updateContentAndOffset];
}

-(void)updateContentAndOffset{
    
    //1.更新imageView上面的内容
    for (NSInteger i = 0; i < FJImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        //根据当前页码求出imageIndex
        NSInteger imageIndex = 0;
        if (i == 0) {
            imageIndex = self.pageControl.currentPage - 1;
            if (imageIndex == -1) {
                imageIndex = self.images.count -1;
            }
        }else if (i == 1){
            imageIndex = self.pageControl.currentPage;
        }else if (i == 2){
            imageIndex = self.pageControl.currentPage + 1;
            if (imageIndex == self.images.count) {
                imageIndex = 0;
            }
        }
        
        imageView.tag = imageIndex;
        
        //图片数据
        id obj = self.images[imageIndex];
        if ([obj isKindOfClass:[UIImage class]]) {//UIImage对象
            imageView.image = obj;
        }else if ([obj isKindOfClass:[NSString class]]){//本地图片
            imageView.image = [UIImage imageNamed:obj];
        }else if ([obj isKindOfClass:[NSURL class]]){//远程图片

            [imageView sd_setImageWithURL:obj placeholderImage:self.placeHolder];

        }
    }
    
    //2.设置scrollView.contentOffset.x = 1倍宽度
    if (self.scrollDirection == FJInfiniteScrollDirectionHorizontal) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }else if (self.scrollDirection == FJInfiniteScrollDirectionVertical){
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.frame.size.height);
    }
    
    
}
-(void)setTimerInterval:(NSTimeInterval)timerInterval{
    _timerInterval = timerInterval;
    
    [self stopTimer];
    [self startTimer];
}

-(void)setImages:(NSArray *)images{
    _images = images;
    
    self.pageControl.numberOfPages = images.count;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //找出显示在最中间的imageview
    UIImageView *middleImageView = nil;
    //x值和偏移量x的最小差值
    CGFloat minDelta = MAXFLOAT;
    for (NSInteger i = 0; i< FJImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        //x值和偏移量x值差值最小的imageView ,就显示在最中间的imageView
        CGFloat currentDelta = 0;
        if (self.scrollDirection == FJInfiniteScrollDirectionHorizontal) {
           currentDelta = ABS(imageView.frame.origin.x - self.scrollView.contentOffset.x);
        }else if (self.scrollDirection == FJInfiniteScrollDirectionVertical){
           currentDelta = ABS(imageView.frame.origin.y - self.scrollView.contentOffset.y);
        }
        
        if (currentDelta < minDelta) {
            minDelta = currentDelta;
            middleImageView = imageView;
        }
        
    }
    self.pageControl.currentPage = middleImageView.tag;
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self updateContentAndOffset];
}
/**
 *  即将开始拖拽
 *
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   
    [self stopTimer];
}
/**
 *  松开手时调用
 *
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self startTimer];
}
-(void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

-(void)stopTimer{
    
    [self.timer invalidate];
    self.timer = nil;
}

-(void)nextPage{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (self.scrollDirection == FJInfiniteScrollDirectionHorizontal) {
            self.scrollView.contentOffset = CGPointMake(2 * self.scrollView.frame.size.width, 0);
        }else if (self.scrollDirection == FJInfiniteScrollDirectionVertical){
            self.scrollView.contentOffset = CGPointMake(0, 2 * self.scrollView.frame.size.height);
        }
        
    } completion:^(BOOL finished) {
        
        [self updateContentAndOffset];
    }];
}
@end
