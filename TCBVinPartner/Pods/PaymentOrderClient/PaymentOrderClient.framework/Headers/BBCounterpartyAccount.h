//
//  Created by Backbase R&D B.V. on 23/10/2019.
//

#ifndef PaymentOrderClient_BBCounterpartyAccount_h
#define PaymentOrderClient_BBCounterpartyAccount_h

#import <PaymentOrderClient/BBIdentifiable.h>
#import <PaymentOrderClient/BBAccountType.h>

NS_ASSUME_NONNULL_BEGIN

/// Class that is representing the original account identification plus the arrangement if applicable.
@interface BBCounterpartyAccount : BBIdentifiable

/// The type of the account.
@property (nonatomic, strong, readonly, nullable) BBAccountType accountType;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

#endif /* PaymentOrderClient_BBCounterpartyAccount_h */
