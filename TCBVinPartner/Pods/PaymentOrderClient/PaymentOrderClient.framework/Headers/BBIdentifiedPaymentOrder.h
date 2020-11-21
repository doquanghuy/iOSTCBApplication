//
//  Created by Backbase R&D B.V. on 04/09/2018.
//

#ifndef PaymentOrderClient_BBIdentifiedPaymentOrder_h
#define PaymentOrderClient_BBIdentifiedPaymentOrder_h

#import <PaymentOrderClient/BBValidatedPaymentOrder.h>
#import <PaymentOrderClient/BBApprovalStatus.h>
#import <PaymentOrderClient/BBAction.h>

NS_ASSUME_NONNULL_BEGIN

/// Response DTO used while retrieving a list of payment orders.
@interface BBIdentifiedPaymentOrder : BBValidatedPaymentOrder

/// Unique identification of the payment order.
@property (nonatomic, strong, readonly) NSString *identifier;

/// The id of the approval request that is or was used to get this item approved.
@property (nonatomic, strong, readonly, nullable) NSString *approvalId;

/// The options for approval.
@property (nonatomic, strong, readonly) BBApprovalStatus status;

/// Internal status of the payment order in the core banking system.
@property (nonatomic, strong, readonly, nullable) NSString *bankStatus;

/// Reason code the core banking system accepted/rejected the payment.
@property (nonatomic, strong, readonly, nullable) NSString *reasonCode;

@property (nonatomic, strong, readonly, nullable) NSString *reasonText;

@property (nonatomic, strong, readonly, nullable) NSString *errorDescription;

@property (nonatomic, strong, readonly, nullable) NSString *createdBy;

@property (nonatomic, weak, readonly, nullable) NSDate *createdAt;

@property (nonatomic, strong, readonly, nullable) NSArray<BBAction> *actions;

@property (nonatomic, strong, readonly) NSNumber *version;

@end

NS_ASSUME_NONNULL_END

#endif
