//
//  ChanelModel.h
//  easyNetNews
//
//  Created by codygao on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChanelModel : NSObject
@property(nonatomic,copy)NSString *tname,*tid;

+(NSArray*)channels;
@end
