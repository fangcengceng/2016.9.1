//
//  ViewController.m
//  AF上传和下载
//
//  Created by codygao on 16/9/1.
//  Copyright © 2016年 HM. All rights reserved.
//
#import "AFNetworking.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
#pragma  上传本质是POST方法
- (IBAction)upload:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *textdic = @{@"status":@"马上就要回家了"};
    [manager POST:@"http://localhost/php/upload/upload-m.php" parameters:textdic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //拼接二进制数据一
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"mm02.jpg" ofType:nil];
                             
        NSData *data1 = [NSData dataWithContentsOfFile:filepath];
        [formData appendPartWithFileData:data1 name:@"userfile[]" fileName:@"mm2.jpg" mimeType:@"imag/jpg"];
        
        NSString *filepath2 = [[NSBundle mainBundle] pathForResource:@"mm01.jpg" ofType:nil];
        NSData *data2 = [NSData dataWithContentsOfFile:filepath2];
        [formData appendPartWithFileData:data2 name:@"userfile[]" fileName:@"mm1.jpg" mimeType:@"imag/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%f",uploadProgress.fractionCompleted);
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma 下载本质是downloadtask 方法,要resume
- (IBAction)download:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/sogou.zip"]];
    [[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%f",downloadProgress.fractionCompleted);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSLog(@"%@",targetPath);
        //给的是路径，返回的URL要接在路径方法；
      NSString *strfile = @"/Users/codygao/Desktop/sogou.zip";
        NSURL *url = [NSURL fileURLWithPath:strfile];
        return url;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
       
        NSLog(@"%@",error);
    }] resume];
    
    
    
                             
}

@end
