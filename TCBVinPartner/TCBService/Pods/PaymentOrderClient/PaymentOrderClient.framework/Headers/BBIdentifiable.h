//
//  Created by Backbase R&D B.V. on 04/09/2018.
//

#ifndef PaymentOrderClient_BBIdentifiable_h
#define PaymentOrderClient_BBIdentifiable_h

#import <PaymentOrderClient/BBAccountIdentification.h>

/// The arrangement identification.
@interface BBIdentifiable : BBAccountIdentification

/// The unique arrangement id.
@property (nonatomic, strong, readonly, nullable) NSString *arrangementId;

/// The external unique arrangement id.
@property (nonatomic, strong, readonly, nullable) NSString *externalArrangementId;

- (nonnull instancetype)initWithAccountIdentification:(nonnull BBAccountIdentification *)accountIdentification;

- (nonnull instancetype)initWithAccountIdentification:(nonnull BBAccountIdentification *)accountIdentification
                                        arrangementId:(nullable NSString *)arrangementId
                                externalArrangementId:(nullable NSString *)externalArrangementId;

@end

#endif
