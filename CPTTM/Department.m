//
//  Department.m
//  CPTTM
//
//  Created by Admin on 5/6/15.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import "Department.h"
@implementation Department
/**
 *  model Department mapping
 *
 *  @param dic mapping name
 *
 *  @return model the property
 */
-(Department *)initWihtDictionary:(NSDictionary *)dic
{
    if (self=[super init])
    {
        self.departmentName=dic [@"DepartmentName"] ;
        
        self.departmentPresentation=dic [@"DepartmentPresentation"];
        
        self.contactName=dic [@"ContactName "];
        
        self.phoneNumber=dic [@"PhoneNumber"];
        
        self.phone=dic [@"Phone"];
        
        self.contactNamePlus=dic [@"ContactNamePlus"];
        
        self.phoneNumberPlus=dic [@"PhoneNumberPlus"];
        
        self.phonePlus=dic [@"PhonePlus"];
        
    }
    return self;
}



@end
