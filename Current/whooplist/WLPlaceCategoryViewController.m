//
//  WLPlaceCategoryViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 2/2/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLPlaceCategoryViewController.h"

@interface WLPlaceCategoryViewController ()

@end

@implementation WLPlaceCategoryViewController

-(id)init {
    if (self = [super init]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:APP_DEL.viewControllers[@"Root"] action:@selector(showMenu)];
    }
    return self;
}

- (id)initWithListType:(NSDictionary *)listType
{
    self = [self init];
    if (self) {
        places = [[NSMutableArray alloc] init];
        _listType = listType;
        NSLog(@"SINGLE LIST: %@", listType);
        self.navigationItem.title = listType[@"Name"];
        [APP_DEL.session subscribeToSessionEvents:self];
        [APP_DEL.session request:[WLRequestType searchPlaceRequestType] withParameters:@{@"ListId": [listType[@"Id"] stringValue], @"Lat": [NSString stringWithFormat:@"%+.12f", APP_DEL.lastLocation.coordinate.latitude], @"Long": [NSString stringWithFormat:@"%+.12f", APP_DEL.lastLocation.coordinate.longitude], @"Radius": [NSString stringWithFormat:@"%d", 5000], @"Page": [NSString stringWithFormat:@"%d", 1]}];
    }
    return self;
}

- (id)initWithListType:(NSDictionary *)listType andUserID:(NSNumber *)userID {
    self = [self init];
    if (self) {
        places = [[NSMutableArray alloc] init];
        _listType = listType;
        _userID = userID;
        NSLog(@"SINGLE LIST: %@", listType);
        
        self.navigationItem.title = listType[@"Name"];
        self.editButtonItem.target = self;
        self.editButtonItem.action = @selector(toggleEditing);
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
        [APP_DEL.session subscribeToSessionEvents:self];
        [APP_DEL.session request:[WLRequestType getUserListRequestType] withParameters:@{@"ListId": [listType[@"Id"] stringValue], @"UserId": [_userID stringValue]}];
    }
    return self;
}

-(void)toggleEditing {
    [super setEditing:![self isEditing] animated:YES];
}

-(void)WLSession:(WLSession *)session didProcessRequestSuccess:(WLRequestRecord *)requestRecord {
    if ([requestRecord.requestType.name isEqualToString:@"SearchPlace"] || [requestRecord.requestType.name isEqualToString:@"GetUserList"]) {
        places = [requestRecord.response mutableCopy];
        [self.tableView reloadData];
    }
}

-(void)WLSession:(WLSession *)session didProcessRequestFailure:(WLRequestRecord *)requestRecord {
    NSLog(@"%@", requestRecord);
}

-(NSArray *)createArray {
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for (NSDictionary *place in places)
        [ret addObject:place[@"Id"]];
    return ret;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = [places objectAtIndex:indexPath.row][@"Name"];
    
    if (!_userID) {
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [addBtn setBackgroundColor:[UIColor blueColor]];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        [addBtn setTag:[[places objectAtIndex:indexPath.row][@"Id"] integerValue]];
        [addBtn addTarget:self action:@selector(addPlaceToLists:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = addBtn;
    }
    
    return cell;
}

-(void)addPlaceToLists:(UIButton *)sender {
    [APP_DEL.session request:[WLRequestType appendUserListRequestType] withParameters:@{@"ListId": [_listType[@"Id"] stringValue], @"PlaceId": [NSString stringWithFormat:@"%d", sender.tag]}];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return _userID ? YES : NO;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (destinationIndexPath.row > sourceIndexPath.row) {
        [places insertObject:[places objectAtIndex:sourceIndexPath.row] atIndex:destinationIndexPath.row+1];
        [places removeObjectAtIndex:sourceIndexPath.row];
    } else {
        [places insertObject:[places objectAtIndex:sourceIndexPath.row] atIndex:destinationIndexPath.row];
        [places removeObjectAtIndex:sourceIndexPath.row+1];
    }
    
    NSLog(@"PLACES: %@", places);
    
    [APP_DEL.session request:[WLRequestType createUserListRequestType] withParameters:@{@"Places": [self createArray], @"ListId": [_listType[@"Id"] stringValue]}];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [places removeObjectAtIndex:indexPath.row];
        
        [APP_DEL.session request:[WLRequestType createUserListRequestType] withParameters:@{@"Places": [self createArray], @"ListId": [_listType[@"Id"] stringValue]}];
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
