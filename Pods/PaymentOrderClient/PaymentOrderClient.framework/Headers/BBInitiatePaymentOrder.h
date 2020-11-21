//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef PaymentOrderClient_BBInitiatePaymentOrder_h
#define PaymentOrderClient_BBInitiatePaymentOrder_h

#import <CommonUtils/CommonUtils.h>
#import <PaymentOrderClient/BBAccountIdentification.h>
#import <PaymentOrderClient/BBInstructionPriority.h>
#import <PaymentOrderClient/BBPaymentMode.h>
#import <PaymentOrderClient/BBSchedule.h>
#import <PaymentOrderClient/BBInitiateTransaction.h>

NS_ASSUME_NONNULL_BEGIN

/// Request DTO for creating a payment order
@interface BBInitiatePaymentOrder : Additions

/// The preferred date for the payment order to be executed.
@property (nonatomic, weak) NSDate *requestedExecutionDate;

/// Indicate whenever there should be only one debit posting for the whole set of instructions.
@property (nonatomic) BOOL batchBooking;

/// The identified originator account with arrangement id.
@property (nonatomic, strong, nullable) BBAccountIdentification *originatorAccount;

/// Specify the priority of execution of the payment order.
@property (nonatomic, strong, nullable) BBInstructionPriority instructionPriority;

/// Denotes whether payment will be single or will be recurring.
@property (nonatomic, strong, nullable) BBPaymentMode paymentMode;

/// The type of payment.
@property (nonatomic, strong, nullable) NSString *paymentType;

/// Schedule for recurring transfer. Mandatory if paymentMode is RECURRING.
@property (nonatomic, strong, nullable) BBSchedule *schedule;

/// The object defining the transaction to be initiated.
@property (nonatomic, strong, nullable) BBInitiateTransaction *transferTransactionInformation;

/// When set to true, the submitted payment order will also be approved by the user.
@property (nonatomic, strong, nullable) NSNumber *approved;

/**
 * Create a new BBInitiatePaymentOrder object.
 * @param requestedExecutionDate The preferred date for the payment order to be executed.
 * @return Initialised BBInitiatePaymentOrder object.
 */
- (instancetype)initWithRequestedExecutionDate:(NSDate *)requestedExecutionDate;

/**
 * Create a new BBInitiatePaymentOrder object.
 * @param requestedExecutionDate Date specifying the preferred date for the payment order to be executed.
 * @param batchBooking Bool indicating whenever there should be only one debit posting for the whole set of instructions.
 * @param originatorAccount BBAccountIdentification which is the identified originator account with arrangement id.
 * @param instructionPriority BBInstructionPriority specifying the priority of execution of the payment order.
 * @param paymentMode BBPaymentMode which denotes whether payment will be single or will be recurring.
 * @param paymentType NSString specifying the type of payment.
 * @param schedule BBSchedule for recurring transfer. Mandatory if paymentMode is RECURRING.
 * @param transferTransactionInformation BBInitiateTransaction defining the transaction to be initiated.
 * @param approved When set to true, the submitted payment order will also be approved by the user.
 * @return Initialised BBInitiatePaymentOrder object.
 */
- (instancetype _Nonnull)initWithRequestedExecutionDate:(NSDate *)requestedExecutionDate
                                           batchBooking:(BOOL)batchBooking
                                      originatorAccount:(nullable BBAccountIdentification *)originatorAccount
                                    instructionPriority:(nullable BBInstructionPriority)instructionPriority
                                            paymentMode:(nullable BBPaymentMode)paymentMode
                                            paymentType:(nullable NSString *)paymentType
                                               schedule:(nullable BBSchedule *)schedule
                         transferTransactionInformation:(nullable BBInitiateTransaction *)transferTransactionInformation
                                               approved:(nullable NSNumber *)approved;

@end

NS_ASSUME_NONNULL_END

#endif
