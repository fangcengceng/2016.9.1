//
//  HMNewsModel.m
//  easyNetNews
//
//  Created by codygao on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HMNewsModel.h"

@implementation HMNewsModel
+(instancetype)hmnewsWithDic:(NSDictionary*)dic{
    HMNewsModel *model = [[HMNewsModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
