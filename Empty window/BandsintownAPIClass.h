#import <Foundation/Foundation.h>


@interface BandsintownAPIClass : NSObject{
    NSMutableArray *listArtists;
}

@property (nonatomic, retain) NSMutableArray *listArtists;

- (void) search:(void(^)(NSArray *))successBlock;
- (NSInteger) getCount;
- (NSString *) getURLImageArtist:(NSString *)name thumb_url:(BOOL)isThumb;
@end