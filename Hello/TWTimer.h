#import <Foundation/Foundation.h>

@interface TWTimer : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic, readonly) NSDate *initialTime;

- (NSTimeInterval)elapsedTime;
- (id)initWithName:(NSString*)aName;
- (NSString*)description;

@end
