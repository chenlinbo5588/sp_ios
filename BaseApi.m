//
//  BaseApi.m
//  sp
//
//  Created by Apple on 15-5-14.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "BaseApi.h"


@implementation BaseApi


-(id) initWithDefaultSettings {
    
    if(self = [super initWithHostName:BASE_API_HOST customHeaderFields:[self appendCustomerHeader:nil]]) {
        
    }
    return self;
}



-(id) initWithHostName:(NSString *)hostName {
    
    
    if(self = [super initWithHostName:hostName customHeaderFields:[self appendCustomerHeader:nil]]) {
        
    }
    
    return self;
}


-(NSMutableDictionary *)appendCustomerHeader:(NSDictionary *)headers
{
    
    NSMutableDictionary *customer = [[NSMutableDictionary alloc] initWithDictionary:headers];
    [customer setValue:@"iOS" forKey:@"APP_SP"];
    
    return customer;
    
}


-(id) initWithHostName:(NSString *)hostName customHeaderFields:(NSDictionary *)headers
{
    
    [self appendCustomerHeader:headers];
    
    if(self = [super initWithHostName:hostName customHeaderFields:[self appendCustomerHeader:headers]]) {
        
    }
    
    return self;
    
}


-(MKNetworkOperation *)apiRequest:(NSString *)url postdata:(NSDictionary *)params completionHandler:(JSONResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock
{

    NSMutableDictionary *customer;
    if(params != nil){
        
        customer = [[NSMutableDictionary alloc] initWithDictionary:params];
 
        if (_formhash == nil) {
            _formhash = @"";
        }
        
        if (_verify == nil) {
            _verify = @"";
        }
        

        [customer setValue:_formhash forKey:@"formhash"];
        [customer setValue:_verify forKey:@"verify"];
    }
    
    
    MKNetworkOperation *op = [self operationWithPath:url
                                              params:customer
                                          httpMethod: params == nil ? @"GET" : @"POST"];
    
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {

         NSLog(@"Request HEADER=%@", [completedOperation.readonlyRequest allHTTPHeaderFields]);
         NSLog(@"Response HEADER=%@",[completedOperation.readonlyResponse allHeaderFields]);
         NSLog(@"POST=%@",completedOperation.readonlyPostDictionary);

         NSError *respErrror ;
         NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:completedOperation.responseData options:NSJSONReadingMutableLeaves error:&respErrror];
         
         NSLog(@"Response String=%@",completedOperation.responseString);
         NSLog(@"responeseJSON=%@",json);
         
         _formhash = [json valueForKeyPath:@"data.formhash"];
         _verify = [json valueForKeyPath:@"data.verify"];
         
         
         completionBlock(json);
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
}


-(MKNetworkOperation *)formhash:(JSONResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    
    return [self apiRequest:@"/index.php/member/formhash" postdata:nil completionHandler:^(NSJSONSerialization *json) {
        
        completionBlock(json);
        
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
    
}


@end
