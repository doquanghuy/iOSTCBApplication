//
//  Created by Backbase R&D B.V. on 20/12/2017.
//

#import <Foundation/Foundation.h>

#ifndef NSDate_Backbase_h
#define NSDate_Backbase_h

/// NSDate extension class that has convenience methods for date conversion operations.
@interface NSDate (Backbase)

/**
 Converts a GMT date into a local date by calculating the time difference between these time zones and adding the difference in seconds.

 @return A NSDate object.
*/
- (NSDate * _Nullable)bb_toLocalDate;

/**
 Check if the date is today.
 
 @return A boolean indicating if the date is yesterday.
 */
- (BOOL)bb_isToday;

/**
 Check if the date is yesterday.
 
 @return A boolean indicating if the date is yesterday.
 */
- (BOOL)bb_isYesterday;

/**
 Gets the difference from instance date to provided date in calendar units

 @return A NSInteger with the difference in the provided units.
 */
- (NSInteger)bb_differenceToDate:(NSDate* _Nonnull)date inUnits:(NSCalendarUnit)units;

/**
 Adds an amount of units to the instance date

 @return A new date with the addition of the n units
 */
- (NSDate* _Nullable)bb_dateByAdding:(NSInteger)amount inUnits:(NSCalendarUnit)units;

/**
 @return A new date without time
 */
-(NSDate* _Nullable)bb_truncateTime;

@end

#endif /* NSDate_Backbase */
