//
//  WLFriendsViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 2/20/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLFriendsViewController.h"

@interface WLFriendsViewController ()

@end

@implementation WLFriendsViewController

- (id)init
{
    self = [super init];
    if (self) {
        _friends = [[NSMutableDictionary alloc] init];
        [APP_DEL.session subscribeToSessionEvents:self];
        [APP_DEL.session request:[WLRequestType getUserFriendsRequestType] withParameters:@{@"UserId": [[APP_DEL.session userID] stringValue]}];
        self.navigationItem.title = @"My People";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:APP_DEL.viewControllers[@"Root"] action:@selector(showMenu)];
    }
    return self;
}

-(void)WLSession:(WLSession *)session didProcessRequestSuccess:(WLRequestRecord *)requestRecord {
    if ([requestRecord.requestType.name isEqualToString:@"GetUserFriends"]) {
        NSMutableDictionary *friends = [requestRecord.response mutableCopy];
        for (NSString *key in friends) {
            _friends[key] = [friends[key] mutableCopy];
        }
        NSLog(@"%@", _friends);
        [self.tableView reloadData];
    }
} 

-(void)WLSession:(WLSession *)session didProcessRequestFailure:(WLRequestRecord *)requestRecord {
    NSLog(@"Friends Failed: %@", requestRecord);
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_friends[section == 0 ? @"Both" : section == 1 ? @"Following" : @"Followers"] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return (section == 0) ? @"Friends" : (section == 1) ? @"Following" : @"Followers";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = _friends[indexPath.section == 0 ? @"Both" : indexPath.section == 1 ? @"Following" : @"Followers"][indexPath.row][@"Name"];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ![[self tableView:tableView titleForHeaderInSection:indexPath.section] isEqualToString:@"Followers"];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [APP_DEL.session request:[WLRequestType deleteUserFriendRequestType] withParameters:@{@"OtherId": [_friends[indexPath.section == 0 ? @"Both" : indexPath.section == 1 ? @"Following" : @"Followers"][indexPath.row][@"Id"] stringValue]}];
        
        [_friends[indexPath.section == 0 ? @"Both" : indexPath.section == 1 ? @"Following" : @"Followers"] removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
