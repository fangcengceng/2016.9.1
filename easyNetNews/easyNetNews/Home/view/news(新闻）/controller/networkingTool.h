//
//  networkingTool.h
//  easyNetNews
//
//  Created by codygao on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface networkingTool : AFHTTPSessionManager
+(instancetype)sharednetToll;
-(void)GETwithRequestUrl:(NSString*)url successful:(void(^)(id responsobjec))successfulblock fail:(void(^)(NSError* error))failblock;
@end
