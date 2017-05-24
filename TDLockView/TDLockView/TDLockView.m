//
//  TDLockView.m
//  TDLockView
//
//  Created by 唐都 on 2017/5/23.
//  Copyright © 2017年 com.tagdu.bigtang. All rights reserved.
//

#import "TDLockView.h"
#import "SVProgressHUD.h"
/*  定义按钮*/
CGFloat const btnCount = 9;
CGFloat const btnW = 74;
CGFloat const btnH = 74;
CGFloat const viewY = 300;
int const columnCount = 3;
#define TDScreenWidth [UIScreen mainScreen].bounds.size.width
@class TDLockViewController;


@interface TDLockView ()
@property (nonatomic, strong) NSMutableArray *selectedBtnArrays;
//当前连接的点
@property (nonatomic, assign) CGPoint currentPoint;



@end

@implementation TDLockView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

/*  代码加载*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addButton];
        
    }
    return self;
}

/*  xib Or storyBoard加载*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        [self addButton];
    }
    return self;
}

#pragma -mark 懒加载
- (NSMutableArray *)selectedBtnArrays
{
    if (!_selectedBtnArrays) {
        _selectedBtnArrays = [NSMutableArray array];
    }
    return _selectedBtnArrays;
}


/*  添加按钮*/
- (void)addButton
{
    CGFloat height = 0;
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置默认图片
        [btn setBackgroundImage:[UIImage imageNamed:@"normal"] forState:UIControlStateNormal];
        //设置选中的图片
        [btn setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        //禁用btn自带点击效果
        btn.userInteractionEnabled = NO;
        //设置tag
        btn.tag = i;
        NSLog(@"button 的 tag == %ld",btn.tag);
        int row = i / columnCount;//第几行
        int column  = i % columnCount;//第几列
        //边距
        CGFloat margin = (self.frame.size.width - columnCount * btnW) / (columnCount +1);
        //x
        CGFloat btnX = margin + column * (btnW + margin);
        //y
        CGFloat btnY = row *(btnW +margin);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        height = btnH + btnY;
        [self addSubview:btn];
        
    }
    self.frame = CGRectMake(0, viewY, TDScreenWidth, height);
}


#pragma -mark
//获取触摸的点
- (CGPoint)pointWithTouch:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    return point;
    
}

//获取button
- (UIButton *)buttonWithPoint:(CGPoint)point{
    //根据触摸的点拿到but
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }return nil;
    
    
}

#pragma -mark 给按钮添加手势
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //拿到触摸的点
    CGPoint point = [self pointWithTouch:touches];
    //根据触摸的点拿到but
    UIButton *btn  = [self buttonWithPoint:point];
    //设置状态
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        //添加按钮进按钮数组
        [self.selectedBtnArrays addObject:btn];
    }
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //拿到触摸的点
    CGPoint point = [self pointWithTouch:touches];
    //根据触摸的点拿到but
    UIButton *btn  = [self buttonWithPoint:point];
    //设置状态
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectedBtnArrays addObject:btn];
    }else
    {
        self.currentPoint = point;
    }
    [self setNeedsDisplay];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSMutableString *finalPwdStr = [NSMutableString string];
    for (UIButton *button in self.selectedBtnArrays) {
        //存储密码,拿到button 的tag 值，拼接存储
        [finalPwdStr appendFormat:@"%ld",button.tag];
        button.selected = NO;
    }
    NSLog(@"存储的密码是%@",finalPwdStr);
 
    [self.selectedBtnArrays removeAllObjects];
    [self setNeedsDisplay];
    //代理响应
    if (self.delegate && [self.delegate respondsToSelector:@selector(gestureLockViewDrawRectFinish:)]) {
        [self.delegate gestureLockViewDrawRectFinish:finalPwdStr];
    }
}






- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

#pragma -mark 绘图
- (void)drawRect:(CGRect)rect
{
    if (self.selectedBtnArrays.count == 0) {
        return;
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinRound;
    [[UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.5] set];
    //遍历按钮
    for (int i = 0; i<self.selectedBtnArrays.count; i++) {
        UIButton *btn = self.selectedBtnArrays[i];
        if (i ==0) {//起点
            [path moveToPoint:btn.center];
        }else//连线
        {
            [path addLineToPoint:btn.center];
        }
    }
    [path addLineToPoint:self.currentPoint];
    [path stroke];
    
    
    
}




@end
