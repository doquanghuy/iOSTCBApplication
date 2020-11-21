//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#import <Foundation/Foundation.h>

//! Project version number for PaymentOrderClient.
FOUNDATION_EXPORT double PaymentOrderClientVersionNumber;

//! Project version string for PaymentOrderClient.
FOUNDATION_EXPORT const unsigned char PaymentOrderClientVersionString[];

#import <PaymentOrderClient/TypeDefinitions.h>
#import <PaymentOrderClient/ExternalAccountsContract.h>
#import <PaymentOrderClient/PaymentOrderClientContract.h>

/**
 The client implementing the DBSClient interface with the responsibility of
 loading and parsing payments data provided by the given DBSDataProvider.
 */
@interface PaymentOrderClient: BBBaseClient <PaymentOrderClientContract, ExternalAccountsContract, RecipientContract>

/// The last path component of the payment orders endpoint. It defaults to `payment-orders`
@property (nonatomic, copy, nonnull, class) NSString *paymentOrderPath;

/// The last path component of the external accounts endpoint. It defaults to `external-accounts`
@property (nonatomic, copy, nonnull, class) NSString *externalAccountsPath;

///
/// Creates an instance of 'PaymentOrderClient' with the provided path configurations.
///
/// @param paymentOrderClientPath The path configuration for the payment order APIs. Pass `nil` if you want the client to
/// use a default path configuration.
/// @param externalAccountsClientPath The path configuration for the external accounts APIs. Pass `nil` if you want the client to
/// use a default path configuration.
/// @return The initialized 'PaymentOrderClient' object.
///
- (nonnull instancetype)initWithPaymentOrderClientPath:(nullable BBDbsClientPath *)paymentOrderClientPath
                            externalAccountsClientPath:(nullable BBDbsClientPath *)externalAccountsClientPath;

@end
