//
//  CPTTMService.m
//  CPTTM
//
//  Created by Admin on 10/6/15.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import "CPTTMService.h"
#import <ReactiveCocoa.h>

@interface CPTTMService ()


//- (RACSignal *) callAPI: (NSString *) name withData: (NSDictionary *) data;

@end

@implementation CPTTMService

- (instancetype) init
{
    self = [super init];
    if (self) {
//        _sid = [[[NSUserDefaults standardUserDefaults] objectForKey:@"sid"] integerValue];
        _token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    }
    return self;
}


- (void) setToken:(NSString *)token
{
    _token = token;
    [[NSUserDefaults standardUserDefaults] setObject:token forKey: @"token"];
}



@end
