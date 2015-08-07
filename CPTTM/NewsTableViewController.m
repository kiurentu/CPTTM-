//
//  NewsTableViewController.m
//  CPTTM
//
//  Created by Admin on 9/6/15.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import "NewsTableViewController.h"
#import <ReactiveCocoa.h>
#import "FaceBookService.h"
#import <AFNetworking.h>
#import "NewsTableViewCell.h"
#import <MJExtension.h>
#import "News.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>


@interface NewsTableViewController ()<RACSubscriber>{
    NSMutableArray *data;
    long until;
    NSMutableDictionary *textViews;
    NSString *_newsLink;
    NSDictionary *attrs;
}

@property(nonatomic, strong) FaceBookService *service;

@end

@implementation NewsTableViewController


    static NSString *CellIdentifier = @"news_cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _service = [FaceBookService sharedFaceBookService];
    
    //Refresh
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(reload)];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self.tableView.header beginRefreshing];

    NSMutableParagraphStyle *paragrahStyle=[[NSMutableParagraphStyle alloc]init];
    [paragrahStyle setLineSpacing:5];
    attrs = @{
              NSFontAttributeName: [UIFont boldSystemFontOfSize:14],
              NSParagraphStyleAttributeName: paragrahStyle
              };
}

- (void) reload
{
    [[[self.service feedOfPage:@"cpttm" withFields:nil] doNext:^(id x) {
        data = [NSMutableArray array];
    } ] subscribe: self];
}

- (void) loadMore
{
    [[self.service feedOfPage:@"cpttm" withFields:nil until: until] subscribe: self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  open cpttm index
 *
 *  @param sender url
 */
-(IBAction)toFacebookIndex:(id)sender
{
    NSString *url=[NSString stringWithFormat:@"https://www.facebook.com/cpttm"];
    [[UIApplication sharedApplication ]openURL:[NSURL URLWithString:url]];
}
- (void)sendNext:(id)value
{
    [data addObjectsFromArray:[News objectArrayWithKeyValuesArray: [value objectForKey:@"data"]]];
//    NSLog(@"data:%@",data);

    
    NSString * nextURL = [[value objectForKey:@"paging"] objectForKey:@"next"];
    
    NSRange range = [nextURL rangeOfString:@"?"];
    
    NSString *queryString = [nextURL substringFromIndex: range.location + range.length];
    
    
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    
    for (NSString *kv in [queryString componentsSeparatedByString:@"&"]) {
        //ky = @"a=b"
        NSArray *kvm = [kv componentsSeparatedByString:@"="];
        //kvm = ["a", "b"]
        query[kvm[0]]=kvm[1];
    }
    
    //NSLog(@"query: %@", query);
    
    
    until = [query[@"until"] longLongValue];
    
    NSLog(@"until:%ld",until);
    
    
    
    [self.tableView.footer endRefreshing];
    [self.tableView.header endRefreshing];
    [self.tableView reloadData];
    
}

- (void)sendError:(NSError *)error{
    NSLog(@"error: %@", error.localizedDescription);
}

- (void)sendCompleted{}

- (void)didSubscribeWithDisposable:(RACCompoundDisposable *)disposable{}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    News *news =data[indexPath.row];
    
    cell.newsMessage.text =nil;
    
    if (news.newsMessage!=nil) {
         NSMutableAttributedString *labelText=[[NSMutableAttributedString alloc]initWithString:[news newsMessage]];
        [labelText addAttributes: attrs range:NSMakeRange(0, [labelText length])];
        [cell.newsMessage setAttributedText:labelText];
    }else if (news.newsMessage==nil)
    {
        [cell.newsMessage setText:nil];
    }
    
   
    
    
    
    
    
    [cell.newsPicture sd_setImageWithURL:news.newsPicture];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self heightForCellAtIndexPath:indexPath];
}

-(CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    static NewsTableViewCell *cell=nil;
    
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



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
