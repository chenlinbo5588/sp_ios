//
//  LoginApi.m
//  sp
//
//  Created by Apple on 15-5-11.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "LoginApi.h"


@implementation LoginApi







-(MKNetworkOperation *)formhash:(JSONResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    
    MKNetworkOperation *op = [self operationWithPath:@"/index.php/member/login"
                                              params:nil
                                          httpMethod:@"GET"];
    
    
    
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSLog(@"%@",completedOperation.responseString);
         NSError *respErrror ;
         NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:completedOperation.responseData options:NSJSONReadingMutableLeaves error:&respErrror];
         
         _formhash = [json valueForKeyPath:@"data.formhash"];
         
         /*
         _seccodehash = [json valueForKey:@"seccodehash"];
         _seccodeverify = [json valueForKey:@"seccodeverify"];
         _seccodemodid = [json valueForKey:@"seccodemodid"];
         
         //NSString *idhash = [json valueForKey:@"seccodehash"];
          
          */
         
         
         completionBlock(json);
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
}



-(MKNetworkOperation *)logout:(LogoutResponeBlock)completionBlock
                         errorHandler:(MKNKErrorBlock)errorBlock
{
    
    
    
    MKNetworkOperation *op = [self operationWithPath:@"/index.php/member/logout"
                                              params:nil
                                          httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSLog(@"%@",completedOperation.responseString);
         NSError *respErrror ;
         NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:completedOperation.responseData options:NSJSONReadingMutableLeaves error:&respErrror];
         
         completionBlock(json);
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;

}



-(MKNetworkOperation *)loginByUserName:(NSString *)username
                                  password:(NSString *)password
                     completionHandler:(LoginResponseBlock)completionBlock
                          errorHandler:(MKNKErrorBlock)errorBlock
{
    
    if(_formhash == nil)
    {
        _formhash = @"";
    }
    
    NSDictionary *param = [[NSDictionary alloc] initWithObjects:@[username,password ,_formhash]
                                                        forKeys:@[@"username", @"password",@"formhash"]];

    
    
    MKNetworkOperation *op = [self operationWithPath:@"/index.php/member/login"
                                              params:param
                                          httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         // the completionBlock will be called twice.
         // if you are interested only in new values, move that code within the else block
         
         /*
         NSString *valueString = [[completedOperation responseString] componentsSeparatedByString:@","][1];
         DLog(@"%@", valueString);
         */
         if([completedOperation isCachedResponse]) {
             DLog(@"Data from cache %@", [completedOperation responseString]);
         }
         else {
             DLog(@"Data from server %@", [completedOperation responseString]);
         }
         
         
         NSError *respErrror ;
         
         NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:completedOperation.responseData options:NSJSONReadingMutableLeaves error:&respErrror];
         
         
         completionBlock(json);
         
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;

    
}



@end
