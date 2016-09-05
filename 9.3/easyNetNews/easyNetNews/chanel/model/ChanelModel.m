//
//  ChanelModel.m
//  easyNetNews
//
//  Created by codygao on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ChanelModel.h"

@implementation ChanelModel
//获取频道标签模型数组的主方法
+(NSArray*)channels{
    //获取json文件的路径
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    //通过路径获取json的二进制
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    //json反序列化
    NSDictionary  *dicarray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *array = dicarray[@"tList"];
    NSMutableArray<ChanelModel
    *> *temparray = [NSMutableArray arrayWithCapacity:array.count];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ChanelModel *model = [ChanelModel chanelWithDic:obj];
        [temparray addObject:model];
    }];
  //回调默认有返回值
    [temparray sortUsingComparator:^NSComparisonResult(ChanelModel* obj1, ChanelModel*  _Nonnull obj2) {
        //从小刀到大进行排序
     return [obj1.tid compare:obj2.tid];
        
    }];
    return temparray.copy;
}
+(instancetype)chanelWithDic:(NSDictionary*)dic{
    ChanelModel *model = [[ChanelModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}







@end
