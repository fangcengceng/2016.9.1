//
//  ViewController.m
//  HEAD请求
//
//  Created by codygao on 16/8/31.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
#pragma 发送同步请求有返回值，没有data
- (IBAction)sysnrequest:(id)sender {
    NSURL *URL = [NSURL URLWithString:@"http://localhost/sogou.zip"];
    
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:URL];
      requestM.HTTPMethod = @"HEAD";
    NSURLResponse *URLresponse;
   NSData *data = [NSURLConnection sendSynchronousRequest:requestM returningResponse:&URLresponse error:NULL];
    //获取响应头信息
    if (URLresponse != nil){
        NSLog(@"响应体信息==%@",URLresponse);
        NSLog(@"%@",data);
         NSLog(@"服务器文件总大小 %lld",URLresponse.expectedContentLength);
        NSLog(@"%@",URLresponse.suggestedFilename);
     
    }else{
        NSLog(@"失败");
    }
    NSString *filepath =[NSString stringWithFormat:@"%@",URLresponse.suggestedFilename];
   // [data writeToFile:[@"/Users/codygao/Desktop/" stringByAppendingString:filepath]options:0 error:nil];
}
#pragma 发送异步请求没有返回值
- (IBAction)asysnrequest:(id)sender {
    NSURL *URL = [NSURL URLWithString:@"http://localhost/sogou.zip"];
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:URL];
    requestM.HTTPMethod = @"head";
  
   [NSURLConnection sendAsynchronousRequest:requestM queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
       if(connectionError == nil && data != nil){
           NSLog(@"异步响应体信息==%@",response);
           NSLog(@"%lld",response.expectedContentLength);
           NSLog(@"%@",response.suggestedFilename);
           [data writeToFile:[@"/Users/codygao/Desktop/" stringByAppendingString:response.suggestedFilename]options:0 error:NULL];
       }else{
           NSLog(@"失败");
       }
        
    }];
  
    
}


@end
