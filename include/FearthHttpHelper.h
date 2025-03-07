#ifndef NE_HTTP_HELPER_H
#define NE_HTTP_HELPER_H

#import <Foundation/Foundation.h>

@interface FearthHttpHelper : NSObject

+ (void)get:(NSString *)url headers:(NSDictionary<NSString *, NSString *> *)headers callback:(void(^)(NSInteger status, NSString *text))callback;
+ (void)post:(NSString *)url headers:(NSDictionary<NSString *, NSString *> *)headers body:(NSString *)body callback:(void(^)(NSInteger status, NSString *text))callback;
+ (void)put:(NSString *)url headers:(NSDictionary<NSString *, NSString *> *)headers body:(NSString *)body callback:(void(^)(NSInteger status, NSString *text))callback;
+ (void)delete:(NSString *)url headers:(NSDictionary<NSString *, NSString *> *)headers callback:(void(^)(NSInteger status, NSString *text))callback;

@end

#endif /* NE_HTTP_HELPER_H */
