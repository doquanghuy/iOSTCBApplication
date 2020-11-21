//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBInvestmentAccount_h
#define ProductsClient_BBInvestmentAccount_h

#import <CommonUtils/CommonUtils.h>
#import <ProductsClient/BBBaseProduct.h>

NS_ASSUME_NONNULL_BEGIN

/// Investment account product.
@interface BBInvestmentAccount : BBBaseProduct

/// Current investment value, applicable to investments
@property (weak, nonatomic, readonly, nullable) NSDecimalNumber *currentInvestmentValue;

/// Currency code.
@property (strong, nonatomic, readonly, nullable) NSString *currency;

/// Whether this product allows urgent transfers. Type: Boolean
@property (assign, nonatomic, readonly) BOOL urgentTransferAllowed;

/// The number identifying the contract.
@property (strong, nonatomic, readonly, nullable) NSString *productNumber;

/// Specifying the IBAN of the account.
@property (strong, nonatomic, readonly, nullable) NSString *IBAN;

/// Specifying the BBAN of the account.
@property (strong, nonatomic, readonly, nullable) NSString *BBAN;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBInvestmentAccount_h */
