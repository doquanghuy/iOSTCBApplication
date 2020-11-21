//
//  Created by Backbase R&D B.V. on 1/29/20.
//

#ifndef BBTransactionMerchant_h
#define BBTransactionMerchant_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// Response class that contains the representation of a merchant for transaction item.
@interface BBTransactionMerchant : Additions

/// Merchant id
@property (nonatomic, readonly) NSInteger identifier;

/// Merchant name
@property (strong, nonatomic, readonly) NSString *name;

/// Merchant logo URL
@property (weak, nonatomic, readonly, nullable) NSURL *logo;

/// Merchant website URL
@property (weak, nonatomic, readonly, nullable) NSURL *website;

@end

NS_ASSUME_NONNULL_END

#endif
