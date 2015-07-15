//
//  LoginApi.h
//  sp
//
//  Created by Apple on 15-5-11.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "BaseApi.h"



@interface LoginApi : BaseApi


-(MKNetworkOperation *)logout:(JSONResponseBlock)completionBlock
                 errorHandler:(MKNKErrorBlock) errorBlock;


-(MKNetworkOperation *)loginByUserName:(NSString *)username
                                  password:(NSString *)password
                    completionHandler:(JSONResponseBlock) completionBlock
                          errorHandler:(MKNKErrorBlock) errorBlock;


@end
