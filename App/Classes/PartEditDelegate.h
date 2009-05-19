#import "Part.h"

@protocol PartEditDelegate
-(void)partSaved:(Part *)part created:(BOOL)created;
@end
