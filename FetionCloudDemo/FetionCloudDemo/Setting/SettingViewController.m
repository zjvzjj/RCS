//
//  SettingViewController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/16.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "SettingViewController.h"
#import "FNUserConfig.h"
#import "FNAccountLogic.h"
#import "FNMsgNotify.h"
#import "FNGroupMsgNotify.h"
#import "FNGroupNotify.h"
#import "CurrentUserTable.h"

#import "ZLPhotoAssets.h"
#import "ZLPhotoPickerViewController.h"
#import "AppDelegate.h"
#import "FNImage.h"

#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

#import "FNUserInfo.h"


#define     PATH_DOCUMENT                   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define     PATH_CHATREC_IMAGE              [PATH_DOCUMENT stringByAppendingPathComponent:@"ChatRec/Images"]



@interface SettingViewController ()<ZLPhotoPickerViewControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *nickNameText;//昵称


@property (weak, nonatomic) IBOutlet UITextField *impresaText;//个人签名



@property (nonatomic) NSString* picturePath;//头像路径
@property (nonatomic,copy) NSString *imageName;//头像图片名称


@property (weak, nonatomic) IBOutlet UIButton *portraitBtn;//头像

@property (weak, nonatomic) IBOutlet UITextField *genderText;//性别

@property (weak, nonatomic) IBOutlet UITextField *firstNameText;//姓

@property (weak, nonatomic) IBOutlet UITextField *lastNameText;//名


@property (weak, nonatomic) IBOutlet UITextField *birthdayText;//生日

@property (weak, nonatomic) IBOutlet UITextField *emailText;//邮箱

@property (nonatomic) UIImage *portraitImage;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.nameLabel.text = [[CurrentUserTable getLastUser] nickName];
//    self.impresaText.text = [[CurrentUserTable getLastUser] account];
    
//    self.nameLabel.text = @"Jack";
//    self.impresaText.text = @"hello hello";
//    _impresaLab.text = @"个人签名";
    
    [self baseConfriguration];
    
    
}

- (void)baseConfriguration{

    _nickNameText.delegate = self;
    _impresaText.delegate = self;
    _genderText.delegate =self;
    _firstNameText.delegate = self;
    _lastNameText.delegate = self;
    _birthdayText.delegate = self;
    _emailText.delegate = self;
}


//设置用户基本信息
- (IBAction)saveProfile:(id)sender {
    
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"name"];
    
    [globalRcsApi logout:R callback:^(rcs_state *R, LogoutResult *s) {
        
        CurrentUserTable *table = [CurrentUserTable getWithUserId:[[FNUserConfig getInstance] userID]];
        table.password = @"";
        [CurrentUserTable update:table];
        dispatch_async(dispatch_get_main_queue(),^{
    
            [UIApplication sharedApplication].keyWindow.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
      });
    
    }];
    
    //    [globalRcsApi usersetprofile:R nickname:@"Jack" impresa:_impresaText.text firstname:_firstNameText.text lastname:_lastNameText.text gender:2 email:_emailText.text birthday:_birthdayText.text callback:^(rcs_state* R, UserProfileResult *s) {
//        if(s->error_code == 200)
//        {
//            //[self AddLogC:"user set profile ok"];
//            NSLog(@"user set profile ok");
//            
//            dispatch_async(dispatch_get_main_queue(),^{
//                
//                [[[UIAlertView alloc] initWithTitle:@"" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//
//            });
//            
//        }else
//        {
//            [[[UIAlertView alloc] initWithTitle:@"" message:@"保存失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//            
//        }
//    }];
    
}

//设置用户头像
- (void)userSetPortrait{
    
    [globalRcsApi usersetportrait:R filePath:_picturePath callback:^(rcs_state* R, UserPortraitResult *s) {
        if(s->error_code == 200)
        {
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                [[[UIAlertView alloc] initWithTitle:@"" message:@"设置成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
            });
            
        }else
        {
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                [[[UIAlertView alloc] initWithTitle:@"" message:@"设置失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
            });
            
        }
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击头像按钮
- (IBAction)portraitBtnAction:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                    delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"拍照", @"从相册上传", nil];
    [actionSheet showInView:self.view];
    
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (0 == buttonIndex) {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
        
        
    } else if (1 == buttonIndex){
       [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
         //[self showPhoto];
    }
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle   = UIModalPresentationCurrentContext;
    imagePickerController.sourceType               = sourceType;
    imagePickerController.allowsEditing            = YES;
    imagePickerController.delegate                 = self;
    
    self.tabBarController.tabBar.hidden= YES;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


#pragma mark - ImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.tabBarController.tabBar.hidden= NO;
    
     //获取正在编辑的图片
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    
    NSURL *imageUrl = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    //获取图片的名字信息
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        _imageName = [representation filename];
        NSLog(@"%@",_imageName);
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:imageUrl
                   resultBlock:resultblock
                  failureBlock:nil];
    
    //将获取的图片设置为头像
     [self.portraitBtn setBackgroundImage:image forState:UIControlStateNormal];

/*
    //保存图片 方法1
//    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//    NSUserDomainMask, YES);
//    NSString*documentsDirectory=[paths objectAtIndex:0];
//    NSString*aPath=[documentsDirectory
//stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",@"test"]];
    
    //方法2
    //NSHomeDirectory(),方法是获取沙盒根路径,test是自定义图片名,可用上述方法中获取的名字替换
    NSString *bPath=[NSString stringWithFormat:
                     @"%@/Documents/%@.jpg",NSHomeDirectory(),@"test"];
    //image是对应的图片,即图片通过UIPickerController获取系统相册图
    NSData *imgData = UIImageJPEGRepresentation(image,0);
    //保存到当地文件中
    [imgData writeToFile:bPath atomically:YES];
*/
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    //获取图片的类型前的名字,将字符串切割操作
    NSString *imagePath = [[_imageName componentsSeparatedByString:@"."]
                               firstObject];
        
    _picturePath=[NSString stringWithFormat:@"%@/Documents/%@.jpg",
                         NSHomeDirectory(),imagePath];
        
    NSData *imgData = UIImageJPEGRepresentation(image,0);
        
    [imgData writeToFile:_picturePath atomically:YES];
        
    NSLog(@"%@",_picturePath);
        
    [self userSetPortrait];
        
//        NSData *retrievedData = [NSData dataWithContentsOfFile:_picturePath];
//        
//        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_picturePath]];
//        
//        NSLog(@"%@",data);
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.tabBarController.tabBar.hidden= NO;
    
}

#pragma mark - TextfieldDelegate

//点击空白处回收键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_nickNameText resignFirstResponder];
    [_impresaText resignFirstResponder];
    [_genderText resignFirstResponder];
    [_firstNameText resignFirstResponder];
    [_lastNameText resignFirstResponder];
    [_birthdayText resignFirstResponder];
    [_emailText resignFirstResponder];
}

//注销登录
- (IBAction)logout:(id)sender
{
    [FNAccountLogic logout:^(FNLogoutResponse *rspArgs) {
        NSLog(@"logout rsp: %d", rspArgs.statusCode);
        
        CurrentUserTable *table = [CurrentUserTable getWithUserId:[[FNUserConfig getInstance] userID]];
//        [CurrentUserTable del:table];
        table.password = @"";
        [CurrentUserTable update:table];
        
    }];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"name"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"bopToken"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"bopId"];
    
    
    
    [globalRcsApi logout:R callback:^(rcs_state *R, LogoutResult *s) {
        if (s->error_code == 200) {
            
            
            CurrentUserTable *table = [CurrentUserTable getWithUserId:[[FNUserConfig getInstance] userID]];
            //        [CurrentUserTable del:table];
            table.password = @"";
            [CurrentUserTable update:table];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"name"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                //[[[UIAlertView alloc] initWithTitle:@"" message:@"注销成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                [UIApplication sharedApplication].keyWindow.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                [[[UIAlertView alloc] initWithTitle:@"" message:@"注销成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
            });
        }
    }];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
