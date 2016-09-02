//
//  jsonmodel.m
//  AFN获取json数据，模拟登陆
//
//  Created by codygao on 16/9/1.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "jsonmodel.h"

@implementation jsonmodel
+(instancetype)jsonWithDic:(NSDictionary*)dic{
    jsonmodel *jsonmo = [[jsonmodel alloc] init];
    [jsonmo setValuesForKeysWithDictionary:dic];
    return jsonmo;
}

@end
