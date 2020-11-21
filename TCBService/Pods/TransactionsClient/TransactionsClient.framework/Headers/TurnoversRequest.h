//
//  Created by Backbase R&D B.V. on 22/10/2018.
//

#import <CommonUtils/CommonUtils.h>
#import <TransactionsClient/IntervalDuration.h>
#import <TransactionsClient/BBTransactionForecast.h>

#ifndef TurnoversRequest_h
#define TurnoversRequest_h

@interface TurnoversRequest : Additions

// Date of the income/spending evaluation period start
@property (nonatomic, strong, nonnull, readonly) NSDate *periodStartDate;

// Date of the income/spending evaluation period end
@property (nonatomic, strong, nonnull, readonly) NSDate *periodEndDate;

// Length of each periodic interval (one of DAY, WEEK, MONTH, YEAR - default: MONTH).
@property (nonatomic, nonnull, readonly) IntervalDuration intervalDuration;

// Reference to the arrangements to which the income/spending analysis belong
@property (nonatomic, strong, nullable, readonly) NSArray<NSString *> *arrangementIds;

// If this is present the responce will have all child categories of that parent
@property (nonatomic, strong, nullable, readonly) NSNumber *intervalStartDay;

// Add a new Forecast period at the end of the selected period. (one of NONE, AVG - default: NONE).
@property (nonatomic, nullable, readonly) BBTransactionForecast forecast;

/**
 * Create an TurnoversRequest object for a GET request.
 * @param intervalDuration Length of each periodic interval (one of DAY, WEEK, MONTH, YEAR - default: MONTH).
 * @param periodStartDate Date of the income/spending evaluation period start.
 * @param periodEndDate Date of the income/spending evaluation period end.
 * @return The initialized TurnoversRequest object.
 */
- (nonnull instancetype)initWithIntervalDuration:(nonnull IntervalDuration)intervalDuration
                                 periodStartDate:(nonnull NSDate *)periodStartDate
                                   periodEndDate:(nonnull NSDate *)periodEndDate;

/**
 * Create an TurnoversRequest object for a GET request.
 * @param intervalDuration Length of each periodic interval (one of DAY, WEEK, MONTH, YEAR - default: MONTH).
 * @param periodStartDate Date of the income/spending evaluation period start.
 * @param periodEndDate Date of the income/spending evaluation period end.
 * @param arrangementIds Reference to the arrangements to which the income/spending analysis belong.
 * @param intervalStartDay If this is present the responce will have all child categories of that parent
 * @param forecast Add a new Forecast period at the end of the selected period. (one of NONE, AVG - default: NONE)
 * @return The initialized TurnoversRequest object.
 */
- (nonnull instancetype)initWithIntervalDuration:(nonnull IntervalDuration)intervalDuration
                                 periodStartDate:(nonnull NSDate *)periodStartDate
                                   periodEndDate:(nonnull NSDate *)periodEndDate
                                  arrangementIds:(nullable NSArray<NSString *> *)arrangementIds
                                intervalStartDay:(nullable NSNumber *)intervalStartDay
                                        forecast:(nullable BBTransactionForecast)forecast;

@end

#endif
