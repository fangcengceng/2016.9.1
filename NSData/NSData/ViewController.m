//
//  ViewController.m
//  NSData
//
//  Created by codygao on 16/9/1.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   }
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
  

}
#pragma  字符串与二进制；
-(void)demo1{
    //字符串转化为二进制
    NSString *str = @"hello world";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"data.bytes===%s",data.bytes);
    NSLog(@"data==%lu",data.length);
    //二进制转化为字符串
    //对象方法
    NSString *newstr  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"newstr===%@",newstr);
}
@end
