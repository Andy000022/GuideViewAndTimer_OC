//
//  GuideViewController.h
//  GuideViewAndTimer_OC
//
//  Created by iSolar on 2017/8/14.
//  Copyright © 2017年 nothing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController

/** 图片数组 */
@property (nonatomic, strong) NSArray *imgArr;

/** 倒计时 */
@property (nonatomic, assign) NSInteger timeCode;

@property (strong, nonatomic) UIPageControl *pageControl;

/** 开始体验的btn */
@property (strong, nonatomic) UIButton *startBtn;

/** 定时器 */
@property (strong, nonatomic) NSTimer *timer;

/** 定时器btn */
@property (strong, nonatomic) UIButton *timeBtn;

@end
