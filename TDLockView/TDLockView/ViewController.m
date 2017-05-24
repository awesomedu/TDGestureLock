//
//  ViewController.m
//  TDLockView
//
//  Created by 唐都 on 2017/5/23.
//  Copyright © 2017年 com.tagdu.bigtang. All rights reserved.
//

#import "ViewController.h"
#import "TDLockViewController.h"

@interface ViewController ()<UIActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self createActionSheet];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)createActionSheet
{
    self.title = @"TDLockView";
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"设置手势密码" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"创建手势密码" otherButtonTitles:@"验证手势密码", nil];
    //actionSheet样式
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    //显示
    [sheet showInView:self.view];
    sheet.delegate = self;
    
}

#pragma -mark actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3) __TVOS_PROHIBITED{
    NSLog(@"点击的index == %ld",buttonIndex);
    if(buttonIndex == 0){//创建手势密码
        TDLockViewController *lockVc = [[TDLockViewController alloc] initWithLockViewWithType:TDLockViewTypeCreatePwd];
        [self.navigationController pushViewController:lockVc animated:NO];
        
    }else if(buttonIndex == 1)//验证手势密码
    {
        TDLockViewController *lockVc = [[TDLockViewController alloc] initWithLockViewWithType:TDLockViewTypeValidatePwd];
        [self.navigationController pushViewController:lockVc animated:NO];
        
    }
    
    
}



- (void)btnClick
{
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
