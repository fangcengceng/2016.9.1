//
//  ViewController.m
//  压缩和解压缩
//
//  Created by codygao on 16/9/1.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "SSZipArchive.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //从网上下载的文件都是压缩的形式的，需要将其进行解压缩
    //[self unzipdemo];
    [self zipdemo];
}
#pragma 解压缩
-(void)unzipdemo{
    NSURL *URL = [NSURL URLWithString:@"http://localhost/sogou.zip"];
    
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:URL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil){
        [SSZipArchive unzipFileAtPath:location.path toDestination:@"/Users/codygao/Desktop/sogou.zip"];
        }else{
            NSLog(@"失败");
        }
    }];
    [downloadTask resume];
    
}
#pragma 压缩文件
//参数一：压缩后的文件路径
//参数二：要压缩的文件路径
-(void)zipdemo{
    [SSZipArchive createZipFileAtPath:@"/Users/codygao/Desktop/sogou.zip" withContentsOfDirectory:@"/Users/codygao/Desktop/test"];
    
}
@end
