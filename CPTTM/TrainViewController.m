//
//  ClassViewController.m
//  CPTTM
//
//  Created by Admin on 28/5/15.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import "TrainViewController.h"
#import <ReactiveCocoa.h>
@interface TrainViewController ()

@end

@implementation TrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"backBar:%@",self.navigationItem.rightBarButtonItem.title);
    self.setView.hidden=YES;
    
    /**
     *  button  
     *  title image vertical
     */
    CGFloat spaceing=6.0;
    
    for (UIButton *btn in @[self.tailoringButton, self.newsButton, self.languageButton, self.manageButton]) {
        
        btn.titleEdgeInsets=UIEdgeInsetsMake(0.0, -btn.imageView.frame.size.width, -(btn.imageView.frame.size.height+spaceing), 0.0);
        
        btn.imageEdgeInsets=UIEdgeInsetsMake(-(btn.titleLabel.frame.size.height+spaceing), 0.0, 0.0, -btn.titleLabel.frame.size.width);
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *setCell = [NSString stringWithFormat:@"train_cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setCell forIndexPath:indexPath];
    
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//}



/**
 *  makes setView unhidden
 *
 *  @param sender setBtn
 */
- (IBAction)setBtn:(id)sender {
    if (self.setView.hidden==YES) {
        self.setView.hidden=NO;
    }else{
        self.setView.hidden=YES;
    }
}
@end
