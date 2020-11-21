//
//  Created by Backbase R&D B.V. on 04/09/2018.
//

#ifndef PaymentOrderClient_BBValidatedPaymentOrder_h
#define PaymentOrderClient_BBValidatedPaymentOrder_h

#import <PaymentOrderClient/BBInvolvedParty.h>
#import <PaymentOrderClient/BBOriginatorAccount.h>
#import <PaymentOrderClient/BBInstructionPriority.h>
#import <PaymentOrderClient/BBPaymentMode.h>
#import <PaymentOrderClient/BBSchedule.h>
#import <PaymentOrderClient/BBIdentifiedTransaction.h>
#import <CommonUtils/CommonUtils.h>

/// Subclass of the full response DTO when a user gets a list of payment orders
@interface BBValidatedPaymentOrder : Additions

/// Generated when the PISP sets up the payments before the Backbase authorization flow.
@property (nonatomic, strong, readonly, nullable) NSString *paymentSetupId;

/// Generated when the PISP submits the payment which is after the Backbase authorization flow.
@property (nonatomic, strong, readonly, nullable) NSString *paymentSubmissionId;

/// The identification of the originator party.
@property (nonatomic, strong, readonly, nullable) BBInvolvedParty *originator;

/// The originator Account is the original account identification plus the arrangement if applicable.
@property (nonatomic, strong, readonly, nullable) BBOriginatorAccount *originatorAccount;

/// Indicate whenever there should be only one debit posting for the whole set of instructions.
@property (nonatomic, readonly) BOOL batchBooking;

/// Specify the priority of execution of the payment order.
@property (nonatomic, strong, readonly, nullable) BBInstructionPriority instructionPriority;

/// The preferred date for the payment order to be executed.
@property (nonatomic, weak, readonly, nullable) NSDate *requestedExecutionDate;

/// Denotes whether payment will be single or will be recurring.
@property (nonatomic, strong, readonly, nullable) BBPaymentMode paymentMode;

/// The type of payment.
@property (nonatomic, strong, readonly, nullable) NSString *paymentType;

/// Schedule for recurring transfer. Mandatory if paymentMode is RECURRING
@property (nonatomic, strong, readonly, nullable) BBSchedule *schedule;

/// The object defining the identified transaction, which means the creditor will have a arrangementId where applicable.
@property (nonatomic, strong, readonly, nullable) BBIdentifiedTransaction *transferTransactionInformation;

@property (nonatomic, strong, readonly, nullable) BBCurrency *totalAmount;

@end

#endif
