//
//  BBFontFamilyParser.h
//  Rorschach
//
//  Created by Backbase B.V. on 27/03/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef BBFONTFAMILYPARSER_CLASS
#define BBFONTFAMILYPARSER_CLASS

/// Provides the means to parse font family

@interface BBFontFamilyParser : NSObject

/**
 * Parses a css like formatted font-family attribute value.
 * @param value String containing the value of the font-family attribute.
                This is a list of font names.
 * @return the first name in the list that is available on the system.
 */
- (NSString*)parseFontFamily:(NSString*)value;

@end

#endif

NS_ASSUME_NONNULL_END
