//
//  downloadManage.m
//  音乐下载
//
//  Created by codygao on 16/8/30.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "downloadManage.h"

@interface downloadManage()<NSURLSessionDownloadDelegate>
@property(nonatomic,copy)void(^myprogressblock)(float progress);
@property(nonatomic,strong)NSURLSession *session;
@end

@implementation downloadManage{
    //进度代码块缓存池；
    NSMutableDictionary *_progressblockDic;
    NSMutableDictionary *_filepathBlockDic;
    
}
+(instancetype)sharedmanage{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
-(instancetype)init{
    if(self = [super init]){
        //使用代码块也可以，但是不可以监视进度，而且下载在临时文件中，需要利用filemanage,需要监视进度，做操作
//        [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:@"/user/codygao/desktop/sougou.zip" error:NULL];
        //下载大文件需要使用代理，代理和代码块不能同时存在
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"sb"];
        _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        //实例化缓存池
        _progressblockDic = [[NSMutableDictionary alloc] init];
       _filepathBlockDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(void)downloadWithUrlname:(NSString *)urlname progressBlock:(void (^)(float))progressBlock filepathBlock:(void (^)(NSString *))filepathBlock{
    NSURL *URL = [NSURL URLWithString:urlname];
     NSURLSessionDownloadTask *downloadTask = [_session downloadTaskWithURL:URL];
    [downloadTask resume];
    //添加任务代码块
    [_progressblockDic setObject:progressBlock forKey:downloadTask];
    [_filepathBlockDic setObject:filepathBlock forKey:downloadTask];
}
#pragma MSURLSessionDelegate
//监听下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"%@",location.path);
    NSString *urlstring = downloadTask.currentRequest.URL.absoluteString;
    NSString *savePath = [urlstring lastPathComponent];
 
    NSString *savefilepath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:savePath];
    //创建文件管理者
    [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:savefilepath error:NULL];
    void(^filepathBlock)(NSString *filepath) = [_filepathBlockDic objectForKey:downloadTask];
    if(filepathBlock ){
        //会主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               filepathBlock(savefilepath);
        }];
    }
}
//监听下载进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    float pro = totalBytesWritten/totalBytesExpectedToWrite;
    void (^myprogressblock)(float) = [_progressblockDic objectForKey:downloadTask];
    if (myprogressblock != nil){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
             myprogressblock(pro);
        }];
    }
    //下载完成后，清空缓存池
    [_filepathBlockDic removeObjectForKey:downloadTask];
    [_progressblockDic removeObjectForKey:downloadTask];
}

@end
