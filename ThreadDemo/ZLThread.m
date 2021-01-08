//
//  ZLThread.m
//  TZLDemo
//
//  Created by TZL on 2021/1/8.
//  Copyright © 2021 Tzl. All rights reserved.
//

#import "ZLThread.h"
@interface ZLThread()
/**  一条普通的线程  **/
@property (nonatomic , strong)NSThread  *thread;
/**  是否停止runLoop  **/
@property (nonatomic , assign)BOOL  isStoped;
@end
@implementation ZLThread

#pragma mark - --------- 公开的方法  ---------
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isStoped = NO;
        ///线程保活
        __weak typeof(self)weakSelf = self;
        self.thread = [[NSThread alloc] initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
            ///通过while循环来线程保活
            while(weakSelf && !weakSelf.isStoped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
    }
    return self;
}

///开启一条线程
- (void)run{
    if (!self.thread) return;
    [self.thread start];
}

///执行任务
- (void)executeTask:(void (^)(void))task{
    if (!task) return;
    if (!self.thread) return;
    ///在当前线程执行任务
    [self performSelector:@selector(__executeTask:) onThread:self.thread withObject:task waitUntilDone:NO];
}

///结束一条线程
- (void)stop{
    if (!self.thread) return;
    [self performSelector:@selector(__stopRunLoop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

#pragma mark - --------- 私有方法  ---------
///销毁析构方法
- (void)dealloc{
    NSLog(@"%s",__func__);
    [self stop];
}
///停止RunLoop
- (void)__stopRunLoop{
    self.isStoped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}
///执行任务
- (void)__executeTask:(void (^)(void))task{
    task();
}
@end
