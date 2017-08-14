//
//  ViewController.m
//  GuideViewAndTimer_OC
//
//  Created by iSolar on 2017/8/14.
//  Copyright © 2017年 nothing. All rights reserved.
//

#import "ViewController.h"
#import "GuideViewController.h"
#import <ColorExtension/UIColor+Hex.h>

@interface ViewController ()

@property (nonatomic, strong) UIButton *timerBtn;
@property (assign, nonatomic) NSInteger timeCode;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isRestTime;//segment的页面选择

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"e3e2e4"];
    
    self.title = @"引导页和定时器";
    [[NSUserDefaults standardUserDefaults] boolForKey:@"first"];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"first"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first"];
        [self setGuideView];
    }
    
    _timerBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 150, 35)];
    [self.view addSubview:_timerBtn];
    _timerBtn.backgroundColor = [UIColor whiteColor];
    _timerBtn.layer.cornerRadius = 5;
    _timerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_timerBtn setTitle:@"获取验证码" forState: UIControlStateNormal];
    [_timerBtn setTitleColor:[UIColor redColor] forState: UIControlStateNormal];
    [_timerBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setGuideView {

    GuideViewController *vc = [GuideViewController new];
    vc.imgArr = @[@"yindao_1",@"yindao_2",@"yindao_3",@"yindao_4"];
    vc.timeCode = 10;
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    
}

- (void)getCode {

    [self startTime];

}

- (void)stopTime {
    
    [_timer invalidate];
    _timer = nil;
    
}

- (void)startTime {
    
    if (_timer == nil) {
        
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updata) userInfo:nil repeats:YES];
        _timeCode = 10;
        _timerBtn.enabled = NO;
    }
    
}

- (void)updata {
    
    [_timerBtn setTitle:[NSString stringWithFormat:@"%ld 秒", (long)_timeCode] forState:UIControlStateNormal];
    [_timerBtn setTitleColor:[UIColor lightGrayColor] forState: UIControlStateNormal];
    if (_timeCode == 0) {
        
        [self stopTime];
        [_timerBtn setTitle:@"请重新获取验证码" forState:UIControlStateNormal];
        [_timerBtn setTitleColor:[UIColor redColor] forState: UIControlStateNormal];
        _timerBtn.enabled = YES;
    }
    _timeCode -= 1;
    
}

@end
