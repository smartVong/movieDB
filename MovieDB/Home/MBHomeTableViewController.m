//
//  MBHomeTableViewController.m
//  MovieDB
//
//  Created by Nattapat Vongchinsri on 6/2/2558 BE.
//
//

#import "MBHomeTableViewController.h"

@interface MBHomeTableViewController ()

@end

@implementation MBHomeTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.popularResult = [[NSArray alloc] init];
    self.page = 1;
    
    self.loading = YES;
    [self configureRestKit];
    [self getHomeData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://api.themoviedb.org"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *popularMapping = [RKObjectMapping mappingForClass:[PopularTV class]];
    [popularMapping addAttributeMappingsFromDictionary:@{@"id" : @"TVid", @"name" : @"TVname", @"first_air_date" : @"firstAirDate", @"poster_path" : @"imageURL", @"origin_country" : @"origin", @"popularity" : @"popularity", @"vote_average" : @"voteAverage", @"vote_count" : @"voteCount"}];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:popularMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/3/tv/popular"
                                                keyPath:@"results"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

- (void)getHomeData
{
    NSDictionary *queryParams = @{@"api_key" : movieDB_API_KEY,
                                  @"page" : [NSString stringWithFormat:@"%ld",self.page]};
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/3/tv/popular"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  self.popularResult = mappingResult.array;
                                                  [self.tableView reloadData];
                                                  self.loading = NO;
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getHomeData) userInfo:nil repeats:NO];
                                              }];
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.popularResult count];
}


- (MBHomeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    
    PopularTV *popularTV = [self.popularResult objectAtIndex:indexPath.row];
    
    cell.tvNum.text = [NSString stringWithFormat:@"%ld",((self.page-1)*20)+indexPath.row+1];
    cell.tvName.text = popularTV.TVname;
    
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

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MBTVInfoViewController *tvInfoVC = [mainStory instantiateViewControllerWithIdentifier:@"TVInfo"];
    tvInfoVC.popularTV = [self.popularResult objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:tvInfoVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIBarButtonItem Functions
- (IBAction)goNext:(UIBarButtonItem *)sender
{
    if(!self.loading&&self.page!=25)
    {
        self.loading = YES;
        self.page++;
        [self getHomeData];
    }
}

- (IBAction)goPrevious:(UIBarButtonItem *)sender
{
    if(self.page!=1&&!self.loading)
    {
        self.loading = YES;
        self.page--;
        [self getHomeData];
    }
}
@end
