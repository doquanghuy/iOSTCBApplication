//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef PaymentOrderClient_BBSchedule_h
#define PaymentOrderClient_BBSchedule_h

#import <CommonUtils/CommonUtils.h>

#import <PaymentOrderClient/BBExecutionStrategy.h>
#import <PaymentOrderClient/BBTransferFrequency.h>

NS_ASSUME_NONNULL_BEGIN

/// Class for schedule for recurring transfer. Mandatory if paymentMode is RECURRING
@interface BBSchedule : Additions

/// Strategy for executing payments on non-working days.
@property (nonatomic, strong, nullable) BBExecutionStrategy nonWorkingDayExecutionStrategy;

/// Denotes how frequently the transfer should be made.
@property (nonatomic, strong) BBTransferFrequency transferFrequency;

/// Denotes day on which transfer should be executed. For weekly it will be 1..7 indicating weekday. For monthly it will be 1..31 indicating day of month. For yearly it will be 1..12 indicating month of the year.
@property (nonatomic, strong) NSNumber *on;

/// When to start executing the schedule. First transfer will be executed on first calculated date by schedule after this date.
@property (nonatomic, weak) NSDate *startDate;

/// When to stop transfers. Transfers will not be executed after this date. Only one of endDate and repeat is possible. If neither repeat nor endDate is provided transfer will be executed until canceled.
@property (nonatomic, weak, nullable) NSDate *endDate;

/// Number of transfer to be executed. Only one of endDate and repeat is possible. If neither repeat nor endDate is provided transfer will be executed until canceled.
@property (nonatomic, strong, nullable) NSNumber *repeat;

/// Indicates skip interval of transfer. 1 would mean execute every time, 2 - every other time.
@property (nonatomic, strong) NSNumber *every;

/// Date when the next payment will be executed, taking in consideration bank holidays and cut-off times. It will be only retrieved when getting payments, it will be dismissed when creating or updating.
@property (nonatomic, weak, nullable) NSDate *nextExecutionDate;

- (instancetype)initWithTransferFrequency:(BBTransferFrequency)transferFrequency
                                       on:(NSNumber *)on
                                startDate:(NSDate *)startDate
                                    every:(NSNumber *)every;

- (instancetype)initWithNonWorkingDayExecutionStrategy:(nullable BBExecutionStrategy)nonWorkingDayExecutionStrategy
                                     transferFrequency:(BBTransferFrequency)transferFrequency
                                                    on:(NSNumber *)on
                                             startDate:(NSDate *)startDate
                                               endDate:(nullable NSDate *)endDate
                                                repeat:(nullable NSNumber *)repeat
                                                 every:(NSNumber *)every
                                     nextExecutionDate:(nullable NSDate *)nextExecutionDate;


@end

NS_ASSUME_NONNULL_END

#endif
