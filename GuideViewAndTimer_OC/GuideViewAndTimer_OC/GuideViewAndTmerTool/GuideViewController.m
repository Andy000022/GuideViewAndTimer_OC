//
//  GuideViewController.m
//  GuideViewAndTimer_OC
//
//  Created by iSolar on 2017/8/14.
//  Copyright © 2017年 nothing. All rights reserved.
//

#import "GuideViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface GuideViewController ()<UIScrollViewDelegate>

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startTime];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.view addSubview:scroll];
    scroll.delegate = self;
    scroll.bounces = NO;
    scroll.pagingEnabled = YES;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.contentSize = CGSizeMake(kWidth*_imgArr.count, kHeight);
    
    for (int i = 0; i < _imgArr.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, kHeight)];
        [scroll addSubview:imgView];
        imgView.image = [UIImage imageNamed:_imgArr[i]];
    }
    
    _startBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth * 0.3, kHeight*0.85, kWidth * 0.4, 35)];
    [self.view insertSubview:_startBtn aboveSubview:scroll];
    _startBtn.layer.cornerRadius = 5;
    _startBtn.hidden = YES;
    _startBtn.backgroundColor = [UIColor whiteColor];
    _startBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_startBtn setTitle:@"立即体验" forState: UIControlStateNormal];
    [_startBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    _startBtn.tag = 100;
    [_startBtn addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
    
    _timeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-60, kHeight * 0.05, 40, 20)];
    [self.view insertSubview:_timeBtn aboveSubview:scroll];
    _timeBtn.backgroundColor = [UIColor whiteColor];
    _timeBtn.layer.cornerRadius = 5;
    _timeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_timeBtn setTitleColor:[UIColor lightGrayColor] forState: UIControlStateNormal];
    _timeBtn.tag = 101;
    [_timeBtn addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kWidth*0.25, kHeight * 0.85, kWidth * 0.5, 20)];
    [self.view insertSubview:_pageControl aboveSubview:scroll];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = _imgArr.count;
    _pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
}

- (void)stopTime {
    
    [_timer invalidate];
    _timer = nil;
    
}

- (void)startTime {
    
    if (_timer == nil) {
        
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updata) userInfo:nil repeats:YES];
    }
    
}

- (void)updata {

    [_timeBtn setTitle:[NSString stringWithFormat:@"%ld 秒", (long)_timeCode] forState:UIControlStateNormal];
    
    if (_timeCode == 0) {
        
        [self stopTime];
        
        [self jumpAction];
    }
    
    _timeCode -= 1;

}

- (void)jumpAction {

    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    _pageControl.currentPage = scrollView.contentOffset.x / kWidth;
    
    if (scrollView.contentOffset.x >= kWidth*(_imgArr.count - 1)) {
        
        _startBtn.hidden = NO;
        
    } else {
    
        _startBtn.hidden = YES;
        
    }
    
}

@end
