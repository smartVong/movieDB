//
//  PopularTV.m
//  MovieDB
//
//  Created by Nattapat Vongchinsri on 6/11/2558 BE.
//
//

#import "PopularTV.h"

@implementation PopularTV

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.TVid forKey:@"id"];
    [encoder encodeObject:self.TVname forKey:@"name"];
    [encoder encodeObject:self.firstAirDate forKey:@"first_air_date"];
    [encoder encodeObject:self.imageURL forKey:@"image"];
    [encoder encodeObject:self.origin forKey:@"origin"];
    [encoder encodeObject:self.popularity forKey:@"popularity"];
    [encoder encodeObject:self.voteAverage forKey:@"vote_average"];
    [encoder encodeObject:self.voteCount forKey:@"vote_count"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.TVid = [decoder decodeObjectForKey:@"id"];
        self.TVname = [decoder decodeObjectForKey:@"name"];
        self.firstAirDate = [decoder decodeObjectForKey:@"first_air_date"];
        self.imageURL = [decoder decodeObjectForKey:@"image"];
        self.origin = [decoder decodeObjectForKey:@"origin"];
        self.popularity = [decoder decodeObjectForKey:@"popularity"];
        self.voteAverage = [decoder decodeObjectForKey:@"vote_average"];
        self.voteCount = [decoder decodeObjectForKey:@"vote_count"];
    }
    return self;
}
@end
