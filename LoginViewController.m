//
//  LoginViewController.m
//  sp
//
//  Created by Apple on 15-5-11.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginApi.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if(_apiLogin == nil){
        _apiLogin = [[LoginApi alloc] initWithDefaultSettings];
    }
    
    
}


-(void)refreshSecurity
{
    [_apiLogin formhash:^(NSJSONSerialization *json){
        NSLog(@"refresh when login failed");
        
    } errorHandler:^(NSError *error){
        
    }];

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshSecurity];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"This is login ");
}

/*
#pragma notification selector
-(void)loginSuccess:(UserModel *)user
{
    NSLog(@"user = %@", user);
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *mainViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MainTabbedView"];
    
    [self showViewController:mainViewController sender:nil];
    
}
*/



#pragma custome sendor

- (IBAction)loginSubmit:(id)sender {
    
    
    [_usernameText resignFirstResponder];
    [_passwordText resignFirstResponder];
    
    
    if (_usernameText.text.length > 0 && _passwordText.text.length > 0) {

        
        
        [_apiLogin loginByUserName:_usernameText.text password:_passwordText.text completionHandler:^(NSJSONSerialization *d){
            
            NSString *string = [d valueForKey:@"message"];
            
            if(string != nil && [string isEqualToString:@"登陆成功"]){
                
                NSString *jsonData = [d valueForKeyPath:@"data.memberinfo"];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                [defaults synchronize];
                [defaults setValue:jsonData forKey:@"memberinfo"];
                [defaults synchronize];
                
                UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UITabBarController *mainViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MainTabbedView"];
                
                [self.navigationController popViewControllerAnimated:NO];
                [self showViewController:mainViewController sender:nil];
                
                
                //[self.navigationController popToRootViewControllerAnimated:YES];
                //[self.navigationController pushViewController:mainViewController animated:YES];
                //[self showViewController:mainViewController sender:nil];
                //[self dismissViewControllerAnimated:YES completion:^{

                //}];
             
            }else{
                [self refreshSecurity];
                
                if(string == nil){
                    string = @"系统错误";
                }

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
           
        } errorHandler:^(NSError *error){
            NSLog(@"error=%@",error);
        }];
        
       
        
    }
    
    
}
@end
