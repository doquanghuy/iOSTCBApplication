//
//  Created by Backbase R&D B.V. on 08/05/2019.
//

#ifndef ProductsClient_BBBalanceHistoryItem_h
#define ProductsClient_BBBalanceHistoryItem_h

#import <CommonUtils/CommonUtils.h>
#import "BBBalanceValue.h"

/// This class is a response class for a balance history item.
@interface BBBalanceHistoryItem : Additions

/// Date From with UTC.
@property (weak, nonatomic, nullable, readonly) NSString* dateFrom;

/// Date To with UTC. Private getter is nonnull.
@property (weak, nonatomic, nullable, readonly) NSString* dateTo;

/// Value Ptc
@property (strong, nonatomic, nullable, readonly) NSString* valuePtc;

/// Value
@property (strong, nonatomic, nonnull, readonly) BBBalanceValue* value;

/**
 * Convenience method that converts dateFrom property into the given or default date-time format.
 * @param dateFormat date-time format to parse the dateFrom object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for dateFrom.
 */
-(nullable NSDate*)dateFrom:(nullable NSString*)dateFormat;

/**
 * Convenience method that converts dateFrom property into the given or default date-time format.
 * @param dateFormat date-time format to parse the dateFrom object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for dateFrom.
 */
-(nullable NSDate*)dateTo:(nullable NSString*)dateFormat;

@end

#endif /* ProductsClient_BBBalanceHistoryItem_h */
