//
//  LoginApi.h
//  sp
//
//  Created by Apple on 15-5-11.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "BaseApi.h"

//#define kNotificationLoginSuccess @"kNotificationLoginSuccess"
//#define kNotificationLoginFailed  @"kNotificationLoginFailed"



@interface LoginApi : BaseApi

typedef void (^LoginResponseBlock)(NSJSONSerialization *data);
typedef void (^LogoutResponeBlock)(NSJSONSerialization *data);



@property (strong,nonatomic) NSString *formhash;

/*
@property (strong,nonatomic) NSString *seccodemodid;
@property (strong,nonatomic) NSString *seccodehash;
@property (strong,nonatomic) NSString *seccodeverify;
*/




-(MKNetworkOperation *)formhash:(JSONResponseBlock)completionBlock
                 errorHandler:(MKNKErrorBlock) errorBlock;


-(MKNetworkOperation *)logout:(LogoutResponeBlock)completionBlock
                 errorHandler:(MKNKErrorBlock) errorBlock;


-(MKNetworkOperation *)loginByUserName:(NSString *)username
                                  password:(NSString *)password
                    completionHandler:(LoginResponseBlock) completionBlock
                          errorHandler:(MKNKErrorBlock) errorBlock;


@end
