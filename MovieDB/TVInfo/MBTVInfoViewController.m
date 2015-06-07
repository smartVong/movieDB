//
//  MBTVInfoViewController.m
//  MovieDB
//
//  Created by Nattapat Vongchinsri on 6/5/2558 BE.
//
//

#import "MBTVInfoViewController.h"

@interface MBTVInfoViewController ()

@end

@implementation MBTVInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTVInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTVInfo
{
    self.tvImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://image.tmdb.org/t/p/original%@",[self.tvInfo objectForKey:@"poster_path"]]];
    
    self.tvName.text = [self.tvInfo objectForKey:@"name"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *temp = [formatter dateFromString:[self.tvInfo objectForKey:@"first_air_date"]];
    formatter.dateFormat = @"dd MMM yyyy";
    
    self.airDate.text = [formatter stringFromDate:temp];
    
    if([[self.tvInfo objectForKey:@"origin_country"] count]>0)
    {
        self.country.text = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:[[self.tvInfo objectForKey:@"origin_country"] objectAtIndex:0]];
    }
    else
    {
        self.country.text = @"--------";
    }
    
    self.popularity.text = [NSString stringWithFormat:@"%@",[self.tvInfo objectForKey:@"popularity"]];
    self.averageVote.text = [NSString stringWithFormat:@"%.1f",[[self.tvInfo objectForKey:@"vote_average"] floatValue]];
    self.voteCount.text = [self setVoteCountWithCount:[NSString stringWithFormat:@"%@",[self.tvInfo objectForKey:@"vote_count"]]];
}

- (NSString*)setVoteCountWithCount:(NSString*)count
{
    if([count integerValue]>=1000)
    {
        count = [NSString stringWithFormat:@"%.2fk",[count floatValue]/1000];
    }
    else if ([count integerValue]>=1000000)
    {
        count = [NSString stringWithFormat:@"%.2fm",[count floatValue]/1000000];
    }
    
    return count;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goBack:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
