//
//  XXBComposeViewController.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-29.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBComposeViewController.h"
#import "XXBTextView.h"
#import "XXBComposeBar.h"


@interface XXBComposeViewController ()<UITextViewDelegate,XXBComposeBarDelegate>


@property (nonatomic, weak) UIBarButtonItem *right;
@property (nonatomic, weak) XXBTextView *textView;
@property (nonatomic, weak) XXBComposeBar *composeBar;

@end

@implementation XXBComposeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // 设置导航条的内容
    [self setupNavBar];
    // 添加textView
    [self setupTextView];
    //添加下边的工具条
    [self setupComposeBar];
    // UIKeyboardWillHideNotification监听键盘即将隐藏的时候
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)dealloc
{
    //把自己从通知中心移除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  设置导航条
 */
- (void)setupNavBar
{
    self.title = @"发送微博";
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancle)];
    self.navigationItem.leftBarButtonItem = left;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    // 设置正常状态下的颜色
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    _right = right;
    right.enabled = NO;
    self.navigationItem.rightBarButtonItem = right;
}

- (void)setupComposeBar
{
    CGFloat h = 44;
    CGFloat y = self.view.height - h;
    CGFloat x = 0;
    CGFloat w = self.view.width;
    XXBComposeBar *composeBar = [[XXBComposeBar alloc] initWithFrame:CGRectMake(x, y, w, h)];
    composeBar.delegate = self;
    _composeBar = composeBar;
    [self.view addSubview:composeBar];
}
- (void)cancle
{
    XXBLog(@"取消");
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    XXBLog(@"发送");
}
/**
 *  监听文字改变
 */
- (void)textViewDidChange:(UITextView *)textView
{
    _textView.hidePlaceHolder = _textView.text.length;
    _right.enabled =  _textView.text.length;
}
- (void)setupTextView
{
    XXBTextView *textView = [[XXBTextView alloc] initWithFrame:self.view.bounds];
    textView.delegate = self;
    // 设置垂直有弹性->可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.placeholder = @"分享新鲜shi....";
    [self.view addSubview:textView];
    _textView = textView;
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    // 把对象转换成CGRect结构体
    CGRect viewTransform =[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat viewY = viewTransform.origin.y - [UIScreen mainScreen].bounds.size.height; 
    CGFloat animationTime =[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //跟着键盘一块跑
    [UIView animateWithDuration:animationTime animations:^{
        [self.composeBar setTransform:CGAffineTransformMakeTranslation(0, viewY)];
    }];
}
#pragma mark - 处理工具条的点击事件
- (void)composeBar:(XXBComposeBar *)bar didClickBtn:(XXBComposeBarButtonStyle)style
{
    switch (style) {
        case XXBComposeBarButtonStylePicture:
            // 相册
        {
            // 弹出相册
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            // 设置相册的数据源
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            
            //picker.delegate = self;
            
            [self presentViewController:picker animated:YES completion:nil];
        }
            break;
        case XXBComposeBarButtonStyleEmoticon: // 表情
        {
            // 弹出表情键盘
            
        }
            break;
        default:
            break;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
