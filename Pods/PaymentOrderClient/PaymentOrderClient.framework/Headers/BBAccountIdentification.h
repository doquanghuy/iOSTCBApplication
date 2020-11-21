//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef PaymentOrderClient_BBAccountIdentification_h
#define PaymentOrderClient_BBAccountIdentification_h

#import <CommonUtils/Additions.h>

#import <PaymentOrderClient/BBIdentification.h>

NS_ASSUME_NONNULL_BEGIN

/// This object is used to identify the debtor or creditor. In case of debtor only the Scheme Name 'ID' should be used in combination with a valid arrangement id.
@interface BBAccountIdentification : Additions

/// The identifier of the account. Can be a regular account number, or an ID.
@property (nonatomic, strong, readonly) BBIdentification *identification;

/// This is the name of the account, and not the name of the account holder.
@property (nonatomic, strong, readonly, nullable) NSString *name;

- (instancetype)initWithIdentification:(BBIdentification *)identification;

- (instancetype)initWithIdentification:(BBIdentification *)identification
                                  name:(nullable NSString *)name;

@end

NS_ASSUME_NONNULL_END

#endif
