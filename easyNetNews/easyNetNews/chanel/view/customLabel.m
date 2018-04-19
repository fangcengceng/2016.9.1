//
//  customLabel.m
//  easyNetNews
//
//  Created by codygao on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "customLabel.h"
#define minScale 1.0
#define maxScale 1.2

@implementation customLabel

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:16];
//        self.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256)/255.0)green: ((float)arc4random_uniform(256)/255.0)blue:((float)arc4random_uniform(256)/255.0) alpha:1];
        //字体颜色是红色
//        self.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1.0];
        //字体颜色是黑色
//        self.textColor  =[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
      
    }
    return self;
}
-(void)setScale:(CGFloat)scale{
      _scale = scale;
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    //设置缩放比

    scale = minScale+(maxScale-minScale)*scale;
    //设置缩放比
    self.transform = CGAffineTransformMakeScale(scale, scale);

    
}
@end
