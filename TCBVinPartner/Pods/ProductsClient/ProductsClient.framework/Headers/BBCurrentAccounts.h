//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBCurrentAccounts_h
#define ProductsClient_BBCurrentAccounts_h

#import <ProductsClient/BBProductKind.h>
#import <ProductsClient/BBCurrentAccount.h>

NS_ASSUME_NONNULL_BEGIN

/// Current accounts product kind.
@interface BBCurrentAccounts : Additions<BBProductKind>

/// The label/name that is used for the respective product kind.
@property (strong, nonatomic, readonly) NSString *name;

/// Defines a balance for groups of products.
@property (strong, nonatomic, readonly, nullable) BBAggregatedBalance *aggregatedBalance;

/// Products for the current accounts.
@property (strong, nonatomic, readonly, nullable) NSArray<__kindof BBCurrentAccount*> *products;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBCurrentAccounts_h */
