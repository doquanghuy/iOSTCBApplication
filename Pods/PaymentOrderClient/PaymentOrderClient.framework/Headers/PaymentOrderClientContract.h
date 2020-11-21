//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBIdentifiedPaymentOrder;
@class BBInitiatePaymentOrder;
@class BBPaymentOrdersPostResponse;

typedef void(^RetrievePaymentOrderHandler)(NSArray<BBIdentifiedPaymentOrder *> * _Nullable, NSError * _Nullable);

typedef void(^CreatePaymentOrderHandler)(BBPaymentOrdersPostResponse * _Nullable, NSError * _Nullable);

typedef void(^DeletePaymentOrderHandler)(BOOL, NSError * _Nullable);

/// PaymentOrderClientContract protocol. The conforming object will receive the protocol's requests/events.
@protocol PaymentOrderClientContract <NSObject>

@required

/**
 * Retrieves an array of BBIdentifiedPaymentOrder objects for the given parameters.
 * @param parameters An NSDictionary with the desired parameters.
 * @param completionHandler A completion handler that contains either an array of identified payment orders,
 * or an error object with information if the request failed.
 */
- (void)retrievePaymentOrdersWithParameters:(nullable NSDictionary<NSString*, NSString*> *)parameters
                          completionHandler:(nullable RetrievePaymentOrderHandler)completionHandler;
/**
 * Starts a new payment order initiation process with the given BBInitiatePaymentOrder object.
 * @param initiatePaymentOrder A BBInitiatePaymentOrder that is the desired payment order to be initiated.
 * @param completionHandler A completion handler that contains either a BBPaymentOrdersPostResponse object,
 * or an error object with information if the request failed.
 */
- (void)createPaymentOrderWithInitiatePaymentOrder:(nonnull BBInitiatePaymentOrder *)initiatePaymentOrder
                                 completionHandler:(nullable CreatePaymentOrderHandler)completionHandler;
/**
 * Deletes a payment order with specific identifier
 * @param identifier A NSString indicating the payment order identifier
 * @param version A NSNumber indicating the payment order version
 * @param completionHandler A completion handler that contains either a Boolean value indicating if the deletion was successful,
 * or an NSError describing what went wrong.
*/
-(void)deletePaymentOrderWithIdentifier:(nonnull NSString*)identifier
                                version:(nonnull NSNumber*)version
                      completionHandler:(nullable DeletePaymentOrderHandler)completionHandler;

@end
