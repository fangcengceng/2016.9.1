//
//  downloadManage.h
//  音乐下载
//
//  Created by codygao on 16/8/30.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface downloadManage : NSObject
@property(nonatomic,copy)NSString *urlname ;
-(void)downloadWithUrlname:(NSString *)urlname progressBlock:(void(^)(float progress))progressBlock filepathBlock:(void(^)(NSString *filepath))filepathBlock;
+(instancetype)sharedmanage;
@end
