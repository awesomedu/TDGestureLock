//
//  TDLockView.h
//  TDLockView
//
//  Created by 唐都 on 2017/5/23.
//  Copyright © 2017年 com.tagdu.bigtang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^setGesturePwdBlock)(NSString *pwdStr);
@protocol TDLockViewDelege <NSObject>
@required
- (void) gestureLockViewDrawRectFinish:(NSMutableString *)gesturePassWord;

@end

@interface TDLockView : UIView

@property (nonatomic, copy) setGesturePwdBlock setGestureDoneBlock;
//代理
@property (nonatomic, assign) id<TDLockViewDelege>delegate;



@end
