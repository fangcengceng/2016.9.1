//
//  HomeCollectionViewCell.h
//  easyNetNews
//
//  Created by codygao on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell : UICollectionViewCell
//接收从主页传来的URL
@property(nonatomic,copy)NSString *urlstr;
@end
