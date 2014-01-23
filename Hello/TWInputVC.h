//
//  TWInputVC.h
//  Get user Input

#import <UIKit/UIKit.h>

@protocol TWInputDelegate;

//@interface TSWInputViewController : UIViewController
@interface TWInputVC : UIViewController

@property (weak, nonatomic) id<TWInputDelegate> delegate;
@end

@protocol TWInputDelegate <NSObject>
 
// inputView:didEnterText:

- (void)inputView:(TWInputVC*)inputView
     didEnterText:(NSString *)text;

@optional
- (void)inputViewDidCancel:(TWInputVC*)inputView;

@end