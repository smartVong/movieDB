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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setBG];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBG
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.gradientView.frame.size.width, self.gradientView.frame.size.height);
    
    UIColor *c1 = [UIColor colorWithRed:0.09 green:0.7 blue:0.98 alpha:1.0];
    UIColor *c2 = [UIColor colorWithRed:0.07 green:0.41 blue:0.95 alpha:1.0];
    UIColor *c3 = [UIColor colorWithRed:0.81 green:0.46 blue:0.93 alpha:1.0];
    
    gradientLayer.colors = @[(id)c2.CGColor,(id)c3.CGColor,(id)c3.CGColor];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.toValue = @[(id)c1.CGColor,(id)c2.CGColor,(id)c2.CGColor];
    animation.duration = 4.0;
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VALF;
    
    [gradientLayer addAnimation:animation forKey:@"colors"];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, self.gradientView.frame.size.width, self.gradientView.frame.size.height);
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-self.gradientView.frame.size.width/4, -self.gradientView.frame.size.height/4, self.gradientView.frame.size.width*1.5, self.gradientView.frame.size.height*1.5)];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:shapeLayer.frame];
    
    shapeLayer.path = path1.CGPath;
    
    animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue = (id)path2.CGPath;
    animation.duration = 4.0;
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VALF;
    
    [shapeLayer addAnimation:animation forKey:@"path"];
    gradientLayer.mask = shapeLayer;
    
    [self.gradientView.layer addSublayer:gradientLayer];
    

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
