//
//  ViewController.m
//  Register
//
//  Created by 宁莉莎 on 2018/1/12.
//  Copyright © 2018年 宁莉莎. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "HomeTabViewController.h"
#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"
#import "RegisterViewController.h"


@interface ViewController ()
    @property (strong, nonatomic) IBOutlet UITextField *username;
    @property (strong, nonatomic) IBOutlet UITextField *password;
    
    @property (strong, nonatomic) IBOutlet UIButton *LoginBtn;
    @property (strong, nonatomic) IBOutlet UIButton *ForgetBtn;
    @property (strong, nonatomic) IBOutlet UIButton *RegisterBtn;
    @property (strong, nonatomic) IBOutlet UIView *containview;
    
    
    @end

@implementation ViewController
    
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.username = [[UITextField alloc]initWithFrame:CGRectMake(20, 80, 140, 20)];
    self.username.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号"];
    self.username.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.username];
    self.password = [[UITextField alloc]initWithFrame:CGRectMake(20, 110, 140, 20)];
    self.password.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码"];
    self.password.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.password];
    self.LoginBtn =[[UIButton alloc]initWithFrame:CGRectMake(20, 140, 80, 20)];
    self.LoginBtn.backgroundColor = [UIColor redColor];
    [self.LoginBtn addTarget:self action:@selector(clickMe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.LoginBtn];
    self.RegisterBtn =[[UIButton alloc]initWithFrame:CGRectMake(20, 180, 80, 20)];
    self.RegisterBtn.backgroundColor =[UIColor redColor];
    [self.RegisterBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.RegisterBtn];
    // Do any additional setup after loading the view, typically from a nib.
}
    
-(void)clickMe{
    NSLog(@"touch down");
    //    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //    appdelegate.window.rootViewController = homeController;
    NSString *userName = self.username.text;
    NSString *passWord = self.password.text;
    if([userName isEqualToString:@""]||[passWord isEqualToString:@""])
    {
        NSLog(@"用户名或密码为空");
    }else if([userName length] != 11)
    {
        NSLog(@"请输入正确的手机号");
    }else{
    NSUserDefaults *userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userName forKey:@"username"];
    [userDefaults setObject:passWord forKey:@"password"];
    [userDefaults synchronize];
    NSDictionary *parameters = @{@"emp_phone":userName,
                                 @"emp_password":passWord
                                 };
    NSString *urlString = @"http://119.23.162.138/cloud/Login/Employee.do";
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //进行POST请求
    [managers GET:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"请求成功，服务器返回的信息%@",responseObject);
        NSString *status = [responseObject valueForKey:@"status"];
        NSString *content =[responseObject valueForKey:@"content"];
        if([status isEqualToString:@"Fail"])
            {
            NSLog(@"服务器内部错误");
            }else if([content isEqualToString:@"phonenull"])
                {
                NSLog(@"电话号码不存在");
                }else if([content isEqualToString:@"passworderror"])
                    {
                    NSLog(@"密码错误");
                    }else
                        {
                        NSLog(@"成功登陆");
                        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                        HomeTabViewController *homeController = [story instantiateViewControllerWithIdentifier:@"HomeTab"];
                        [self presentViewController:homeController animated:YES completion:nil];
                        }
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        NSLog(@"请求失败,服务器返回的信息%@",error);
    }];}
}

-(void)regist
{
    NSLog(@"注册页面");
    RegisterViewController *rec = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:rec animated:YES];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
