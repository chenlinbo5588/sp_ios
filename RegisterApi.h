//
//  RegisterApi.h
//  sp
//
//  Created by Apple on 15-5-27.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "BaseApi.h"

@interface RegisterApi : BaseApi


-(MKNetworkOperation *)step_phone:(NSString *)phoneNo completionHandler:(JSONResponseBlock)completionBlock
                           errorHandler:(MKNKErrorBlock)errorBlock;

/*
-(MKNetworkOperation *)step_authcode:(JSONResponseBlock)completionBlock
                     errorHandler:(MKNKErrorBlock)errorBlock;

 */

@end
