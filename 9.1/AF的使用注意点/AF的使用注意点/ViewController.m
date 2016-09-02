//
//  ViewController.m
//  AF的使用注意点
//
//  Created by codygao on 16/9/1.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadHTML];
    [self postjson];
    }
#pragma __AFN的序列化,
-(void)postjson{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html" ,nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //让AF处理json格式的二进制数据
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:@"zanshong" forKey:@"key"];
    [manager POST:@"http://localhost/php/upload/postjson.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}

#pragma 加载html数据
-(void)loadHTML{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    //AF默认值支持普通的二进制数据，修改发送json、xml、html/的二进制数据
    //响应.类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   
    //发送POST请求
    [manager POST:@"http://localhost/php/upload/postjson.php" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",html);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}

@end
