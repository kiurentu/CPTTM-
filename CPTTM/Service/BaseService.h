//
//  BaseService.h
//  CPTTM
//
//  Created by Admin on 10/6/15.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <ReactiveCocoa.h>
#import "Singleton.h"

@interface BaseService : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager* httpManager;

-(RACSignal *) getUrl: (NSString *) url withParams:(NSDictionary *)queries;

+(AFHTTPRequestOperationManager *) setUpHttpManageWihth: (NSString *)baseURLString;


@end
