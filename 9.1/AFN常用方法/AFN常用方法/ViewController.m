//
//  ViewController.m
//  AFN常用方法
//
//  Created by codygao on 16/9/1.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //[self demo2];
    //MARK: 网络状态
}
#pragma 相对路径
-(void)demo1{
    NSURL *baseURL = [NSURL URLWithString:@"http://localhost/"];
    AFHTTPSessionManager *manage = [[ AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    [manage GET:@"demo.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject class]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
#pragma https
-(void)demo2{
    AFHTTPSessionManager *manager = [ AFHTTPSessionManager manager];
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
    manager.responseSerializer = [  AFHTTPResponseSerializer serializer ];
    [manager GET:@"https://mail.itcast.cn" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *html = [[NSString alloc ] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",html);
       [ self.webView loadHTMLString:html baseURL:[NSURL URLWithString:@"https://mail.itcast.cn"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}






@end
