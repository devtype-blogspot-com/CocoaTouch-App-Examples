//
//  MainTableViewController.m
//  ToDo List
//
//  http://devtype.blogspot.com/2016/02/Kak-polzovatsya-UITableView.html
//  Copyright © 2016 DEVTYPE. All rights reserved.
//

#import "MainTableViewController.h"
#import "DetailViewController.h"


@interface MainTableViewController ()
@property (nonatomic, strong) NSMutableArray *arrayEvents;
@end


@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    self.arrayEvents = [[NSMutableArray alloc] initWithArray:array];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayEvents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    UILocalNotification *notification = [self.arrayEvents objectAtIndex:indexPath.row];
    NSDictionary *dict = notification.userInfo;
    cell.textLabel.text = [dict objectForKey:@"eventInfo"];
    cell.detailTextLabel.text = [dict objectForKey:@"eventDate"];
    return cell;
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // снять выделение с ячейки
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    [self.navigationController pushViewController:detailView animated:YES];
    
    UILocalNotification *notification = [self.arrayEvents objectAtIndex:indexPath.row];
    NSDictionary *dict = notification.userInfo;

    detailView.eventInfo = [dict objectForKey:@"eventInfo"];
    detailView.eventDate = [notification fireDate];
    detailView.isDetail = YES;
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
