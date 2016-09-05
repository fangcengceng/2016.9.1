//
//  ViewController.m
//  OC和JS的交互
//
//  Created by codygao on 16/9/4.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.dianping.com/tuan/deal/5501525"]];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
}
//网页加载完成后，往这个方法里面注入js
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"var headerTag = document.getElementsByTagName('header')[0]; headerTag.parentNode.removeChild(headerTag);"];
    [str appendString:@"var footerTag = document.getElementsByClassName('footer')[0]; footerTag.parentNode.removeChild(footerTag);"];
    [str appendString:@"var footerBtnTag = document.getElementsByClassName('footer-btn-fix')[0]; footerBtnTag.parentNode.removeChild(footerBtnTag);"];
    //专门执行js代码注入
    [webView stringByEvaluatingJavaScriptFromString:str];
    
    
    
}
@end
