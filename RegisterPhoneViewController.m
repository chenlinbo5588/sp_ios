//
//  RegisterPhoneViewController.m
//  sp
//
//  Created by Apple on 15-5-26.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "RegisterPhoneViewController.h"
#import "RegisterPhoneAuthViewController.h"
#import "LoginViewController.h"


@interface RegisterPhoneViewController ()

@property (nonatomic,assign) BOOL canGoNext;


@end

@implementation RegisterPhoneViewController


#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(gobackLogin)];
    
    if (_registerApi == nil){
        _registerApi = [[RegisterApi alloc] initWithDefaultSettings];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [_phoneText becomeFirstResponder];

    
    [_registerApi step_phone:nil completionHandler:^(NSJSONSerialization *json){
        
    } errorHandler:^(NSError *error){
        NSLog(@"%@",error);
        
    }];
    
}


#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"phoneReadySegue"]){
        return NO;
        
    }
    
    return YES;
}


#pragma mark - user event

-(void)gobackLogin
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
        LoginViewController *view = [story instantiateViewControllerWithIdentifier:@"LoginViewScene"];
        
        [self showViewController:view sender:nil];
    }];
    
}

- (IBAction)nextButtonSubmit:(id)sender {
    
    NSString *message ;
    
    
    if (_phoneText.text.length < 11) {
        message = @"请输入正确到手机号码";
        _canGoNext = NO;
    }else{
        message = [NSString stringWithFormat:@"请确认号码 %@",_phoneText.text];
        _canGoNext = YES;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}

#pragma mark - action sheet

-(void)alertViewCancel:(UIAlertView *)alertView
{
    /*
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
    RegisterPhoneAuthViewController *view = [story instantiateViewControllerWithIdentifier:@"RegStep2"];
    view.phoneNo = _phoneText.text;
     */
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex=%d",buttonIndex);
    
    if(buttonIndex == 1 && _canGoNext){

        [_registerApi step_phone:_phoneText.text completionHandler:^(NSJSONSerialization *json){
            
            NSString *message = [json valueForKey:@"message"];
            
            if([message isEqualToString:@"成功"]){
                
                //UIStoryboardSegue *segue = [UIStoryboardSegue alloc] initWithIdentifier:(NSString *) source:<#(UIViewController *)#> destination:<#(UIViewController *)#>
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
                RegisterPhoneAuthViewController *view = [story instantiateViewControllerWithIdentifier:@"RegStep2"];
                view.phoneNo = _phoneText.text;
                view.registerApi = _registerApi;
                
                [self.navigationController pushViewController:view animated:YES];
            }else{
                
                _feedbackLabel.text = [json valueForKey:@"message"];
                _feedbackLabel.hidden = NO;

            }
            
        } errorHandler:^(NSError *error){
            NSLog(@"error=%@",error);
            
        }];
        
    }
    
}



@end
