//
//  ViewController.m
//  NSURLSession的HTTPS
//
//  Created by codygao on 16/9/1.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHTTPS];
    
}
-(void)loadHTTPS{
    NSURL *URL = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLSessionConfiguration *congi = [NSURLSessionConfiguration defaultSessionConfiguration];
  [NSURLSession sessionWithConfiguration:congi delegate:self delegateQueue:nil];
    
}
@end
