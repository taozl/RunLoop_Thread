//
//  RunLoopController.m
//  TZLDemo
//
//  Created by TZL on 2021/1/7.
//  Copyright © 2021 Tzl. All rights reserved.
//
/**
 创建一个线程，
 通过RunLoop让线程保活，
 然后在线程中执行其他的任务
 **/
#import "RunLoopController.h"
#import "ZLThread.h"///自定的线程

@interface RunLoopController ()
/**  线程  **/
@property (nonatomic , strong)ZLThread  *thread;

@end

@implementation RunLoopController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.thread = [[ZLThread alloc]init];
    [self.thread run];
    
    ///手动停止runLoop
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 200, 40);
    [btn setTitle:@"手动停止runLoop" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(handleEndRunLoop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
///点击屏幕
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ///在当前线程中执行一些任务
    __weak typeof(self)weakSelf = self;
    [self.thread executeTask:^{
        [weakSelf test];
    }];
}
///点击屏幕执行的事件
- (void)test{
    NSLog(@"在子线程中 触发了点击事件 当前线程为:%@",[NSThread currentThread]);
}


///手动停止runLoop
- (void)handleEndRunLoop{
    [self.thread stop];
}



///释放控制器
- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
