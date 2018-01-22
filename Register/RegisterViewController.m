//
//  RegisterViewController.m
//  Register
//
//  Created by 宁莉莎 on 2018/1/15.
//  Copyright © 2018年 宁莉莎. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"


@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet UIButton *RegisterBtn;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property(strong,nonatomic) IBOutlet UITextField *password;
@property (strong,nonatomic) IBOutlet UITextField *Judgenum;
@property (strong,nonatomic)IBOutlet UIButton *Success;
@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.RegisterBtn =[[UIButton alloc]initWithFrame:CGRectMake(20, 180, 180, 20)];
    self.RegisterBtn.backgroundColor =[UIColor redColor];
    [self.RegisterBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.RegisterBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.RegisterBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:self.RegisterBtn];
    UIBarButtonItem *leftBarButitem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonSystemItemAction target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBarButitem;
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    self.username = [[UITextField alloc]initWithFrame:CGRectMake(20, 80, 140, 20)];
    self.username.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号"];
    self.username.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.username];
    self.password = [[UITextField alloc]initWithFrame:CGRectMake(20, 110, 140, 20)];
    self.password.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码"];
    self.password.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.password];
    self.Judgenum = [[UITextField alloc]initWithFrame:CGRectMake(20, 140, 100, 20)];
    self.Judgenum.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.Judgenum];
    self.Success = [[UIButton alloc]initWithFrame:CGRectMake(20, 210, 100, 20)];
    self.Success.backgroundColor = [UIColor redColor];
    [self.Success addTarget:self action:@selector(success) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.Success];
   
}
    
-(void)btnClick
    {
        NSString *username = self.username.text;
        if([username length]!=11)
        {
            NSLog(@"请重新输入手机号");
        }else
            {
            NSString *username = self.username.text;
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSString *url =@"http://119.23.162.138/cloud/AcquireCode.do";
            NSDictionary *parameter = @{@"emp_phone":username};
            [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"已经运行了该");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self BtnTime];
                NSLog(@"%@",responseObject);
                NSString *status = [responseObject valueForKey:@"status"];
                NSString *content =[responseObject valueForKey:@"content"];
                if([status isEqualToString:@"Fail"])
                    {
                    NSLog(@"服务器响应失败");
                    }else if([content isEqualToString:@"sendcode success"])
                        {
                        NSLog(@"验证码发送成功");
                        
                        }else if([content isEqualToString:@"sendcode fail"])
                            {
                            NSLog(@"验证码发送失败");
                            }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"请求失败,服务器返回的信息%@",error);
                
            }];
       }
    }

-(void)Judge
{
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    NSString *Judge = self.Judgenum.text;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url =@"http://119.23.162.138/cloud/Register/Employee.do";
    NSDictionary *parameter = @{
                                @"emp_phone":username,
                                @"emp_password":password,
                                @"code":Judge
                                };
    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"向服务器请求验证");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = [responseObject valueForKey:status];
        NSString *content = [responseObject valueForKey:content];
        if([status isEqualToString:@"Fail"])
            {
            NSLog(@"服务器响应失败");
            }else if([content isEqualToString:@"code error"])
                {
                NSLog(@"验证码错误");
                }else if([content isEqualToString:@"code invalid"])
                    {
                    NSLog(@"验证码失效");
                    }else {
                        NSLog(@"验证成功");
                        NSLog(@"content = %@",content);
                        [self back];
                    }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           NSLog(@"请求失败,服务器返回的信息%@",error);
    }];
}

-(void)success
{
    [self Judge];
}
-(void)BtnTime
{
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.RegisterBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.RegisterBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
                self.RegisterBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.RegisterBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.RegisterBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                self.RegisterBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}



-(void)back
    {
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"返回");
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
