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
@interface SearchViewController ()<UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSMutableArray *searchList;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *dataList;//存放拼音和汉字

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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
       [[IQKeyboardManager sharedManager] setEnable:YES];
}
- (void)setHehearray:(NSMutableArray *)hehearray{
    _hehearray=hehearray;
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (self.searchController.active && self.searchList.count>0) {
        NSString *string=self.searchList[indexPath.row];
        NSArray *array=[string componentsSeparatedByString:@","];
        cell.textLabel.text=[NSString stringWithFormat:@"%@ %@",array[0],array[1]];
        
    }else{
        NSString *string=self.hehearray[indexPath.row];
        NSArray *array=[string componentsSeparatedByString:@","];
        cell.textLabel.text=[NSString stringWithFormat:@"%@ %@",array[0],array[1]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString=self.searchController.searchBar.text;
    if (searchString.length==0) {
        self.searchList=[NSMutableArray arrayWithArray:self.hehearray];
        [self.tableView reloadData];
        return;
    }
    if ([self IsChinese:searchString]) {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchString];
        [self.searchList removeAllObjects];
        self.searchList=[NSMutableArray arrayWithArray:self.hehearray];
        [self.searchList filterUsingPredicate:predicate];
        if (searchString.length==0) {
            self.searchList=[NSMutableArray arrayWithArray:self.hehearray];
        }
        [self.tableView reloadData];
    }else{
        [self.searchList removeAllObjects];
        for (NSString *string in [self.dataList allKeys]) {
            if ([[string uppercaseString] containsString:searchString]||[string containsString:searchString]) {
                [self.searchList addObject:[self.dataList objectForKey:string]];
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
