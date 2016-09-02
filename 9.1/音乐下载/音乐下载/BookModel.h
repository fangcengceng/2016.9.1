//
//  BookModel.h
//  音乐下载
//
//  Created by codygao on 16/8/30.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *path;
@property(assign,nonatomic)BOOL isSelectedBtn;
+(instancetype)bookWithDic:(NSDictionary*)dict;
@property(nonatomic,assign) float progress;
@end
