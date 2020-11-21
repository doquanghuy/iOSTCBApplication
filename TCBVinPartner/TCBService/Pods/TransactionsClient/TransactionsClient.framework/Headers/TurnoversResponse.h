//
//  Created by Backbase R&D B.V. on 23/07/2018.
//

#import <CommonUtils/CommonUtils.h>
#import <TransactionsClient/IntervalDuration.h>

#ifndef TurnoversResponse_h
#define TurnoversResponse_h

@class TurnoverItem;

@interface TurnoversResponse : Additions

/// Reference to the arrangements to which the periodic balances belong
@property (nonatomic, strong, nullable, readonly) NSArray<NSString*> *arrangementIds;

/// Intervals duration (DAY, WEEK, MONTH, YEAR)
@property (nonatomic, nullable, readonly) IntervalDuration intervalDuration;

/// Average aggregated amount of the deposit transactions for the interval
@property (nonatomic, strong, nullable, readonly) BBCurrency *avgCreditAmount;

/// Average aggregated amount of the withdrawal transactions for the interval
@property (nonatomic, strong, nullable, readonly) BBCurrency *avgDebitAmount;

@property (nonatomic, strong, nullable, readonly) NSArray<__kindof TurnoverItem *> *turnovers;

@property (nonatomic, strong, nullable, readonly) NSArray<__kindof TurnoverItem *> *forecast;

@end

#endif
