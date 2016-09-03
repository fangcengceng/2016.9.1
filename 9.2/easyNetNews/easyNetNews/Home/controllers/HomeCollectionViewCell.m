//
//  HomeCollectionViewCell.m
//  easyNetNews
//
//  Created by codygao on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "HMNewController.h"
@interface HomeCollectionViewCell()
@property(nonatomic,strong)HMNewController *newvc;
@end;
@implementation HomeCollectionViewCell
-(void)awakeFromNib{
    [super awakeFromNib];
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"HMNewController" bundle:nil];
    HMNewController *vc = [SB instantiateInitialViewController];
    vc.tableView.frame = self.bounds;
    [self.contentView addSubview:vc.tableView];
    vc.tableView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    self.newvc =vc;
}
-(void)setUrlstr:(NSString *)urlstr{
    _urlstr = urlstr;
    _newvc.urlName = urlstr;

}
@end
