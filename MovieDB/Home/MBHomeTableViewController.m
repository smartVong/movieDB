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
    [self getHomeDataInPage:self.page];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getHomeDataInPage:(NSInteger)page
{
    NSString *urlStr = [NSString stringWithFormat:@"http://api.themoviedb.org/3/tv/popular?api_key=%@&page=%ld",movieDB_API_KEY,page];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject){
        
        if([[responseObject objectForKey:@"results"] count]>0)
        {
            self.popularResult = [responseObject objectForKey:@"results"];
            [self.tableView reloadData];
        }
        else
        {
            self.page--;
        }
        
        self.loading = NO;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No Internet Connection" message:@"Please check your internet vonnection" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        self.loading = NO;
    }];
    [operation start];
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.popularResult count];
}


- (MBHomeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    
    NSDictionary *dict = [self.popularResult objectAtIndex:indexPath.row];
    
    cell.tvNum.text = [NSString stringWithFormat:@"%ld",((self.page-1)*20)+indexPath.row+1];
    cell.tvName.text = [dict objectForKey:@"name"];
    
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
    tvInfoVC.tvInfo = [NSDictionary dictionaryWithDictionary:[self.popularResult objectAtIndex:indexPath.row]];
    
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
        [self getHomeDataInPage:self.page];
    }
}

- (IBAction)goPrevious:(UIBarButtonItem *)sender
{
    if(self.page!=1&&!self.loading)
    {
        self.loading = YES;
        self.page--;
        [self getHomeDataInPage:self.page];
    }
}
@end
