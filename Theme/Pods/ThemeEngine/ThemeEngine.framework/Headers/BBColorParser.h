//
//  BBColorParser.h
//  Rorschach
//
//  Created by Backbase B.V. on 15/01/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef BBCOLORPARSER_CLASS
#define BBCOLORPARSER_CLASS

/// Provides the means to parse colors in the format #[A]RGB

@interface BBColorParser : NSObject

/**
 * Parses a string following the format #[A]RGB, and returns a UIColor instance if successful. nil otherwise.
 * @param value String containing the Hexadecimal representation of the color
 * @return A UIColor instance based on the hex representation or nil if it does not comply with the format.
 */
- (UIColor*)parseColor:(NSString*)value;
@end

#endif

NS_ASSUME_NONNULL_END
