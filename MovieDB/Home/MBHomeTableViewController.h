//
//  MBHomeTableViewController.h
//  MovieDB
//
//  Created by Nattapat Vongchinsri on 6/2/2558 BE.
//
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "MBHomeTableViewCell.h"

@interface MBHomeTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *popualrResult;
@property (assign, nonatomic) NSInteger page;

@property (assign, nonatomic) BOOL loading;

- (IBAction)goNext:(UIBarButtonItem *)sender;
- (IBAction)goPrevious:(UIBarButtonItem *)sender;

@end
