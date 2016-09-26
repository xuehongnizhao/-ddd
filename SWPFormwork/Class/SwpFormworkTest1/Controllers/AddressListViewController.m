//
//  AddressListViewController.m
//  SwpFormwork
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "AddressListViewController.h"

@interface AddressListViewController ()

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromNet];
    [self setUI];
    
}

- (void)setUI{
    [self setNavigationBarTitle:@"通讯录" textColor:[UIColor whiteColor] titleFontSize:@20];

}

- (void)getDataFromNet{


}
@end
