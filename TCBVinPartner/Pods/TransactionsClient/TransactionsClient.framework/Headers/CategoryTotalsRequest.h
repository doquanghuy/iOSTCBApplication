//
//  Created by Backbase R&D B.V. on 22/10/2018.
//

#import <CommonUtils/CommonUtils.h>
#import <TransactionsClient/IntervalDuration.h>
#import <TransactionsClient/BBTransactionCreditDebitIndicator.h>

#ifndef CategoryTotalsRequest_h
#define CategoryTotalsRequest_h

@interface CategoryTotalsRequest : Additions

// Flag to determine if credit or debit transactions will be aggregated (one of DBIT, CRDT)
@property (nonatomic, nonnull, readonly) BBTransactionCreditDebitIndicator creditDebitIndicator;

// Date of the income/spending evaluation period start
@property (nonatomic, strong, nonnull, readonly) NSDate *periodStartDate;

// Date of the income/spending evaluation period end
@property (nonatomic, strong, nonnull, readonly) NSDate *periodEndDate;

// Reference to the arrangements to which the income/spending analysis belong
@property (nonatomic, strong, nullable, readonly) NSArray<NSString *> *arrangementIds;

// Length of each periodic interval (one of DAY, WEEK, MONTH, YEAR - default: MONTH).
@property (nonatomic, nullable, readonly) IntervalDuration intervalDuration;

// If this is present the responce will have all child categories of that parent
@property (nonatomic, strong, nullable, readonly) NSString *parentCategory;

/**
 * Create an CategoryTotalsRequest object for a GET request.
 * @param creditDebitIndicator Flag to determine if credit or debit transactions will be aggregated (one of DBIT, CRDT).
 * @param periodStartDate Date of the income/spending evaluation period start.
 * @param periodEndDate Date of the income/spending evaluation period end.
 * @return The initialized CategoryTotalsRequest object.
 */
- (nonnull instancetype)initWithCreditDebitIndicator:(nonnull BBTransactionCreditDebitIndicator)creditDebitIndicator
                                     periodStartDate:(nonnull NSDate *)periodStartDate
                                       periodEndDate:(nonnull NSDate *)periodEndDate;

/**
 * Create an CategoryTotalsRequest object for a GET request.
 * @param creditDebitIndicator Flag to determine if credit or debit transactions will be aggregated (one of DBIT, CRDT).
 * @param periodStartDate Date of the income/spending evaluation period start.
 * @param periodEndDate Date of the income/spending evaluation period end.
 * @param arrangementIds Reference to the arrangements to which the income/spending analysis belong.
 * @param intervalDuration Length of each periodic interval (one of DAY, WEEK, MONTH, YEAR - default: MONTH).
 * @param parentCategory If this is present the responce will have all child categories of that parent.
 * @return The initialized CategoryTotalsRequest object.
 */
- (nonnull instancetype)initWithCreditDebitIndicator:(nonnull BBTransactionCreditDebitIndicator)creditDebitIndicator
                                     periodStartDate:(nonnull NSDate *)periodStartDate
                                       periodEndDate:(nonnull NSDate *)periodEndDate
                                      arrangementIds:(nullable NSArray<NSString *> *)arrangementIds
                                    intervalDuration:(nullable IntervalDuration)intervalDuration
                                      parentCategory:(nullable NSString *)parentCategory;

@end

#endif
