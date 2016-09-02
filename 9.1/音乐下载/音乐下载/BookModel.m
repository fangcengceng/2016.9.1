//
//  BookModel.m
//  音乐下载
//
//  Created by codygao on 16/8/30.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel
+(instancetype)bookWithDic:(NSDictionary*)dict{
    BookModel *book = [[BookModel alloc] init];
    [book setValuesForKeysWithDictionary:dict];
    return book;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
