#import <UIKit/UIKit.h>
#import "SignalFromController.h"

@interface DetailController: UIViewController
@property (nonatomic, retain) id<SignalFromController> parentObject;

-(void)setImage:(NSString *)imageURL;
-(void)changeOrientation:(CGSize)size;
@end