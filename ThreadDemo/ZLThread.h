//
//  ZLThread.h
//  TZLDemo
//
//  Created by TZL on 2021/1/8.
//  Copyright © 2021 Tzl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLThread : NSObject
/// 开启一条线程
- (void)run;


/// 执行一个任务
/// @param task 任务
- (void)executeTask:(void(^)(void))task;



/// 结束当前线程
- (void)stop;
@end

NS_ASSUME_NONNULL_END
