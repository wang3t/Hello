#import <Foundation/Foundation.h>

@interface TWTimer : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic, readonly) NSDate *initialTime;

- (NSTimeInterval)getTimerDelta;
- (id)initWithName:(NSString*)aName;
- (NSString*)description;

@end
