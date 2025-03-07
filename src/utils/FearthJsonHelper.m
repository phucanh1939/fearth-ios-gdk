#import "FearthJsonHelper.h"
#import <objc/runtime.h>

@interface FearthJsonHelper ()
+ (id)parseDictionary:(NSDictionary *)dictionary toClass:(Class)classType;
+ (NSDictionary *)dictionaryFromObject:(id)object;
@end

@implementation FearthJsonHelper

+ (id)fromJson:(NSString *)jsonString toClass:(Class)classType {
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        NSLog(@"[FearthJsonHelper] <fromJson> Invalid JSON string");
        return nil;
    }

    NSError *error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"[FearthJsonHelper] <fromJson> Error parsing JSON: %@", error.localizedDescription);
        return nil;
    }

    return [self parseDictionary:jsonDict toClass:classType];
}

+ (id)parseDictionary:(NSDictionary *)dictionary toClass:(Class)classType {
    id object = [[classType alloc] init];
    Class currentClass = classType;

    while (currentClass && currentClass != [NSObject class]) {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(currentClass, &propertyCount);

        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
            id value = dictionary[propertyName];

            if (value == nil || value == [NSNull null]) {
                continue;
            }

            // Determine property type
            char *typeEncoding = property_copyAttributeValue(property, "T");
            NSString *typeString = [NSString stringWithUTF8String:typeEncoding];
            free(typeEncoding);

            if ([typeString containsString:@"@"] && typeString.length > 3) {
                // Extract class type for the property
                NSString *typeClassName = [typeString substringWithRange:NSMakeRange(2, typeString.length - 3)];
                Class propertyClass = NSClassFromString(typeClassName);

                if ([value isKindOfClass:[NSDictionary class]] && propertyClass != nil) {
                    // Recursively parse nested objects
                    value = [self parseDictionary:value toClass:propertyClass];
                }
            }

            // Set value using KVC
            [object setValue:value forKey:propertyName];
        }

        free(properties);

        // Move to the superclass to parse its properties
        currentClass = class_getSuperclass(currentClass);
    }

    return object;
}

+ (NSString *)toJson:(id)object {
    NSDictionary *dictionary = [self dictionaryFromObject:object];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    if (error) {
        NSLog(@"Error serializing to JSON: %@", error.localizedDescription);
        return nil;
    }

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryFromObject:(id)object {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    Class currentClass = [object class];
    
    while (currentClass && currentClass != [NSObject class]) {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(currentClass, &propertyCount);

        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
            id value = [object valueForKey:propertyName];

            if (value) {
                if ([value isKindOfClass:[NSObject class]]) {
                    if (![value isKindOfClass:[NSString class]] &&
                        ![value isKindOfClass:[NSNumber class]] &&
                        ![value isKindOfClass:[NSArray class]] &&
                        ![value isKindOfClass:[NSDictionary class]]) {
                        value = [self dictionaryFromObject:value];
                    }
                }
                dictionary[propertyName] = value;
            }
        }

        free(properties);
        currentClass = class_getSuperclass(currentClass); // Move to the superclass
    }

    return dictionary;
}

@end
