//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBInvestmentAccounts_h
#define ProductsClient_BBInvestmentAccounts_h

#import <ProductsClient/BBProductKind.h>
#import <ProductsClient/BBInvestmentAccount.h>

NS_ASSUME_NONNULL_BEGIN

/// Investment account product kind.
@interface BBInvestmentAccounts : Additions<BBProductKind>

/// The label/name that is used for the respective product kind.
@property (strong, nonatomic, readonly) NSString *name;

/// Defines a balance for the investment accounts.
@property (strong, nonatomic, readonly, nullable) BBAggregatedBalance *aggregatedBalance;

/// Products for the investment accounts.
@property (strong, nonatomic, readonly, nullable) NSArray<__kindof BBInvestmentAccount*> *products;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBInvestmentAccounts_h */
