//
//  Created by Backbase R&D B.V. on 21/08/2017.
//

#import <Foundation/Foundation.h>

#ifndef NSObject_JSONMapper_h
#define NSObject_JSONMapper_h

typedef NS_OPTIONS(NSUInteger, JSONPrintingOptions) {
    JSONPrintingOptionsKeepNull = 1,
    JSONPrintingOptionsPretty = 2
};

/// JSON Mapper interface that enables to reach MSDK JSON Mapper methods.
@interface NSObject (JSONMapper)

+ (instancetype)map:(id)jsonObject error:(NSError**)error;

- (NSString*)JSONString;
- (NSString*)JSONString:(JSONPrintingOptions)options;

@end

@protocol JSONMapper <NSObject>
@required
- (NSString*)remapPropertyName:(NSString*)propertyName;
@optional
- (instancetype)initForMap;
- (NSArray<NSString*>*)skipProperties;
@end

#endif
