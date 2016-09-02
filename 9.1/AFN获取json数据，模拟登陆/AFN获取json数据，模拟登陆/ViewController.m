//
//  ViewController.m
//  AFN获取json数据，模拟登陆
//
//  Created by codygao on 16/9/1.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "jsonmodel.h"
@interface ViewController ()

@end

@implementation ViewController
#pragma  AF加载json数据
- (IBAction)json:(id)sender {
    AFHTTPSessionManager *manager = [ AFHTTPSessionManager manager];
    [manager GET:@"http://localhost/demo.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"%@ %@",[responseObject class],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma AF加载Get数据
- (IBAction)GETrequest:(UIButton*)sender {
    // manager
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    // 参数里面放用户名和密码 : 服务器需要的数据,都要放在这个字典里面,把字典当做方法的参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = @"f";
    parameters[@"password"] = @"1";
    
    // manager发送GET请求
    [manger GET:@"http://localhost/php/login/login.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
#pragma AF加载post数据
- (IBAction)POSTRequest:(UIButton*)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"username"]=@"f";
    dic[@"password"]= @"1";
    [manager POST:@"http://localhost/php/login/login.php"  parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



@end
