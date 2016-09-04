#import "DetailController.h"


@interface DetailController()
@property (nonatomic) UIImageView *imageview;
@property NSString *imageStringURL;
//@property GMSMapView *mapView;
@end

@implementation DetailController

@synthesize parentObject;

-(void)changeOrientation:(CGSize)size{
    CGRect rect;
    if (size.height < size.width) {
        rect = CGRectMake(0, 0, size.width / 2, size.height);
    }
    else {
        rect = CGRectMake(0, 0, size.width, size.height / 2);
    }
    [self.imageview setFrame:rect];
}

-(void)setImage:(NSString *)imageURL{
    self.imageStringURL = imageURL;
    if (self.imageview != nil) {
        self.imageview.image = [UIImage imageWithData:
                                [NSData dataWithContentsOfURL:
                                 [NSURL URLWithString:self.imageStringURL]]];
    }
}

-(UIImageView *) makeImage{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height / 2;
    
    rect = CGRectMake(0, 0, width, height);
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:rect];
    
    return imageview;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    self.imageview = [self makeImage];
    self.imageview.image = [UIImage imageWithData:
                            [NSData dataWithContentsOfURL:
                             [NSURL URLWithString:self.imageStringURL]]];
    [self.view addSubview:self.imageview];
}

@end