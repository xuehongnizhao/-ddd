//
//  CallInfoViewController.m
//  SwpFormwork
//
//  Created by mac on 2016/10/14.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "CallInfoViewController.h"

@interface CallInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSArray *telePhone;
@property (strong, nonatomic) NSArray *phone;
@end

@implementation CallInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden=YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rdv_tabBarController.tabBarHidden=NO;
}
- (void)setPeopleInfo:(PeopleInfo *)peopleInfo{
    _peopleInfo=peopleInfo;
    self.telePhone=[peopleInfo.telephone componentsSeparatedByString:@","];
    self.phone=[peopleInfo.phone componentsSeparatedByString:@","];
    [self setUI];

}

- (void)setUI{
    self.title=@"详情";
    
    UIImageView *imagView=[[UIImageView alloc]initForAutoLayout];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://address.hongdingnet.com/web/%@",_peopleInfo.photo]];
    [imagView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"team_6"]];
     [self.view addSubview:imagView];
    [imagView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [imagView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [imagView autoSetDimensionsToSize:CGSizeMake(80*BalanceWidth, 80*BalanceWidth)];
    
    UILabel *xingmingLable=[[UILabel alloc]initForAutoLayout];
    xingmingLable.text=@"姓名:";
    [self.view addSubview:xingmingLable];
    [xingmingLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [xingmingLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imagView withOffset:30];
    [xingmingLable autoSetDimensionsToSize:CGSizeMake(60, 20)];
    
    UILabel *zhiwuLabel=[[UILabel alloc]initForAutoLayout];
    zhiwuLabel.text=@"职务:";
    [self.view addSubview:zhiwuLabel];
    [zhiwuLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imagView withOffset:30];
    [zhiwuLabel autoSetDimensionsToSize:CGSizeMake(60, 20)];
    [zhiwuLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:xingmingLable withOffset:20];
    
    UILabel *nameLabel=[[UILabel alloc]initForAutoLayout];
    nameLabel.textColor=[UIColor grayColor];
    nameLabel.text=self.peopleInfo.peopleName;
    [self.view addSubview:nameLabel];
    [nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:xingmingLable withOffset:5];
    [nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [nameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [nameLabel autoSetDimension:ALDimensionHeight toSize:20];
    
    UILabel *positionLabel=[[UILabel alloc]initForAutoLayout];
    positionLabel.text=self.peopleInfo.position;
    positionLabel.textColor=[UIColor grayColor];
    [self.view addSubview:positionLabel];
    [positionLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [positionLabel autoSetDimension:ALDimensionHeight toSize:20];
    [positionLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:zhiwuLabel withOffset:5];
    [positionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameLabel withOffset:20];
    
    UITableView *tableView=[[UITableView alloc]initForAutoLayout];
    
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    [tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imagView withOffset:10];
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 3;
            break;

        default:
            return 2;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    UILabel *labelleft=[[UILabel alloc]initForAutoLayout];
                    labelleft.text=@"处        室:";
                    [cell.contentView addSubview:labelleft];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeTop ];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [labelleft autoSetDimension:ALDimensionWidth toSize:100];
                    
                    UILabel *laberRight=[[UILabel alloc]initForAutoLayout];
                    laberRight.text=self.peopleInfo.departments;
                    [cell.contentView addSubview:laberRight];
                    laberRight.textColor=[UIColor grayColor];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeRight];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeTop];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [laberRight autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:labelleft withOffset:20];

                }
                    break;
                case 1:{
                    UILabel *labelleft=[[UILabel alloc]initForAutoLayout];
                    labelleft.text=@"部        门:";
                    [cell.contentView addSubview:labelleft];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeTop ];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [labelleft autoSetDimension:ALDimensionWidth toSize:100];
                    
                    UILabel *laberRight=[[UILabel alloc]initForAutoLayout];
                    laberRight.text=self.peopleInfo.groupName;
                    laberRight.textColor=[UIColor grayColor];
                    [cell.contentView addSubview:laberRight];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeRight];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeTop];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [laberRight autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:labelleft withOffset:20];
                    
                }
                    break;
                case 2:{
                    UILabel *labelleft=[[UILabel alloc]initForAutoLayout];
                    labelleft.text=@"单        位:";
                    [cell.contentView addSubview:labelleft];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeTop ];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [labelleft autoSetDimension:ALDimensionWidth toSize:100];
                    
                    UILabel *laberRight=[[UILabel alloc]initForAutoLayout];
                    laberRight.text=self.peopleInfo.teamName;
                    [cell.contentView addSubview:laberRight];
                    laberRight.textColor=[UIColor grayColor];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeRight];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeTop];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [laberRight autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:labelleft withOffset:20];
                    
                }
                    break;
                    
                default:
                    break;
            }
                    }
            break;
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    UILabel *labelleft=[[UILabel alloc]initForAutoLayout];
                    labelleft.text=@"移动电话:";
                    [cell.contentView addSubview:labelleft];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeTop ];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [labelleft autoSetDimension:ALDimensionWidth toSize:100];
                    
                    UILabel *laberRight=[[UILabel alloc]initForAutoLayout];
                    if (self.phone.count>0) {
                        laberRight.text=self.phone[0];
                    }
                    [cell.contentView addSubview:laberRight];
                    laberRight.textColor=[UIColor grayColor];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeRight];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeTop];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [laberRight autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:labelleft withOffset:20];
                    
                }
                    break;
                case 1:{
                    UILabel *labelleft=[[UILabel alloc]initForAutoLayout];
                    labelleft.text=@"固定电话:";
                    [cell.contentView addSubview:labelleft];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeTop ];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [labelleft autoSetDimension:ALDimensionWidth toSize:100];
                    
                    UILabel *laberRight=[[UILabel alloc]initForAutoLayout];
                    if (self.telePhone.count>0) {
                        laberRight.text=self.telePhone[0];
                    }
                    [cell.contentView addSubview:laberRight];
                    laberRight.textColor=[UIColor grayColor];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeRight];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeTop];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [laberRight autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:labelleft withOffset:20];
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        case 2:{
            switch (indexPath.row) {
                case 0:{
                    UILabel *labelleft=[[UILabel alloc]initForAutoLayout];
                    labelleft.text=@"通信地址:";
                    [cell.contentView addSubview:labelleft];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeTop ];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [labelleft autoSetDimension:ALDimensionWidth toSize:100];
                    
                    UILabel *laberRight=[[UILabel alloc]initForAutoLayout];
                    laberRight.text=self.peopleInfo.address;
                    [cell.contentView addSubview:laberRight];
                    laberRight.textColor=[UIColor grayColor];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeRight];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeTop];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [laberRight autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:labelleft withOffset:20];
                    
                }
                    break;
                case 1:{
                    UILabel *labelleft=[[UILabel alloc]initForAutoLayout];
                    labelleft.text=@"集团邮箱:";
                    [cell.contentView addSubview:labelleft];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeTop ];
                    [labelleft autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [labelleft autoSetDimension:ALDimensionWidth toSize:100];
                    
                    UILabel *laberRight=[[UILabel alloc]initForAutoLayout];
                    laberRight.text=self.peopleInfo.email;
                    [cell.contentView addSubview:laberRight];
                    laberRight.textColor=[UIColor grayColor];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeRight];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeTop];
                    [laberRight autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                    [laberRight autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:labelleft withOffset:20];
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
        if (indexPath.row==0||indexPath.row==1) {
            NSArray *array=[self.telePhone arrayByAddingObjectsFromArray:self.phone];
            UIAlertController *firVC=[[UIAlertController alloc]init];
            for (NSString *string in array) {
                if (string.length>0) {
                    UIAlertAction *action=[UIAlertAction actionWithTitle:string style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [SwpTools swpToolCallPhone:string superView:self.view];
                    }];
                    [firVC addAction:action];

                }
            }
            UIAlertAction *actionCancell=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [firVC dismissViewControllerAnimated:YES completion:nil];
            }];
            [firVC addAction:actionCancell];
            [self.navigationController presentViewController:firVC animated:YES completion:nil];
        }
        
    }
}
@end
