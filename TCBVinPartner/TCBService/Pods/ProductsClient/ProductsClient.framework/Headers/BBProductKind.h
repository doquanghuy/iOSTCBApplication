//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBProductKind_h
#define ProductsClient_BBProductKind_h

#import <CommonUtils/CommonUtils.h>
#import <ProductsClient/BBAggregatedBalance.h>
#import <ProductsClient/BBProductConverter.h>
#import <ProductsClient/BBBaseProduct.h>
NS_ASSUME_NONNULL_BEGIN

/// Generic parent class for product kind.
@protocol BBProductKind<NSObject>

/// The label/name that is used for the respective product kind.
@property (strong, nonatomic, readonly) NSString *name;

/// Defines a balance for groups of products.
@property (strong, nonatomic, readonly, nullable) BBAggregatedBalance *aggregatedBalance;

/// Products.
@property (strong, nonatomic, readonly, nullable) NSArray<BBBaseProduct*> *products;

/**
 * This method converts all product summary items into an array of recipient model.
 * @param typeIdentifier Identifies the type of the recipient.
 * @return A list of recipients.
 */
- (NSArray<RecipientModel *> *)convertToRecipientModelListWithConverter:(NSObject<BBProductConverter> *)converter
                                                      forTypeIdentifier:(NSString *)typeIdentifier;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBProductKind_h */
