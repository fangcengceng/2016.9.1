//
//  customLabel.m
//  easyNetNews
//
//  Created by codygao on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "customLabel.h"

@implementation customLabel

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:16];
//        self.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256)/255.0)green: ((float)arc4random_uniform(256)/255.0)blue:((float)arc4random_uniform(256)/255.0) alpha:1];
    }
    return self;
}

@end
