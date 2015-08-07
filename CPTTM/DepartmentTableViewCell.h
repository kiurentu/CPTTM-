//
//  DepartmentTableViewCell.h
//  CPTTM
//
//  Created by Admin on 8/6/15.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"
#import "RWLabel.h"
@interface DepartmentTableViewCell : UITableViewCell

/**
 *  Department Cell property
 */
/**
*  RWLabel ReWrite UILabel
*/
@property (weak, nonatomic) IBOutlet RWLabel *departmentName;

@property (weak, nonatomic) IBOutlet RWLabel *departmentPresentation;

@property (weak, nonatomic) IBOutlet UIView *contactView;

@property (weak, nonatomic) IBOutlet UILabel *contactName;

@property (weak, nonatomic) IBOutlet UIButton *phoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *contactNamePlus;

@property (weak, nonatomic) IBOutlet UIButton *phoneNumberPlus;



@end
