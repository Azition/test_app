#import <UIKit/UIKit.h>
#import "SignalFromController.h"

@class CustomViewController;
@class DetailController;

@interface SwitchViewController : UIViewController <UIContentContainer, SignalFromController>{
    CustomViewController *mainController;
    DetailController *detailController;
}

@property (retain, nonatomic) CustomViewController *mainController;
@property (retain, nonatomic) DetailController *detailController;

@end