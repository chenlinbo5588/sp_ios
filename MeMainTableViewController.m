//
//  MeMainTableViewController.m
//  sp
//
//  Created by Apple on 15-5-19.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "MeMainTableViewController.h"

@interface MeMainTableViewController ()

@end

@implementation MeMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSLog(@"me did load");
    
    if(_apiLogin == nil){
        _apiLogin = [[LoginApi alloc] initWithDefaultSettings];
    }
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    NSLog(@"me end of viewWillAppear");
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *memberinfo = [defaults valueForKey:@"memberinfo"];
    NSLog(@"memberinfo=%@",memberinfo);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeFunctionCell" forIndexPath:indexPath];
     
     // Configure the cell...
     
     NSString *title;
     NSString *detail;
     
     
     switch (indexPath.row) {
         case 0:
         title = @"设置";
         break;
         
         case 1:
         title = @"我的队伍";
         detail = @"3个队伍";
         
         break;
         case 2:
         title = @"我的数据";
         detail = @"9场比赛数据";
         break;
         
         case 3:
         title = @"我的好友";
         detail = @"10个好友";
         break;
         
         case 4:
         title = @"消息";
         detail = @"3条新消息";
         break;
         case 9:
         title = @"退出系统";
         break;
         
         default:
         title = [NSString stringWithFormat:@"title %d", indexPath.row];
         detail = [NSString stringWithFormat:@"desc %d",indexPath.row];
         break;
     }
     
     cell.textLabel.text = title;
     cell.detailTextLabel.text = detail;
 
    return cell;
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if(indexPath.row == 9){
        [_apiLogin logout:^(NSJSONSerialization *json){
            
            NSString *message = [json valueForKey:@"message"];
            
            NSLog(@"message=%@",message);
            
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyBoard instantiateViewControllerWithIdentifier:@"LoginViewScene"];
            
            [[self.navigationController parentViewController] dismissViewControllerAnimated:YES completion:^{
                [self showViewController:loginViewController sender:nil];
            }];
            
        } errorHandler:^(NSError *error){
            NSLog(@"ERROR=%@",error);
            
        }];
    }
    
    /*
    // Navigation logic may go here, for example:
    // Create the next view controller.
    DetailViewController *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
