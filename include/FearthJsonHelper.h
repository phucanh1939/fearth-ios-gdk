#ifndef FearthJsonHelper_h
#define FearthJsonHelper_h

#import <Foundation/Foundation.h>

@interface FearthJsonHelper : NSObject

+ (id)fromJson:(NSString *)jsonString toClass:(Class)classType;
+ (NSString *)toJson:(id)object;

@end


#endif