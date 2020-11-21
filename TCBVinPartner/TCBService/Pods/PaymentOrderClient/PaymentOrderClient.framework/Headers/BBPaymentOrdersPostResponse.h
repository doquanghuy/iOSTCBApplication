//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef PaymentOrderClient_BBPaymentOrdersPostResponse_h
#define PaymentOrderClient_BBPaymentOrdersPostResponse_h

#import <CommonUtils/Additions.h>

#import <PaymentOrderClient/BBApprovalStatus.h>

NS_ASSUME_NONNULL_BEGIN

///Response DTO used when a user sends a POST request
@interface BBPaymentOrdersPostResponse : Additions

@property (nonatomic, strong, readonly) NSString *identifier;

/// The options for approval.
@property (nonatomic, strong, readonly) BBApprovalStatus status;

/// Internal status of the payment order in the core banking system.
@property (nonatomic, strong, readonly, nullable) NSString *bankStatus;

/// Reason code the core banking system accepted/rejected the payment.
@property (nonatomic, strong, readonly, nullable) NSString *reasonCode;

/// Human readable reason the core banking system accepted/rejected the payment.
@property (nonatomic, strong, readonly, nullable) NSString *reasonText;

/// Additional information from the core banking system on why the payment was refused.
@property (nonatomic, strong, readonly, nullable) NSString *errorDescription;

/// The execution date of the payment that the core system calculated.
@property (nonatomic, strong, readonly, nullable) NSDate *nextExecutionDate;

/// Generated when the PISP sets up the payments before the Backbase authorization flow.
@property (nonatomic, strong, readonly, nullable) NSString *paymentSetupId;

/// Generated when the PISP submits the payment which is after the Backbase authorization flow.
@property (nonatomic, strong, readonly, nullable) NSString *paymentSubmissionId;

@end

NS_ASSUME_NONNULL_END

#endif
