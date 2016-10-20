//
//  WebViewController.m
//  SwpFormwork
//
//  Created by mac on 16/9/29.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD showWithStatus:@"正在加载\n请稍后..."];
    self.rdv_tabBarController.tabBarHidden=YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rdv_tabBarController.tabBarHidden=NO;
      [SVProgressHUD dismiss];
}

- (void)setWebID:(NSString *)webID{
    _webID=webID;
    [self setUI];
}

- (void)setUI{
    UIWebView *webView=[[UIWebView alloc]initForAutoLayout];
    NSString *urlSting=[NSString stringWithFormat:@"http://address.hongdingnet.com/web/contacts/page/inform/informData.html?inFormID=%@",_webID];
    NSURL *url=[NSURL URLWithString:urlSting];
    [self.view addSubview:webView];
    [webView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [webView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [webView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [webView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    webView.delegate=self;
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
@end
