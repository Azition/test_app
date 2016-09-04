#import "BandsintownAPIClass.h"
#import "THSHTTPCommunication.h"

@interface BandsintownAPIClass ()
@end

@implementation BandsintownAPIClass

@synthesize listArtists;

-(NSInteger) getCount{
    return [self.listArtists count];
}

-(NSString *) getURLImageArtist:(NSString *)name thumb_url:(BOOL)isThumb{
    THSHTTPCommunication *http = [[THSHTTPCommunication alloc] init];
    NSRange replaceRange = [name rangeOfString:@"/"];
    NSString *artistName = name;
    if (replaceRange.location != NSNotFound){
        replaceRange.length = replaceRange.location + 2;
        replaceRange.location = 0;
        artistName = [artistName stringByReplacingCharactersInRange:replaceRange withString:@""];
    }
    artistName = [artistName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlImage = [NSString stringWithFormat:@"http://api.bandsintown.com/artists/%@.json?api_version=2.0&app_id=example_id", artistName];
    NSData *artistData = [http get:@"" url:urlImage];
    NSError *error = nil;
    NSDictionary *artist = [NSJSONSerialization JSONObjectWithData:artistData
                                                      options:0
                                                        error:&error];
    if (!error){
        if (isThumb) {
            return [NSString stringWithFormat:@"%@", artist[@"thumb_url"]];
        }
        return [NSString stringWithFormat:@"%@", artist[@"image_url"]];
    }
    
    return @"";
}

-(void)search:(void(^)(NSArray *))successBlock{
    THSHTTPCommunication *http = [[THSHTTPCommunication alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://api.bandsintown.com/events/search?location=59.975252,30.339557&radius=12.4275&format=json&app_id=example_app&api_version=2.0"];
    
    [http retrieveURL:url successBlock:^(NSData *response){
        NSError *error = nil;
        NSArray *arData = [NSJSONSerialization JSONObjectWithData:response
                                                          options:0
                                                            error:&error];
        self.listArtists = [NSMutableArray new];
        NSArray *artists = nil;
        NSDictionary *artist;
        NSDictionary *newData = nil;
        if (!error) {
            for (id item in arData) {
                artists = (NSArray *)item[@"artists"];
                for (artist in artists) {
                    newData = @{@"name": artist[@"name"],
                                @"mbid": artist[@"mbid"],
                                @"datetime": item[@"datetime"],
                                @"venue": item[@"venue"],
                                @"imageURL": [self getURLImageArtist:artist[@"name"] thumb_url:YES]
                                };
                    [self.listArtists addObject: newData];
                }
            }
        } else {
            NSLog(@"Error");
        }
        successBlock(self.listArtists);
    }];
}

@end