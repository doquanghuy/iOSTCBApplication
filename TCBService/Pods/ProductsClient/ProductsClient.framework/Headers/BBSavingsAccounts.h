//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBSavingsAccounts_h
#define ProductsClient_BBSavingsAccounts_h

#import <ProductsClient/BBProductKind.h>
#import <ProductsClient/BBSavingsAccount.h>

NS_ASSUME_NONNULL_BEGIN

/// Savings account product kind.
@interface BBSavingsAccounts : Additions<BBProductKind>

/// The label/name that is used for the respective product kind.
@property (strong, nonatomic, readonly) NSString *name;

/// Defines a balance for the savings accounts.
@property (strong, nonatomic, readonly, nullable) BBAggregatedBalance *aggregatedBalance;

/// Products for the savings accounts.
@property (strong, nonatomic, readonly, nullable) NSArray<__kindof BBSavingsAccount*> *products;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBSavingsAccounts_h */
