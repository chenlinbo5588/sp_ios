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
    
    
    if(self = [super initWithHostName:BASE_API_HOST customHeaderFields:nil]) {
        
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


@end
