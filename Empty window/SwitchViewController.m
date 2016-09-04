#import "SwitchViewController.h"
#import "CustomViewController.h"
#import "DetailController.h"

@interface SwitchViewController()
@property (nonatomic) UIToolbar *toolbar;
@end

@implementation SwitchViewController

@synthesize mainController;
@synthesize detailController;


-(void)getSignal:(NSString *)string imageURL:(NSString *)url{
    [UIView beginAnimations:@"View flip" context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if ([string  isEqual: @"mainController"]){
        if (self.detailController.view.superview == nil) {
            if (self.detailController == nil) {
                DetailController *_detailController = [DetailController new];
                self.detailController = _detailController;
            }
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
                                   forView:self.view
                                     cache:YES];
            [detailController viewWillAppear:YES];
            [mainController viewWillDisappear:YES];
            [mainController.view removeFromSuperview];
            [self.detailController setImage:url];
            [self.view insertSubview:detailController.view atIndex:0];
            [mainController viewDidDisappear:YES];
            [detailController viewDidAppear:YES];
            [self.toolbar setHidden:NO];
        }
    }
    [UIView commitAnimations];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (self.mainController != nil){
        [self.mainController changeOrientation:size];
    }
    if (self.detailController != nil) {
        [self.detailController changeOrientation:size];
    }
    
}

-(void)goBack:(id)sebder{
    [UIView beginAnimations:@"View flip" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if (self.detailController.view.superview != nil) {
        if (self.mainController == nil) {
            CustomViewController *_customViewController = [CustomViewController new];
            self.mainController = _customViewController;
        }
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
                               forView:self.view
                                 cache:YES];
        [mainController viewWillAppear:YES];
        [detailController viewWillDisappear:YES];
        [self.detailController.view removeFromSuperview];
        [self.view insertSubview:mainController.view atIndex:0];
        [detailController viewDidDisappear:YES];
        [mainController viewDidAppear:YES];
        [self.toolbar setHidden:YES];
    }
    [UIView commitAnimations];
}

-(UIToolbar *) makeToolbar{
    CGRect rectWin = [[UIScreen mainScreen] bounds];
    CGFloat x = 0;
    CGFloat y = rectWin.size.height - 40;
    CGFloat width = rectWin.size.width;
    CGFloat height = 40.0f;
    rectWin = CGRectMake(x, y, width, height);
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:rectWin];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                   target:self
                                   action:@selector(goBack:)];
    NSArray *items = [NSArray arrayWithObjects:backButton, nil];
    toolbar.items = items;
    [toolbar setHidden:YES];
    return toolbar;
}

-(void) viewDidLoad{
    CustomViewController *_customviewcotroller = [CustomViewController new];
    [_customviewcotroller setParentObject:self];
    self.mainController = _customviewcotroller;
    [self.view insertSubview:_customviewcotroller.view atIndex:0];
    [super viewDidLoad];
    self.toolbar = [self makeToolbar];
    [self.view addSubview:self.toolbar];
}

@end