//
//  HMNewsModel.h
//  easyNetNews
//
//  Created by codygao on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMNewsModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,assign)NSNumber *replyCount;
@property(nonatomic,copy)NSString *imgsrc;
//判断是否是大图
@property(nonatomic,assign)BOOL imgType;
//判断是否是多图
@property (strong, nonatomic) NSArray *imgextra;
+(instancetype)hmnewsWithDic:(NSDictionary*)dic;
@end
