//
//  jsonmodel.h
//  AFN获取json数据，模拟登陆
//
//  Created by codygao on 16/9/1.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jsonmodel : NSObject
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong)NSNumber *num;
+(instancetype)jsonWithDic:(NSDictionary*)dic;
@end
