//
//  HomeViewController.m
//  easyNetNews
//
//  Created by codygao on 16/9/1.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HomeViewController.h"
#import "ChanelModel.h"
#import "customLabel.h"
#define kLABLELW 80
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *homecollectionlayout;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UICollectionView *HomeCollection;
@end

@implementation HomeViewController{
    NSArray *_channelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatChannelLabel];
    //设置scrollview 的相关属性
    self.automaticallyAdjustsScrollViewInsets =NO;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.scrollview.contentSize =CGSizeMake(kLABLELW *_channelList.count,kLABLELW);
    self.homecollectionlayout.itemSize = self.HomeCollection.bounds.size;
}
#pragma  --uicollectiondatasouce
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _channelList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homecollectioncell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256)/255.0)green: ((float)arc4random_uniform(256)/255.0)blue:((float)arc4random_uniform(256)/255.0) alpha:1];
    return cell;
}
//创建频道标签的主方法
-(void)creatChannelLabel{
    //定义label的宽和高
    CGFloat labelW =kLABLELW;
    CGFloat labelH = self.scrollview.bounds.size.height;
   _channelList = [ChanelModel channels];
    for(NSInteger i = 0; i<_channelList.count; i++){
        customLabel *label = [[customLabel alloc] init];
        CGFloat labelX = kLABLELW*i;
      
        label.frame = CGRectMake(labelX, 0, labelW, labelH);
        [self.scrollview addSubview:label];
        ChanelModel *model = _channelList[i];
        label.text = model.tname;
    }
}

@end
