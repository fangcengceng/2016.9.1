//
//  networkingTool.m
//  easyNetNews
//
//  Created by codygao on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "networkingTool.h"
#import "AFNetworking.h"
@implementation networkingTool
+(instancetype)sharednetToll{
    static networkingTool *instance;
    static dispatch_once_t oncepath;
    dispatch_once(&oncepath, ^{
        NSURL *baseurl = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        instance = [[self alloc] initWithBaseURL:baseurl];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    });
    
    return instance;
}
-(void)GETwithRequestUrl:(NSString*)url successful:(void(^)(id))successfulblock fail:(void(^)(NSError*))failblock{
    [self GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(successfulblock != nil){
            successfulblock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
}


@end
