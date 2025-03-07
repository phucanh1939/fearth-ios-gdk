#ifndef FearthHttpHelper_h
#define FearthHttpHelper_h

#import <Foundation/Foundation.h>

@interface FearthHttpHelper : NSObject

+ (void)get:(NSString *)url headers:(NSDictionary<NSString *, NSString *> *)headers callback:(void(^)(NSInteger status, NSString *text))callback;
+ (void)post:(NSString *)url headers:(NSDictionary<NSString *, NSString *> *)headers body:(NSString *)body callback:(void(^)(NSInteger status, NSString *text))callback;
+ (void)put:(NSString *)url headers:(NSDictionary<NSString *, NSString *> *)headers body:(NSString *)body callback:(void(^)(NSInteger status, NSString *text))callback;
+ (void)delete:(NSString *)url headers:(NSDictionary<NSString *, NSString *> *)headers callback:(void(^)(NSInteger status, NSString *text))callback;

@end

#endif /* FearthHttpHelper_h */
