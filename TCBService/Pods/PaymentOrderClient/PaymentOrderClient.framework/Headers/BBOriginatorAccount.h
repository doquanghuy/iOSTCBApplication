//
//  Created by Backbase R&D B.V. on 18/10/2019.
//

#ifndef PaymentOrderClient_BBOriginatorAccount_h
#define PaymentOrderClient_BBOriginatorAccount_h

#import <PaymentOrderClient/BBIdentifiable.h>

NS_ASSUME_NONNULL_BEGIN

/// Class representing the original account identification plus the arrangement if applicable.
@interface BBOriginatorAccount : BBIdentifiable

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithAccountIdentification:(nonnull BBAccountIdentification *)accountIdentification NS_UNAVAILABLE;

- (instancetype)initWithIdentification:(BBIdentification *)identification NS_UNAVAILABLE;

- (instancetype)initWithIdentification:(BBIdentification *)identification
                                  name:(nullable NSString *)name NS_UNAVAILABLE;

- (nonnull instancetype)initWithAccountIdentification:(nonnull BBAccountIdentification *)accountIdentification
                                        arrangementId:(null_unspecified NSString *)arrangementId
                                externalArrangementId:(nullable NSString *)externalArrangementId;

- (nonnull NSString *)arrangementId;

NS_ASSUME_NONNULL_END

@end

#endif /* PaymentOrderClient_BBOriginatorAccount_h */
