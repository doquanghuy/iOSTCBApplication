//
//  Created by Backbase R&D B.V. on 13/02/2018.
//

#import <Foundation/Foundation.h>

#ifndef NSString_Backbase_h
#define NSString_Backbase_h

/// NSString extension class that has convenience methods for string conversions.
@interface NSString (Backbase)

/**
 Return a string with all white space and new lines removed.

 @return A NSString object.
*/
- (NSString * _Nullable)bb_stringByRemovingWhitespaceAndNewlineCharacters;

/**
 Convert a string into a date using the current locale and format supplied
 
 @return A NSDate object.
 */
- (NSDate * _Nullable)bb_toDateWithFormat:(NSString * _Nonnull)format;

/**
 Convert a string into a date using the format & locale supplied
 
 @return A NSDate object.
 */
- (NSDate * _Nullable)bb_toDateWithFormat:(NSString * _Nonnull)format usingLocale:(NSLocale * _Nonnull)locale;

/**
 Convert a string using the ISO 8601 date format.
 
 @return A NSDate object.
 */
- (NSDate * _Nullable)bb_toDate;

/**
 Convert a string into a number using the default locale.
 
 @return A NSNumber object.
 */
- (NSNumber * _Nullable)bb_toNumber;

/**
 Convert a string into a number using the provided locale.
 
 @return A NSNumber object.
 */
- (NSNumber * _Nullable)bb_toNumberUsingLocale:(NSLocale * _Nonnull)locale;

@end

#endif /* NSString_Backbase_h */
