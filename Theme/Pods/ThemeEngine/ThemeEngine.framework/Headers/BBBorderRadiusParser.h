//
//  BBBorderRadiusParser.h
//  Rorschach
//
//  Created by Backbase B.V. on 13/09/2019.
//  Copyright © 2019 Backbase. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef BBBORDERRADIUSPARSER_h
#define BBBORDERRADIUSPARSER_h

/// Provides the means to parse border-radius attribute in the format
/// border-radius: 25%;
/// or
/// border-radius: 25px;
typedef NS_ENUM(UInt8, RadiusType) { RadiusTypeAbsolute, RadiusTypePercentOfHeight };

@interface BBBorderRadiusParser : NSObject

/**
 * Parses an integer following the formats
 * border-radius: 25%;
 * or
 * border-radius: 25px;
 * and returns an integer value
 * @param value the border-radius attribute value.
 * @return An NSDictionary instance or nil if parsing of the value fails.
 *         The NSDictionary contains the radius type (key: "type") and
 *         the value (key: "value")
 */
- (NSDictionary*)parseBorderRadius:(NSString*)value;
@end

#endif /* BBBORDERRADIUSPARSER_h */
