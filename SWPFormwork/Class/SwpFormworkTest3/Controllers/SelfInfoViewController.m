//
//  SelfInfoViewController.m
//  SwpFormwork
//
//  Created by mac on 16/9/26.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "SelfInfoViewController.h"
#import "PeopleInfo.h"
#import "VPImageCropperViewController.h"
@interface SelfInfoViewController ()<UINavigationControllerDelegate,VPImageCropperDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic)PeopleInfo     *peopleInfo;
@property (strong, nonatomic)UIImageView    *faceImage;
@property (strong, nonatomic)UITapGestureRecognizer *ges;
@property (strong, nonatomic)VPImageCropperViewController *firVC;

@end

@implementation SelfInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden=YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rdv_tabBarController.tabBarHidden=NO;
}
- (void)setUI{
    [self.view addSubview:self.faceImage];
    if (self.peopleInfo.photo.length>0) {
        NSString *urlString=[NSString stringWithFormat:@"http://address.hongdingnet.com/web/%@",self.peopleInfo.photo];
        NSURL *url=[NSURL URLWithString:urlString];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *image=[UIImage imageWithData:data];
        _faceImage.image =image;
    }
    [_faceImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [_faceImage autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_faceImage autoSetDimensionsToSize:CGSizeMake(110*BalanceWidth, 110*BalanceWidth)];
    UITableView *tableView=[[UITableView alloc]initForAutoLayout];
    
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.allowsSelection=NO;
    [self.view addSubview:tableView];
    [tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_faceImage withOffset:10];
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [tableView setScrollEnabled:NO];
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
                    laberRight.text=self.peopleInfo.userName;
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
                    NSArray *arr=[self.peopleInfo.telephone componentsSeparatedByString:@","];
                    if (arr.count>0) {
                        laberRight.text=arr[0];
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

#pragma mark ---VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage{
    [_firVC dismissViewControllerAnimated:YES completion:nil];
    [SVProgressHUD showWithStatus:@"正在上传"];
    NSData* imageData=UIImageJPEGRepresentation(editedImage, 0.3);
    NSDictionary *dic=@{
                        @"peopleId":GetUserDefault(peopleId)
                        };
    
    [SwpRequest swpPOSTAddFile:@"http://address.hongdingnet.com/web/contacts/uploadPhoto" parameters:dic isEncrypt:NO fileName:@"photo" fileData:imageData swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        self.peopleInfo.photo=[resultObject objectForKey:@"message"];
        [self setUI];
        [SVProgressHUD showSuccessWithStatus:@"上传成功"];
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController{
     [_firVC dismissViewControllerAnimated:YES completion:nil];
    return;
}
- (PeopleInfo *)peopleInfo{
    if (!_peopleInfo) {
        
        _peopleInfo=[[PeopleInfo alloc]init];
        [_peopleInfo mj_setKeyValues:GetUserDefault(myInfoDic)];
    }
    return _peopleInfo;
}

- (UIImageView *)faceImage{
    if (!_faceImage) {
        _faceImage=[[UIImageView alloc]initForAutoLayout];
        _faceImage.userInteractionEnabled=YES;
        _faceImage.layer.cornerRadius=55*BalanceWidth;
        _faceImage.clipsToBounds=YES;
        _faceImage.image=[UIImage imageNamed:@"placeholderImage"];
        [_faceImage addGestureRecognizer:self.ges];

    }
    return _faceImage;
}

- (UITapGestureRecognizer *)ges{
    if (!_ges) {
        _ges=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesAction)];
        
    }
    return _ges;
}

- (void)gesAction{

    UIAlertController *firVC=[[UIAlertController alloc]init];
    
    __weak typeof (self)weakSelf = self;
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf loadPhoto];
    }];
    UIAlertAction *takePhoto=[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf takePhoto];
    }];
    UIAlertAction *loadPhoto=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [firVC addAction:action];
    [firVC addAction:takePhoto];
    [firVC addAction:loadPhoto];
    
    [self presentViewController:firVC animated:YES completion:nil];
     
}
//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;
        
        picker.sourceType = sourceType;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
    }
    
}

//打开本地相册
-(void)loadPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{}];

}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    UIImage *image= [info objectForKey:@"UIImagePickerControllerEditedImage"];
    _firVC=[[VPImageCropperViewController alloc]initWithImage:image cropFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200) limitScaleRatio:2];
    _firVC.delegate=self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.36 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:_firVC animated:YES completion:nil];
    });
}
@end
