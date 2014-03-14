//
//  WLPlacesViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 2/2/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLPlaceCategoriesViewController.h"
#import "WLPlaceCategoryViewController.h"

@interface WLPlaceCategoriesViewController ()

@end

@implementation WLPlaceCategoriesViewController

- (id)init {
    if (self = [super init]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:APP_DEL.viewControllers[@"Root"] action:@selector(showMenu)];
    }
    return self;
}

- (id)initWithRoot:(NSNumber *)root andResponse:(NSArray *)response {
    if (self = [self init]) {
        categories = [[NSMutableArray alloc] init];
        _root = root;
        _response = response;
        NSLog(@"New category view ID %@ response %@", root, response);
        if (!root)
            self.navigationItem.title = @"Places";
        else
            for (NSDictionary *item in _response)
                if ([item[@"Id"] isEqualToNumber:_root]) {
                    self.navigationItem.title = item[@"Name"];
                    break;
                }
        [self processListTypes];
        [APP_DEL.session subscribeToSessionEvents:self];
    }
    return self;
}

- (id)initWithRoot:(NSNumber *)root andUserID:(NSNumber *)userID andResponse:(NSArray *)response {
    if (self = [self initWithRoot:root andResponse:response]) {
        _userID = userID;
        if (!root)
            self.navigationItem.title = @"My Lists";
    }
    return self;
}

- (id)initWithRoot:(NSNumber *)root
{
    if (self = [self init]) {
        categories = [[NSMutableArray alloc] init];
        _root = root;
        if (!root)
            self.navigationItem.title = @"Places";
        else
            for (NSDictionary *item in _response)
                if ([item[@"Id"] isEqualToNumber:_root]) {
                    self.navigationItem.title = item[@"Name"];
                    break;
                }
        [APP_DEL.session subscribeToSessionEvents:self];
        [APP_DEL.session request:[WLRequestType getListTypesRequestType] withParameters:nil];
    }
    return self;
}

- (id)initWithRoot:(NSNumber *)root andUserID:(NSNumber *)userID {
    if (self = [self initWithRoot:root]) {
        _userID = userID;
        if (!root)
            self.navigationItem.title = @"My Lists";
    }
    return self;
}

- (void)WLSession:(WLSession *)session didProcessRequestSuccess:(WLRequestRecord *)requestRecord {
    if ([requestRecord.requestType.name isEqualToString:@"GetListTypes"]) {
        _response = requestRecord.response;
        [self processListTypes];
    }
}

- (void)processListTypes {
    if (!_root) {
        for (NSDictionary *listType in _response)
            if (![self listTypeIsChild:listType[@"Id"] inResponse:_response]) {
                [categories addObject:listType];
            }
    } else {
        for (NSNumber *childID in [self listTypeForID:_root inResponse:_response][@"Children"])
            [categories addObject:[self listTypeForID:childID inResponse:_response]];
    }
    [self.tableView reloadData];
}

- (BOOL)listTypeIsChild:(NSNumber *)ID inResponse:(NSArray *)response {
    for (NSDictionary *listType in response) {
        if ([[listType[@"Children"] class] isSubclassOfClass:[NSArray class]])
            for (NSNumber *childID in listType[@"Children"])
                if ([childID isEqualToNumber:ID])
                    return true;
    }
    return false;
}

- (BOOL)listTypeHasChildren:(NSNumber *)ID inResponse:(NSArray *)response {
    return [[[self listTypeForID:ID inResponse:response][@"Children"] class] isSubclassOfClass:[NSArray class]];
}

- (NSDictionary *)listTypeForID:(NSNumber *)ID inResponse:(NSArray *)response {
    for (NSDictionary *listType in response)
        if ([listType[@"Id"] isEqualToNumber:ID])
            return listType;
    return nil;
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
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = categories[indexPath.row][@"Name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self listTypeHasChildren:categories[indexPath.row][@"Id"] inResponse:_response]) {
        WLPlaceCategoriesViewController *vc = _userID ? [[WLPlaceCategoriesViewController alloc] initWithRoot:categories[indexPath.row][@"Id"] andUserID: _userID andResponse:_response] : [[WLPlaceCategoriesViewController alloc] initWithRoot:categories[indexPath.row][@"Id"] andResponse:_response];
            
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        WLPlaceCategoryViewController *vc = _userID ? [[WLPlaceCategoryViewController alloc] initWithListType:[self listTypeForID:categories[indexPath.row][@"Id"] inResponse:_response] andUserID:_userID] : [[WLPlaceCategoryViewController alloc] initWithListType:[self listTypeForID:categories[indexPath.row][@"Id"] inResponse:_response]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
