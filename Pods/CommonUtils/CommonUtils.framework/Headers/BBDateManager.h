//
//  Created by Backbase R&D B.V. on 03/01/2019.
//

#import <Foundation/Foundation.h>

#ifndef CommonUtils_BBDateFormat_h
#define CommonUtils_BBDateFormat_h

typedef NSString * BBDateFormat NS_TYPED_ENUM;

static BBDateFormat const _Nonnull bbISOOffsetDateFormatWithMilliseconds = @"yyyy-MM-dd'T'HH:mm:ss.SSSXXX";
static BBDateFormat const _Nonnull bbFullDateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SZ";
static BBDateFormat const _Nonnull bbMediumDateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
static BBDateFormat const _Nonnull bbShortDateFormat = @"yyyy-MM-dd";
static BBDateFormat const _Nonnull bbUSDateFormat = @"MM/dd/yyyy";
static BBDateFormat const _Nonnull bbDescriptiveDateFormat = @"MMM d, yyyy";

#endif

#ifndef CommonUtils_BBDateManager_h
#define CommonUtils_BBDateManager_h

/// Date parser class for the date strings that are received from the backend.
@interface BBDateManager : NSObject

/// Shared instance.
+ (nonnull instancetype)shared;

/**
 * Locale used by date formatter to format the date. The default locale is "UTC".
 * @return NSLocale object.
 */
@property (strong, nonatomic, nonnull) NSLocale *locale;

/**
 * Receives a string date, formats the date using the given format and returns the formatted string date
 * @param dateString The date to be formatted
 * @param dateFormat The format of the date
 * @return Returns a string date formatted using the given format
 */
- (nullable NSString *)formattedDateString:(nonnull NSString *)dateString usingFormat:(nonnull BBDateFormat)dateFormat;

/**
 * Receives a date, formats the date using the given format and returns the formatted string date
 * @param date The date to be converted to string and formatted
 * @param dateFormat The format of the date
 * @return Returns a string date formatted using the given format
 */
- (nullable NSString *)formattedDateStringFrom:(nonnull NSDate*)date usingFormat:(nonnull BBDateFormat)dateFormat;

/**
 * Receives a date string, formats the date using the given format and returns a date
 * @param dateString The date string to be formatted using the given format
 * @param dateFormat The format of the date
 * @return Returns a date formatted using the given format
 */
- (nullable NSDate *)formattedDateFrom:(nonnull NSString*)dateString usingFormat:(nonnull BBDateFormat)dateFormat;

/**
 * Receives a date string, removes the time from the date and returns a date without time
 * @param dateString The date string to remove the time information and to be converted to date
 * @return Returns a date without time information
 */
- (nullable NSDate *)dateWithoutTimeFromDateString:(nonnull NSString*)dateString;

/**
 * Check if the first given date is between startDate and endDate
 * @param date The date to be checked if is between the range
 * @param startDate The start date in the comparison range
 * @param endDate The end date in the comparison range
 * @return Returns a boolean value to say if the date is between the given range or not
 */
- (BOOL)isDate:(nonnull NSDate*)date betweenStartDate:(nonnull NSDate*)startDate andEndDate:(nonnull NSDate*)endDate;

@end

#endif /* BBDateManager_h */
