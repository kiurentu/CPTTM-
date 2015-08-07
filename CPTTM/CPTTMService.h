//
//  CPTTMService.h
//  CPTTM
//
//  Created by Admin on 10/6/15.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "BaseService.h"

extern NSString *BizCloudNotification_Network_Reachable;

@interface CPTTMService : BaseService

@property (nonatomic, readonly) BOOL reachable;

@property (nonatomic, strong) NSString *token;

@end
