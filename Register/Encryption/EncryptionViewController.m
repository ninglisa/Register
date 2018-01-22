//
//  EncryptionViewController.m
//  Register
//
//  Created by 宁莉莎 on 2018/1/19.
//  Copyright © 2018年 宁莉莎. All rights reserved.
//

#import "EncryptionViewController.h"
#import "FirstEnViewController.h"

@interface EncryptionViewController ()
@property (strong,nonatomic)UIButton *Image;
@end

@implementation EncryptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
    self.view.backgroundColor = [UIColor clearColor];
    self.Image = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 20)];
    self.Image.backgroundColor = [UIColor greenColor];
    [self.Image addTarget:self action:@selector(encryption) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.Image];
}

-(void)encryption
{
    FirstEnViewController *nev = [[FirstEnViewController alloc]init];
    [self.navigationController pushViewController:nev animated:YES];
    NSLog(@"加密开始");
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
