#import "FearthHttpHelper.h"

@implementation FearthHttpHelper

+ (void)get:(NSString *)url headers:(NSDictionary<NSString *, NSString *> *)headers callback:(void(^)(NSInteger status, NSString *text))callback {
    NSLog(@"[FearthHttpHelper] <get> url = %@, headers = %@", url, headers);
    
    NSURL *urlRequest = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlRequest];
    [request setHTTPMethod:@"GET"];
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                callback(500, [NSString stringWithFormat:@"Error: %@", error.localizedDescription]);
                return;
            }
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSString *responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            callback(httpResponse.statusCode, responseText);
        });
    }];
    
    [dataTask resume];
}

+ (void)post:(NSString *)url headers:(NSDictionary<NSString *, NSString *> *)headers body:(NSString *)body callback:(void(^)(NSInteger status, NSString *text))callback {
    NSLog(@"[FearthHttpHelper] <post> url = %@, headers = %@, body: %@", url, headers, body);
    
    NSURL *urlRequest = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlRequest];
    [request setHTTPMethod:@"POST"];
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (body) {
        NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    } else {
        [request setHTTPBody:[NSData data]]; // Explicitly set an empty body
    }
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                callback(500, [NSString stringWithFormat:@"Error: %@", error.localizedDescription]);
                return;
            }
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSString *responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            callback(httpResponse.statusCode, responseText);
        });
    }];
    
    [dataTask resume];
}

+ (void)put:(NSString *)url headers:(NSDictionary<NSString *, NSString *> *)headers body:(NSString *)body callback:(void(^)(NSInteger status, NSString *text))callback {
    NSLog(@"[FearthHttpHelper] <put> url = %@, headers = %@, body: %@", url, headers, body);
    
    NSURL *urlRequest = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlRequest];
    [request setHTTPMethod:@"PUT"];
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (body) {
        NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    }
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                callback(500, [NSString stringWithFormat:@"Error: %@", error.localizedDescription]);
                return;
            }
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSString *responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            callback(httpResponse.statusCode, responseText);
        });
    }];
    
    [dataTask resume];
}

+ (void)delete:(NSString *)url headers:(NSDictionary<NSString *, NSString *> *)headers callback:(void(^)(NSInteger status, NSString *text))callback {
    NSLog(@"[FearthHttpHelper] <delete> url = %@, headers = %@", url, headers);
    
    NSURL *urlRequest = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlRequest];
    [request setHTTPMethod:@"DELETE"];
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                callback(500, [NSString stringWithFormat:@"Error: %@", error.localizedDescription]);
                return;
            }
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSString *responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            callback(httpResponse.statusCode, responseText);
        });
    }];
    
    [dataTask resume];
}

@end
