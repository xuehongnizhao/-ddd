//
//  SearchViewController.m
//  SearchController
//
//  Created by mac on 16/10/8.
//  Copyright © 2016年 com.hongdingnet.www. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *hehearray;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSMutableArray *searchList;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i=0; i<50; i++) {
        [self.hehearray addObject:[NSString stringWithFormat:@"呵呵%d",i]];
    }
    
    _searchController=[[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater=self;
//    _searchController.dimsBackgroundDuringPresentation=NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView=self.searchController.searchBar;
    [self.view addSubview:self.tableView];
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
    if (self.searchController.active) {
        cell.textLabel.text=self.searchList[indexPath.row];
    }else{
        cell.textLabel.text=[self.hehearray objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString=self.searchController.searchBar.text;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchString];
    [self.searchList removeAllObjects];
    self.searchList=[NSMutableArray arrayWithArray:self.hehearray];
    [self.searchList filterUsingPredicate:predicate];
    if (searchString.length==0) {
        return;
    }
    [self.tableView reloadData];
}
- (NSMutableArray *)hehearray{
    if (!_hehearray) {
        _hehearray=[NSMutableArray array];
    }
    return _hehearray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
    }
    return _tableView;
}
@end
