//
//  TDLockViewController.m
//  TDLockView
//
//  Created by 唐都 on 2017/5/23.
//  Copyright © 2017年 com.tagdu.bigtang. All rights reserved.
//

#import "TDLockViewController.h"
#import "TDLockView.h"
#import "SVProgressHUD.h";

@interface TDLockViewController ()<TDLockViewDelege>
@property (nonatomic) TDLockViewType lockType;
@property (weak, nonatomic) IBOutlet TDLockView *lockView;


@end

@implementation TDLockViewController

//获取手势密码
+ (NSString *)lockViewGetPwd
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"pwd"];
    NSLog(@"Test");
}

//初始化
- (instancetype)initWithLockViewWithType:(TDLockViewType)lockViewType{
    if (self = [super init]) {
        self.lockType = lockViewType;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.lockView.delegate = self;
    
}

- (void)setPwdDoneWithBlock:(setGesturePwdBlock)gestureDoneBlock
{
    self.setGestureBlock = gestureDoneBlock;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma -mark 绘制密码结束代理方法
- (void) gestureLockViewDrawRectFinish:(NSMutableString *)gesturePassWord{
    switch (_lockType) {
        case TDLockViewTypeCreatePwd://创建手势密码
            [SVProgressHUD showSuccessWithStatus:@"密码创建成功"];
            //存储密码
            [TDLockViewController savePwdWithString:gesturePassWord];
            
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case TDLockViewTypeValidatePwd://验证手势密码
            if ([gesturePassWord isEqualToString:[TDLockViewController lockViewGetPwd]]) {
                NSLog(@"密码正确");
                [SVProgressHUD showSuccessWithStatus:@"密码验证成功"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];

            }else
            {
                [SVProgressHUD showErrorWithStatus:@"密码验证失败"];
            }
            break;
            
        default:
            break;
    }
    
}

#pragma -mark 存储密码
+ (void)savePwdWithString:(NSString *)str{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:str forKey:@"pwd"];
    [def synchronize];
    
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
