//
//  RegisterPhoneViewController.m
//  sp
//
//  Created by Apple on 15-5-26.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "RegisterPhoneViewController.h"
#import "RegisterPhoneAuthViewController.h"

@interface RegisterPhoneViewController ()

@end

@implementation RegisterPhoneViewController


#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    RegisterPhoneAuthViewController *view = segue.destinationViewController;
    
    view.phoneNo = _phoneText.text;
    
    
}


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"phoneReadySegue"]){
        if (_phoneText.text.length < 11) {
            NSLog(@"illegal phone number");
            return NO;
        }
        
    }
    
    return YES;
}


#pragma mark - user event

- (IBAction)nextButtonSubmit:(id)sender {
    if (_phoneText.text.length < 11) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确到手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
    }
}


@end
