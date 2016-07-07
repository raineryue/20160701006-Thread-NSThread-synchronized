//
//  ViewController.m
//  20160701006-Thread-NSThread-synchronized
//
//  Created by Rainer on 16/7/7.
//  Copyright © 2016年 Rainer. All rights reserved.
//  本例子模拟一个多个售票员售票的实例

#import "ViewController.h"

@interface ViewController ()

/** 售票员01 */
@property (nonatomic, strong) NSThread *thread01;
/** 售票员02 */
@property (nonatomic, strong) NSThread *thread02;
/** 售票员03 */
@property (nonatomic, strong) NSThread *thread03;

/** 车票总数 */
@property (nonatomic, assign) NSInteger ticketCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建售票员01
    self.thread01 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicketAction:) object:@"售票员01"];
    // 设置售票员的名字
    self.thread01.name = @"售票员01";
    
    // 创建售票员02
    self.thread02 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicketAction:) object:@"售票员02"];
    // 设置售票员的名字
    self.thread02.name = @"售票员02";
    
    // 创建售票员01
    self.thread03 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicketAction:) object:@"售票员03"];
    // 设置售票员的名字
    self.thread03.name = @"售票员03";
    
    // 初始化车票总数
    self.ticketCount = 100;
}

/**
 *  售票窗口
 */
- (void)saleTicketAction:(NSString *)salerName {
    // 开启售票
    while (1) {
        // 以当前控制器为锁添加“互斥锁”
        @synchronized (self) {
            // 获取当前的票总数
            NSInteger currentCount = self.ticketCount;
            
            // 如果还有余票就卖出一张
            if (currentCount > 0) {
                // 卖出一张票将剩余票赋值回总票变量
                self.ticketCount = currentCount - 1;
                
                NSLog(@"[%@]卖了一张票，还剩下[%zd]张票", salerName, self.ticketCount);
            } else {
                NSLog(@"票已售完");
                
                break;
            }
        }
    }
}

/**
 *  点击屏幕开始售票
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.thread01 start];
    [self.thread02 start];
    [self.thread03 start];
}

@end
