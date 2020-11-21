//
//  Created by Backbase R&D B.V. on 16/09/2019.
//

#import <Foundation/Foundation.h>
#import <ProductsClient/BBProductConverter.h>

NS_ASSUME_NONNULL_BEGIN

/// Factory that allows given products to be converted into recipient model.
@interface BBProductConverterFactory : NSObject

/// Return the default factory that enables existing product kinds to be converted.
+ (instancetype)defaultFactory;

/**
 * Create a new BBProductConverterFactory object.
 * @param mapping The custom class that implements BBProductConverter protocol.
 * @return The initialized BBProductConverterFactory object.
 */
- (instancetype)initWithMapping:(NSDictionary<NSString*, Class<BBProductConverter>> *)mapping;

/// Returns a list of pre-defined converters.
+ (NSDictionary<NSString*, Class<BBProductConverter>> *)converters;

/**
 * Initialiser for a converter class.
 * @param kClass The class to be initialised.
 * @return The initialized converter item.
 */
- (NSObject<BBProductConverter> *)converterForClass:(Class)kClass;

@end

NS_ASSUME_NONNULL_END
