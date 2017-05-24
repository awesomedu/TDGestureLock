//
//  TDLockViewController.h
//  TDLockView
//
//  Created by 唐都 on 2017/5/23.
//  Copyright © 2017年 com.tagdu.bigtang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,TDLockViewType){
    TDLockViewTypeCreatePwd,
    TDLockViewTypeValidatePwd
};



//密码输入完成的block
typedef void(^setGesturePwdBlock)(NSString *pwdStr);

@interface TDLockViewController : UIViewController
//密码设置完成
- (void)setPwdDoneWithBlock:(setGesturePwdBlock)gestureDoneBlock;
@property (nonatomic, copy) setGesturePwdBlock setGestureBlock;

//初始化
- (instancetype)initWithLockViewWithType:(TDLockViewType)lockViewType;
//获取手势密码
+ (NSString *)lockViewGetPwd;





@end
