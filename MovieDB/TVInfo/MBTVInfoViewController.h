//
//  MBTVInfoViewController.h
//  MovieDB
//
//  Created by Nattapat Vongchinsri on 6/5/2558 BE.
//
//

#import <UIKit/UIKit.h>
#import <AsyncImageView/AsyncImageView.h>

@interface MBTVInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *gradientView;
@property (weak, nonatomic) IBOutlet UIImageView *tvImage;
@property (weak, nonatomic) IBOutlet UILabel *tvName;
@property (weak, nonatomic) IBOutlet UILabel *airDate;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *popularity;
@property (weak, nonatomic) IBOutlet UILabel *averageVote;
@property (weak, nonatomic) IBOutlet UILabel *voteCount;

@property (strong, nonatomic) NSDictionary *tvInfo;

- (IBAction)goBack:(UIBarButtonItem *)sender;

@end
