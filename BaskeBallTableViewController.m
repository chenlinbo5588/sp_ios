//
//  BaskeBallTableViewController.m
//  sp
//
//  Created by Apple on 15-5-11.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "BaskeBallTableViewController.h"

@interface BaskeBallTableViewController ()


@property (strong ,nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation BaskeBallTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    if(_districtApi == nil){
        _districtApi = [[DistrictApi alloc] initWithDefaultSettings];
        _districtApi.component = 0;
    }
    
    
    if(_districtDict == nil){
        _districtDict = [[NSMutableDictionary alloc] init];
        
    }
    
    
    if(_distrctPickerView == nil){

        _distrctPickerView = [[UIPickerView alloc] initWithFrame:self.view.frame];
        _distrctPickerView.backgroundColor = [UIColor whiteColor];
        
        _distrctPickerView.delegate = self;
        _distrctPickerView.dataSource = self;
        _distrctPickerView.hidden = YES;
        
        
        //[_maskView addSubview:_distrctPickerView];
        [self.view addSubview:_distrctPickerView];
        
    }
    
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshList)];
    UIBarButtonItem *districtButton = [[UIBarButtonItem alloc] initWithTitle:@"地区" style:UIBarButtonItemStylePlain target:self action:@selector(changeDistrict)];
    //[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(changeDistrict)];
    
    //UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonSystemItemAction target:self action:@selector(doneDistrict)];
    
    self.navigationItem.rightBarButtonItem = barButton;
    self.navigationItem.leftBarButtonItem = districtButton;
    
    /*
    _tagRecoginer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTableTap)];
    _tagRecoginer.numberOfTapsRequired = 1;
    */

    //[self.tableView addGestureRecognizer:_tagRecoginer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark custome event

-(void)changeDistrict
{
    
    _distrctPickerView.hidden = NO;

    if(_districtOperation != nil && [_districtOperation isExecuting]){
        return;
        
    }else
    {
        _districtOperation = nil;
    }
    
    _districtOperation = [_districtApi getDistrictByPid:^(NSJSONSerialization *data){
        
        [_districtDict setObject:[data valueForKey:@"data"] forKey:[NSString stringWithFormat:@"%d",_districtApi.component]];
        
        _distrctPickerView.hidden = NO;
        
        [_distrctPickerView reloadComponent:_districtApi.component];
        
        
        for(NSInteger i = _districtApi.component + 1; i < 4; i++){
            [_districtDict removeObjectForKey:[NSString stringWithFormat:@"%d",i]];
            [_distrctPickerView reloadComponent:i];
        }
        
        _districtOperation = nil;
        NSLog(@"_districtDict=%@",_districtDict);
        NSLog(@"reloadComponent %d",_districtApi.component);
        
        
    } errorHandler:^(NSError *erro){

    }];
    
}

-(void)doTableTap
{
    _distrctPickerView.hidden = YES;
}


- (void)refreshList
{
    
    NSLog(@"refresh current list");
}


#pragma mark pickeview 


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    NSString *key = [NSString stringWithFormat:@"%d",component];
    
    if([_districtDict objectForKey:key] != nil){
        
        return [[_districtDict objectForKey:key] count];
        
    }else{
        return 0;
    }
    
}

/*

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 50;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
*/

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSString *key = [NSString stringWithFormat:@"%d",component];
    
    if([_districtDict objectForKey:key] != nil){
        
        return [[[_districtDict objectForKey:key] objectAtIndex:row] objectForKey:@"name"];
        
    }else{
        return @"";
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *key = [NSString stringWithFormat:@"%d",component];

    
    if([_districtDict objectForKey:key] != nil){
        
        if(component <= 2){
            _districtApi.upid = [[[_districtDict objectForKey:key] objectAtIndex:row] objectForKey:@"id"];
            
            _districtApi.component = component + 1;
            
            [self changeDistrict];
        }
    }
    
    
    NSLog(@"component = %d row =%d",component ,row);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    
    if(section == 0){
        return 5;
        
    }else if(section == 1){
        
        return 2;
    }else
    {
        return  0;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor grayColor];
    return  view;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor grayColor];
    

    return  view;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasketBallCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
   
    NSString *title , *detail;
    
    
    if(indexPath.section == 0){
        
        
        switch (indexPath.row) {
            case BASKET_TEAM_ROWINDEX:
                title = @"篮球队";
                detail = @"10个队伍";
                break;
            case BASKET_SITE_ROWINDEX:
                title = @"球场/球馆";
                detail = @"10个球场，26个球馆";
                break;
            case BASKET_RULE_ROWINDEX:
                title = @"规则";
                detail = @"国际/NBA/CBA/详细规则";
                break;
            case BASKET_TOOL_ROWINDEX:
                title = @"计时器/比分牌";
                detail = @"轻松记分，不再傻守记分牌";
                break;
            case BASKET_TACTICS_ROWINDEX:
                title = @"战术版";
                detail = @"布置战术";
                break;
                
            default:
                break;
        }
        
        
        
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
            case BASKET_JUDGE_ROWINDEX:
                title = @"裁判员";
                detail = @"10个";
                break;
            case BASKET_LEAGUE_ROWINDEX:
                title = @"业余联赛";
                detail = @"5个赛事进行中";
                break;
            default:
                break;
        }
        
    }
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = detail;

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _selectedIndexPath = indexPath;
    
    
    if(indexPath.section == 0 && indexPath.row == BASKET_TEAM_ROWINDEX){
        /*
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BasketTeamTableViewController *basketTeamViewController = [storyBoard instantiateViewControllerWithIdentifier:@"BasketBallTeam"];

        [self.navigationController pushViewController:basketTeamViewController animated:YES];
         */
    }
    
    
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


#pragma mark - Navigation

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{

    
    if ([identifier isEqualToString:@"basketCellSegue"]) {
        return YES;
    }
    
 
    return YES;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
    //[self.navigationController pu]
    NSLog(@"This is a segue %@",segue.identifier);
}


@end
