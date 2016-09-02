//
//  ViewController.m
//  NSURLSession实现单文件下载
//
//  Created by codygao on 16/8/31.
//  Copyright © 2016年 HM. All rights reserved.
//
/*
  需求，使用NSURLSession 下载文件(下载任务默认是在子线程进行）
    问题一：直接使用download下载也可以，但是内存暴涨，而且下载下来的文件保存在tep内存中
     办法：将文件保存在本地沙盒中(依然会在内存中中保存一下，内存依旧暴涨)，使用代理（同NSURLConnection一样）解决内存暴涨；
 
 
 */
#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>
@property(nonatomic,strong)NSURLSession *session;
@property(nonatomic,strong)NSURLSessionDownloadTask *downloadTask;
@end

@implementation ViewController{
    NSData *_uploadData;
}



#pragma 懒加载实现NSURLSession 的实例化本质是get方法
-(NSURLSession*)session{
    if (_session == nil){
        //配置信息，及时推出崩溃，下载依旧进行

        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"downconfig"];
        //使用代理,设置代理管理类
        _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    }
    return _session;
}
-(void)viewDidLoad{
    [super viewDidLoad];
}


#pragma 监听按钮的取消事件
- (IBAction)canceldownload:(id)sender {
    
    [_downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        NSLog(@"暂停任务%lu",resumeData.length);
        _uploadData = resumeData;
        
    }];
    
}
#pragma 监听按钮的暂停事件
- (IBAction)pausedownload:(id)sender {
    
    
}
#pragma 监听按钮的点击下载事件
- (IBAction)downloadclick:(id)sender {
    NSString *str  = @"http://localhost/sogou.zip";
    NSURL *URL = [NSURL URLWithString:str];
    //开始下载任务，session的block 代码块和代理不能同时存在，否自代理失效
    //子线程，不卡UI 但是要开启子线程才能个执行下面的代理方法；
    
      [[[NSOperationQueue alloc ] init] addOperationWithBlock:^{
          //懒加载必须使用self 这样才能调用get方法；使用下划线就不会调用get方法；
          _downloadTask = [self.session downloadTaskWithURL:URL];
          [_downloadTask resume];
          [[NSRunLoop currentRunLoop] run];
      }];
}
#pragma -----downloaddelegate
//监听下载完成的任务
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
   //保存到沙盒
   [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:@"/sogou.zip"] error:NULL];
}
//监听下载进度的方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten
 totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    float progress = (float)totalBytesWritten/totalBytesExpectedToWrite;
    NSLog(@"%f",progress);
}
#pragma  错误代码示范
-(void)wrongdemoshifan{
    NSURL *URL = [NSURL URLWithString:@"http://localhost/sogou.zip"];
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:URL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && response != nil){
            //保存在沙盒中
            [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:[ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString: @"/sogou.zip"] error:NULL];
            
        }else{
            NSLog(@"失败");
        }
    }];
     [downloadTask resume];
    
}


@end
