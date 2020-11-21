//
//  ThemeJSONParser.h
//  Rorschach
//
//  Created by Backbase B.V. on 13/09/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ThemeEngine/ThemeEngine.h>

#ifndef THEMEENGINEJSONPARSER_CLASS
#define THEMEENGINEJSONPARSER_CLASS

/// Error Domain constant for this parser
extern const NSErrorDomain BBThemeEngineJSONParserErrorDomain;
typedef NS_ENUM(NSInteger, BBThemeEngineJSONParserErrors) {
    /// Has been a problem readin the rule file
    kBBThemeEngineJSONParserErrorIOError = -1000,
    /// Has been a problem during the JSON parsing of the file
    kBBThemeEngineJSONParserErrorInvalidJSON = -1001,
};

/// Provides an implementation that read JSON rules from a custom format
@interface BBThemeEngineJSONParser : NSObject <ThemeParser>
@end

#endif
