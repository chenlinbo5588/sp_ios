//
//  RegisterPhoneAuthViewController.m
//  sp
//
//  Created by Apple on 15-5-26.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "RegisterPhoneAuthViewController.h"
#import "MBProgressHUD.h"

@interface RegisterPhoneAuthViewController ()


@property (nonatomic,strong) NSTimer *authCodeTimer;
@property (nonatomic,assign) NSInteger secondsLeft;

@end

@implementation RegisterPhoneAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"phoneNo=%@",_phoneNo);

    
    NSRange rage1 = NSMakeRange(0,3);
    NSRange rage2 = NSMakeRange(3,4);
    NSRange rage3 = NSMakeRange(7,4);
    
    _phoneLabel.text =[NSString stringWithFormat:@"%@-%@-%@",
                       [_phoneNo substringWithRange:rage1],
                       [_phoneNo substringWithRange:rage2],
                       [_phoneNo substringWithRange:rage3]
                       ]  ;
    
    _resendBarItem.enabled = false;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    if(!_authCodeTimer){
        _secondsLeft = 60;
        _authCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTimeLabel) userInfo:nil repeats:YES];
        
    }else{
        if (![_authCodeTimer isValid]) {
            _secondsLeft = 60;
            _resendBarItem.enabled = false;
            
            [_authCodeTimer fire];
        }
    }
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    _authCodeTimer = nil;
    _registerApi = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







#pragma mark - Navigation

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"authCodeSegue"]){
        return NO;
        
    }
    
    return YES;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark -- custom event

-(void)changeTimeLabel
{
    if(_secondsLeft <= 0){
        _counterLabel.text = @"没有收到信息,请点击右上角重发";
        _resendBarItem.enabled = true;
        [_authCodeTimer invalidate];
        return;
    }
    
    _secondsLeft--;
    _counterLabel.text = [NSString stringWithFormat:@"您将在%d秒内收到验证码",_secondsLeft ];
}


- (IBAction)phoneAuthNextSubmit:(id)sender {

    [_authCodeText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(_authCodeText.text.length != 6){
        
        //[_registerApi s]
        
    }
    
    
}

- (IBAction)resendAuthCode:(id)sender {
    
    
    _resendBarItem.enabled = false;
    _secondsLeft = 60;
    
    _authCodeTimer = nil;
    _authCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTimeLabel) userInfo:nil repeats:YES];
    
    [_registerApi step_phone:_phoneNo completionHandler:^(NSJSONSerialization *json){
        NSLog(@"resend authcode");
        
    } errorHandler:^(NSError *error){
        NSLog(@"%@",error);
        
    }];
    
    
}
@end
