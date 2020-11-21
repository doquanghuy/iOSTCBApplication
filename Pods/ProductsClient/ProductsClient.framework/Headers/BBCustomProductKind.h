//
//  Created by Backbase R&D B.V. on 24/09/2019.
//

#ifndef ProductsClient_BBCustomProductKinds_h
#define ProductsClient_BBCustomProductKinds_h

#import <ProductsClient/BBProductKind.h>
#import <ProductsClient/BBGeneralAccount.h>

NS_ASSUME_NONNULL_BEGIN

/// This is a response class custom product kind
@interface BBCustomProductKind : Additions<BBProductKind>

/// The id of the custom product kind.
@property (strong, nonatomic, readonly) NSNumber *identifier;

/// The label/name that is used for the respective product kind.
@property (strong, nonatomic, readonly) NSString *name;

/// Defines a balance for the savings accounts.
@property (strong, nonatomic, readonly, nullable) BBAggregatedBalance *aggregatedBalance;

/// Products for the custom product kinds.
@property (strong, nonatomic, readonly, nullable) NSArray<__kindof BBGeneralAccount*> *products;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBCustomProductKinds_h */
