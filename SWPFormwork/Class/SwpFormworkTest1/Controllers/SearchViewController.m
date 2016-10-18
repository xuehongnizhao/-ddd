//
//  SearchViewController.m
//  SearchController
//
//  Created by mac on 16/10/8.
//  Copyright © 2016年 com.hongdingnet.www. All rights reserved.
//

#import "SearchViewController.h"
#import "NSString+Extensional.h"
#import "IQKeyboardManager.h"
#import "PeopleInfo.h"
#import "TeamInfo.h"
#import "DepartmentInfo.h"

@interface SearchViewController ()<UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UISearchController    *searchController;
@property (strong, nonatomic) NSMutableArray        *searchList;
@property (strong, nonatomic) UITableView           *tableView;
@property (strong, nonatomic) NSMutableDictionary   *dataList;//存放拼音和汉字
@property (strong, nonatomic) NSMutableArray        *teamInfo;
@property (strong, nonatomic) NSMutableArray        *allPeople;
@property (strong, nonatomic) NSMutableArray        *searchPeople;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    _searchController=[[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater=self;
    _searchController.dimsBackgroundDuringPresentation=NO;

    self.tableView.tableHeaderView=self.searchController.searchBar;
    [self.view addSubview:self.tableView];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_tableView autoPinEdgeToSuperviewEdge: ALEdgeRight];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden=YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   [[IQKeyboardManager sharedManager] setEnable:YES];
    self.rdv_tabBarController.tabBarHidden=NO;
}

- (void)setHehearray:(NSMutableArray *)hehearray{
    _hehearray=hehearray;
    _teamInfo=[NSMutableArray array];
    NSArray *dataArr=[GetUserDefault(allData) objectForKey:@"appTeamDatas"];
    for (NSDictionary *dic in dataArr) {
        TeamInfo *info=[TeamInfo mj_objectWithKeyValues:dic];
        [_teamInfo addObject:info];
    }
    self.allPeople=[[NSMutableArray alloc]init];
    for (TeamInfo *teamInfo in self.teamInfo) {
        for (DepartmentInfo *departmentInfo in teamInfo.appGroupDataList) {
            for (PeopleInfo *peopleInfo in departmentInfo.appPeopleDatas) {
                [_allPeople addObject:peopleInfo];
            }
        }
    }
    self.searchPeople=[NSMutableArray arrayWithArray:self.allPeople];
    _dataList=[NSMutableDictionary dictionary];
    for (NSString *hanzi in _hehearray) {
        NSString *pinyin=[hanzi firstLettersForSort:YES];
        pinyin =[pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
        [_dataList setObject:hanzi forKey:pinyin];
    }
    
}
#pragma mark --- tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active) {
        return [self.searchList count];
    }
    return self.hehearray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    while ([cell.contentView.subviews lastObject]!= nil) {
        [[cell.contentView.subviews lastObject]removeFromSuperview];
    }
    PeopleInfo *peopleInfo=_searchPeople[indexPath.row];
    
    UIImageView *imagv=[[UIImageView alloc]initForAutoLayout];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://address.hongdingnet.com/web/%@",peopleInfo.photo]];
    [imagv sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"team_6"]];
    [cell.contentView addSubview:imagv];
    [imagv autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [imagv autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [imagv autoSetDimensionsToSize:CGSizeMake(60, 60)];
    
    
    UILabel *name=[[UILabel alloc]initForAutoLayout];
    name.font=[UIFont systemFontOfSize:18];
    name.textColor=[UIColor orangeColor];
    name.text=peopleInfo.peopleName;
    [cell.contentView addSubview:name];
    [name autoPinEdgeToSuperviewEdge: ALEdgeTop withInset:10];
    [name autoSetDimensionsToSize:CGSizeMake(70, 20)];
    [name autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imagv withOffset:5];
    
    UILabel *tel=[[UILabel alloc]initForAutoLayout];
    tel.font=[UIFont systemFontOfSize:15];
    NSArray *array=[peopleInfo.phone componentsSeparatedByString:@","];
    tel.text=array[0];
    [cell.contentView addSubview:tel];
    [tel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imagv withOffset:5];
    [tel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:name];
    [tel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [tel autoPinEdgeToSuperviewEdge:ALEdgeRight];

    UILabel *position=[[UILabel alloc]initForAutoLayout];
    position.font=[UIFont systemFontOfSize:14];
    position.text=peopleInfo.position;
    [cell.contentView addSubview:position];
    [position autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [position autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:name withOffset:5];
    [position autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:tel];
    [position autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    UIImageView *callImage=[[UIImageView alloc]initForAutoLayout];
    callImage.image=[UIImage imageNamed:@"callPhone"];
    [cell.contentView addSubview:callImage];
    [callImage autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    [callImage autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [callImage autoSetDimensionsToSize:CGSizeMake(20, 20)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PeopleInfo *info=[_searchPeople objectAtIndex:indexPath.row];
    NSArray *telePhone=[info.telephone componentsSeparatedByString:@","];
    NSArray *phone=[info.phone componentsSeparatedByString:@","];
    NSArray *array=[telePhone arrayByAddingObjectsFromArray:phone];
    UIAlertController *firVC=[[UIAlertController alloc]init];
     __weak typeof (self)weakSelf=self;
    for (NSString *string in array) {
        if (string.length>0) {
            UIAlertAction *action=[UIAlertAction actionWithTitle:string style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [SwpTools swpToolCallPhone:string superView:weakSelf.view];
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
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString=self.searchController.searchBar.text;
    if (searchString.length==0) {
         self.searchPeople=[NSMutableArray arrayWithArray:self.allPeople];
        self.searchList=[NSMutableArray arrayWithArray:self.hehearray];
        [self.tableView reloadData];
        return;
    }
    if ([self IsChinese:searchString]) {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchString];
        [self.searchList removeAllObjects];
        [self.searchPeople removeAllObjects];
        self.searchList=[NSMutableArray arrayWithArray:self.hehearray];
        [self.searchList filterUsingPredicate:predicate];
        
        for (PeopleInfo *info in self.allPeople) {
            for (NSString *string in self.searchList) {
                if ([string rangeOfString:info.peopleName].location!=NSNotFound) {
                    [self.searchPeople addObject:info];
                    
                }
            }
        }

        if (searchString.length==0) {
            self.searchList=[NSMutableArray arrayWithArray:self.hehearray];
            self.searchPeople=[NSMutableArray arrayWithArray:self.allPeople];
        }
        [self.tableView reloadData];
    }else{
        [self.searchPeople removeAllObjects];
        [self.searchList removeAllObjects];
        for (NSString *string in [self.dataList allKeys]) {
            if ([[string uppercaseString] containsString:searchString]||[string containsString:searchString]) {
                [self.searchList addObject:[self.dataList objectForKey:string]];
            }
        }
        for (PeopleInfo *info in self.allPeople) {
            for (NSString *string in self.searchList) {
                if  ([string rangeOfString:info.peopleName].location!=NSNotFound) {
                    [self.searchPeople addObject:info];
                }
            }
        }
        [self.tableView reloadData];
    }

}

-(BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        
        int a = [str characterAtIndex:i];
        
        if( a > 0x4e00 && a < 0x9fff){
        
        return YES;
        }
    } return NO;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initForAutoLayout];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
    }
    return _tableView;
}

@end
