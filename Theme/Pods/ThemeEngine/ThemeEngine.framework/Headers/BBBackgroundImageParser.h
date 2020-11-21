//
//  BBBackgroundImageParser.h
//  Rorschach
//
//  Created by Backbase B.V. on 29/03/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef BBBACKGROUNDIMAGEPARSER_CLASS
#define BBBACKGROUNDIMAGEPARSER_CLASS

typedef NS_ENUM(UInt8, BackgroundType) {
    BackgroundTypeNone,
    BackgroundTypeURL,
    BackgroundTypeDefaultGradient,
    BackgroundTypeGradientWithDirection
};

/// Provides the means to parse background-image attribute in the format url("path/to/resource")
@interface BBBackgroundImageParser : NSObject

/**
 * Parses a string following the format "url('path/to/resource')", and returns a UIImage.
 * @param value the background-image attribute value.
 * @return A UIImage instance or nil if parsing of the value fails.
 */
- (UIImage*)parseBackgroundImage:(NSString*)value;

/**
 * return the Background type based on the regex matcher.
 * @param match the NSTextCheckingResult of the provided value passed from data source.
 * @return the Background type based on the matcher.
 */
- (BackgroundType)backgroundType:(NSTextCheckingResult*)match;

/**
 * return regex matcher based on the provided value.
 * @param value provided value passed from data source(JSON, etc..).
 * @return return regex matcher based on the provided value.
 */
- (NSTextCheckingResult*)match:(NSString*)value;
@end

#endif

NS_ASSUME_NONNULL_END
