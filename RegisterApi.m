//
//  RegisterApi.m
//  sp
//
//  Created by Apple on 15-5-27.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "RegisterApi.h"

@implementation RegisterApi

-(MKNetworkOperation *)step_phone:(NSString *)phoneNo completionHandler:(JSONResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock
{

    NSDictionary *param;
    
    if (phoneNo != nil) {
        param = [[NSDictionary alloc] initWithObjects:@[phoneNo] forKeys:@[@"phoneNo"]];
    }else{
        param = nil;
    }
    
    return [self apiRequest:@"/index.php/api/register/step_phone" postdata:param completionHandler:^(NSJSONSerialization *json) {
        completionBlock(json);
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
    
    
}


/*

-(MKNetworkOperation *)step_aucode:(JSONResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    
    NSDictionary *param;
    
    if ([_method isEqualToString:@"POST"]) {
        param = [[NSDictionary alloc] initWithObjects:@[self.verify,  self.formhash, _phoneNo] forKeys:@[@"verify",@"formhash",@"phoneNo"]];
    }else{
        param = nil;
    }
    
    
    NSString *path = [NSString stringWithFormat:@"/index.php/api/register/step_phone"];
    MKNetworkOperation *op = [self operationWithPath:path
                                              params:param
                                          httpMethod:_method];
    
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         DLog(@"Data from %@", [completedOperation.readonlyRequest allHTTPHeaderFields]);
         
         NSError *respErrror ;
         NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:completedOperation.responseData options:NSJSONReadingMutableLeaves error:&respErrror];
         
         completionBlock(json);
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
    
}

*/


@end
