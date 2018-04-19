//
//  ViewController.m
//  AFN请求模拟登陆
//
//  Created by codygao on 16/9/3.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self POSTRequest];
//    [self GETRequest];
    [self jsonRequest];
    
   }
#pragma  请求json数据
-(void)jsonRequest{
    NSString *urlstr = @"http://localhost/demo.json";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@ %@",[responseObject class],responseObject);
 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
}
#pragma 发送get请求
-(void)GETRequest{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dic = @{@"username":@"f",@"password":@"1"};
    [manager GET:@"http://localhost/php/login/login.php" parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
       // NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@ ,task = %@",responseObject,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@ %@",error,task);
    }];
}
#pragma 发送POST请求
-(void)POSTRequest{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *paramenters  =[NSMutableDictionary dictionary];
    paramenters[@"username"] = @"f";
    paramenters[@"password"] = @"1";
    NSString *urlstr = @"http://localhost/php/login/login.php";
    [manager POST:urlstr parameters:paramenters progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@ responseObjet = %@",task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
}
@end
