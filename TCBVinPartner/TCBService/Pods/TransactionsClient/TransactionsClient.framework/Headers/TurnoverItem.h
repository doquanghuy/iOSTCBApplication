//
//  Created by Backbase R&D B.V. on 23/07/2018.
//

#import <CommonUtils/CommonUtils.h>

#ifndef TurnoverItem_h
#define TurnoverItem_h

@interface TurnoverItem : Additions

/// Date string of starting point for interval
@property (nonatomic, strong, nonnull, readonly) NSString *intervalStartDate;

/// Aggregated amount of the deposit transactions for the interval
@property (nonatomic, strong, nonnull, readonly) BBCurrency *creditAmount;

/// Aggregated amount of the withdrawal transactions for the interval
@property (nonatomic, strong, nonnull, readonly) BBCurrency *debitAmount;

/// Resulted balance for the interval
@property (nonatomic, strong, nonnull, readonly) BBCurrency *balance;

/* Convenience method that converts intervalStartDate property into the given or default date format.
* @param dateFormat date-time format  to parse the intervalStartDate object into.
* Default value: `yyyy-MM-dd`.
* Assign dateFormat once the DBS changes this default format to another date-time format.
* @return parsed date object for intervalStartDate.
*/
- (NSDate * _Nullable)intervalStartDateWithFormat:(NSString * _Nullable)dateFormat   __attribute__((swift_name("intervalStartDate(format:)")));
@end

#endif
