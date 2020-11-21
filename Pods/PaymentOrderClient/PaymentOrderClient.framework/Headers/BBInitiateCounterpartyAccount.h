//
//  Created by Backbase R&D B.V. on 23/10/2019.
//

#ifndef PaymentOrderClient_BBInitiateCounterpartyAccount_h
#define PaymentOrderClient_BBInitiateCounterpartyAccount_h

#import <PaymentOrderClient/BBAccountIdentification.h>
#import <PaymentOrderClient/BBAccountType.h>

NS_ASSUME_NONNULL_BEGIN

/// Class describing the original account identification plus the type of account if applicable.
@interface BBInitiateCounterpartyAccount : BBAccountIdentification

/// The type of the account.
@property (nonatomic, strong, nullable) BBAccountType accountType;

- (instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithIdentification:(nonnull BBIdentification *)identification
                                          name:(nullable NSString *)name
                                   accountType:(nullable BBAccountType)accountType;

@end

NS_ASSUME_NONNULL_END

#endif
