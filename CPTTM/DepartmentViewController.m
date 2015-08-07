//
//  DepartmentViewController.m
//  CPTTM
//
//  Created by Admin on 28/5/15.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import "DepartmentViewController.h"
#import "DepartmentTableViewCell.h"
#import <ReactiveCocoa.h>

@interface DepartmentViewController ()
{
    NSMutableArray *_department;
    NSString       *_phone;
    NSString       *_phonePlus;
    NSDictionary   *attrs;
    CGFloat        *_height;
   
}

@end

@implementation DepartmentViewController

static NSString *CellIdentifier=@"department_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    [self initData];
    /**
     *  label style
     */
    NSMutableParagraphStyle *paragrahStyle=[[NSMutableParagraphStyle alloc]init];
    [paragrahStyle setLineSpacing:15];
    attrs = @{
              NSFontAttributeName: [UIFont systemFontOfSize:14],
              NSParagraphStyleAttributeName: paragrahStyle
              };
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DepartmentTableViewCell *cell=(DepartmentTableViewCell *)self.cellHeight;
//
//    cell.t.text=[_department objectAtIndex:indexPath.row];
//}

-(void)initData
{
    /**
     *  plist
     */
    NSString *path =[[NSBundle mainBundle]pathForResource:@"Department.plist" ofType:nil];

    NSArray  *array=[NSArray arrayWithContentsOfFile:path];

    _department=[[NSMutableArray alloc]init];

    for (NSDictionary *item in array) {
        Department *department=[[Department alloc]initWihtDictionary:item];
        [_department addObject:department];
    }

    [self.tableView reloadData];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _department.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    

    DepartmentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
    
    
    Department *department  = _department[indexPath.row];

    [cell.departmentName setText:[department departmentName]];
    
    //[cell.departmentPresentation setText:nil];
    
    
    
    
    
    NSMutableAttributedString *labelText=[[NSMutableAttributedString alloc]initWithString:[department departmentPresentation]];
    
    
    
    [labelText addAttributes:attrs range:NSMakeRange(0,[labelText length])];
    [cell.departmentPresentation setText:nil];
    
    [cell.departmentPresentation setAttributedText:labelText];
    
    //NSLog(@"heigh:%f",cell.departmentPresentation.frame.size.height);
    
    //NSLog(@"heigh:%@",cell.departmentPresentation.text);
    
    //NSLog(@"Cellheigh:%f",cell.frame.size.height);
    
    
    [cell.contactName setText:[department contactName]];
    
    [cell.phoneNumber setTitle:[department phoneNumber] forState:UIControlStateNormal];
    
    [cell.contactNamePlus setText:[department contactNamePlus]];
    
    [cell.phoneNumberPlus setTitle:[department phoneNumberPlus] forState:UIControlStateNormal];
    
    if (cell.contactNamePlus.text==nil)
    {
        cell.contactView.hidden = YES;
    }else if (cell.contactName.text!=nil)
    {
        cell.contactView.hidden = NO;
    }

    
    /**
     telphone num
     */
    cell.phoneNumber.rac_command=[[RACCommand alloc]initWithSignalBlock:^(id _)
                                  {
                                      _phone=[department phone];
                                      return [RACSignal empty];
                                  }];

    cell.phoneNumberPlus.rac_command=[[RACCommand alloc]initWithSignalBlock:^(id _)
                                      {
                                          _phonePlus=[department phonePlus];
                                          return [RACSignal empty];
                                      }];
    
    
    
    return cell;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (IBAction)call:(UIButton*)sender
{
    NSString *phoneNumber   = _phone;

    NSString *cleanedString = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSURL *telURL           = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", cleanedString]];

    //NSLog(@"%@",phoneNumber);

    if([[UIApplication sharedApplication] canOpenURL:telURL])
    {
        [[UIApplication sharedApplication] openURL:telURL];
    } else
    {
        //Show error message to user, etc.
    }

}
- (IBAction)callPlus:(UIButton*)sender
{
    NSString *phoneNumber   = _phonePlus;

    NSString *cleanedString = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSURL *telURL           = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", cleanedString]];

    //NSLog(@"%@",phoneNumber);

    if([[UIApplication sharedApplication] canOpenURL:telURL])
    {
        [[UIApplication sharedApplication] openURL:telURL];
    } else
    {
        //Show error message to user, etc.
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self heightForCellAtIndexPath:indexPath];
}

-(CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    static DepartmentTableViewCell *cell=nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        cell=[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    });
    
    return [self calculateHeightForConfiguredSizingCell:cell];
}


-(CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)Cell
{
    Cell.bounds=CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(Cell.bounds));
    
    [Cell setNeedsLayout];
    [Cell layoutIfNeeded];
    
    CGSize size=[Cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height+1.0f;
}

@end
