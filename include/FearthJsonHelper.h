#ifndef NE_JSON_HELPER_H
#define NE_JSON_HELPER_H

#import <Foundation/Foundation.h>

@interface FearthJsonHelper : NSObject

+ (id)fromJson:(NSString *)jsonString toClass:(Class)classType;
+ (NSString *)toJson:(id)object;

@end


#endif