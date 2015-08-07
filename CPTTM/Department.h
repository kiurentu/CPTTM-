//
//  Department.h
//  CPTTM
//
//  Created by Admin on 5/6/15.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Department : NSObject
/**
 *  model Department
 */
@property (nonatomic,copy) NSString *departmentName;

@property (nonatomic,copy)NSString *departmentPresentation;

@property (nonatomic,copy)NSString *contactName;

@property (nonatomic,copy)NSString *phoneNumber;

@property (nonatomic,copy)NSString *phone;

@property (nonatomic,copy)NSString *contactNamePlus;

@property (nonatomic,copy)NSString *phoneNumberPlus;

@property (nonatomic,copy)NSString *phonePlus;

-(Department *)initWihtDictionary:(NSDictionary *)dic;


@end
