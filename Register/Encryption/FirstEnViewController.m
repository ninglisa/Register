//
//  FirstEnViewController.m
//  Register
//
//  Created by 宁莉莎 on 2018/1/19.
//  Copyright © 2018年 宁莉莎. All rights reserved.
//

#import "FirstEnViewController.h"

@interface FirstEnViewController ()
@property (strong, nonatomic) UIButton *backButton;
@end

@implementation FirstEnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 20)];
    self.backButton.backgroundColor = [UIColor redColor];
//    [self.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton addSubview:self.backButton];
    self.navigationController.navigationBar.hidden = YES;
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
    UIBarButtonItem *leftBarButitem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonSystemItemAction target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBarButitem;
    self.navigationItem.title = @"注册";
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
