//
//  PopularTV.h
//  MovieDB
//
//  Created by Nattapat Vongchinsri on 6/11/2558 BE.
//
//

#import <Foundation/Foundation.h>

@interface PopularTV : NSObject
<NSCoding>

@property (strong, nonatomic) NSString *TVid;
@property (strong, nonatomic) NSString *TVname;
@property (strong, nonatomic) NSString *firstAirDate;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSArray *origin;
@property (strong, nonatomic) NSNumber *popularity;
@property (strong, nonatomic) NSNumber *voteAverage;
@property (assign, nonatomic) NSNumber *voteCount;

@end
