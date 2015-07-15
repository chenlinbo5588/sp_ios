//
//  LoginApi.m
//  sp
//
//  Created by Apple on 15-5-11.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "LoginApi.h"

@implementation LoginApi

-(MKNetworkOperation *)logout:(JSONResponseBlock)completionBlock
                         errorHandler:(MKNKErrorBlock)errorBlock
{

    return [self apiRequest:@"/index.php/member/logout" postdata:nil completionHandler:^(NSJSONSerialization *json) {
        completionBlock(json);
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
    
    
}



-(MKNetworkOperation *)loginByUserName:(NSString *)username
                                  password:(NSString *)password
                     completionHandler:(JSONResponseBlock)completionBlock
                          errorHandler:(MKNKErrorBlock)errorBlock
{

    NSDictionary *param = [[NSDictionary alloc] initWithObjects:@[username,password ]
                                                        forKeys:@[@"username", @"password"]];
    
    
    return [self apiRequest:@"/index.php/member/login" postdata:param completionHandler:^(NSJSONSerialization *json) {
        completionBlock(json);
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
    
}



@end
