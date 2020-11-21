//
//  Created by Backbase R&D B.V. on 16/09/2019.
//

#import <ProductsClient/BBBaseProduct.h>

NS_ASSUME_NONNULL_BEGIN

/// The product converter interface. When conformed, it enables to convert a product list into recipient model list.
@protocol BBProductConverter<NSObject>

/**
 * This method converts the given products into an array of recipient model.
 * @param products Products to be converted.
 * @param typeIdentifier Identifies the type of the recipient.
 * @return A list of recipients.
 */
- (NSArray<RecipientModel *> *)convertProducts:(NSArray <BBBaseProduct*> *)products
                            withTypeIdentifier:(nullable NSString *)typeIdentifier;
@end

NS_ASSUME_NONNULL_END
