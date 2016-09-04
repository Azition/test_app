#import <UIKit/UIKit.h>
#import "BandsintownAPIClass.h"
#import "SignalFromController.h"

@interface CustomViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) id<SignalFromController> parentObject;
-(void)changeOrientation:(CGSize)size;
@end

