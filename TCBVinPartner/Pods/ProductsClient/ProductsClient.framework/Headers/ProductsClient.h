//
//  Created by Backbase R&D B.V. on 10/09/2019.
//

#import <ProductsClient/ProductSummaryProtocol.h>
#import <ProductsClient/AccountsProtocol.h>
#import <ProductsClient/BBProductsErrors.h>
//! Project version number for ProductsClient.
FOUNDATION_EXPORT double ProductsClientVersionNumber;

//! Project version string for ProductsClient.
FOUNDATION_EXPORT const unsigned char ProductsClientVersionString[];

/**
 * The client implementing the DBSClient interface with the responsibility of loading and parsing products
 * data provided by the given DBSDataProvider.
 */
@interface ProductsClient: BBBaseClient <DBSClient, ProductSummaryProtocol, AccountsProtocol, RecipientContract>

/**
 * Creates a ProductsClient with the provided configuration.
 * @param productSummaryPath Product summary url configuration. Default  config: arrangement-manager/client-api/v2
 * @param accountsPath Accounts url configuration. Default  config: arrangement-manager/client-api/v2
 * @return The initialized ProductsClient object.
 */
- (nonnull instancetype)initWithProductSummaryPath:(nonnull BBDbsClientPath *)productSummaryPath
                                       accountsPath:(nonnull BBDbsClientPath *)accountsPath;

/**
 * Initialize the BBBaseClient object with the provided JSON parser implementation and network configuration object..
 * @param parser The NSObject that conforms to the BBJSONParser protocol.
 * If no parser is provided or the parser object does not conform to the BBJSONParser protocol the default one will be used. (BBBaseJSONParser).
 * @param productSummaryPath Product summary url configuration. Default  config: arrangement-manager/client-api/v2
 * @param accountsPath Accounts url configuration. Default  config: arrangement-manager/client-api/v2
 */
- (nonnull instancetype)initWithParser:(nonnull NSObject<BBJSONParser> *)parser
                     productSummaryPath:(nonnull BBDbsClientPath *)productSummaryPath
                           accountsPath:(nonnull BBDbsClientPath *)accountsPath;

/**
 * Creates a ProductsClient with the provided dbs url and product to recipient model converter configurations.
 * @param productSummaryPath Product summary url configuration. Default  config: arrangement-manager/client-api/v2
 * @param accountsPath Accounts url configuration. Default  config: arrangement-manager/client-api/v2
 * @param productConverterFactory Product converter factory instance with custom product converters
 * @return The initialized ProductsClient object.
 */
- (nonnull instancetype)initWithProductSummaryPath:(nonnull BBDbsClientPath *)productSummaryPath
                                       accountsPath:(nonnull BBDbsClientPath *)accountsPath
                            productConverterFactory:(nonnull BBProductConverterFactory *)productConverterFactory;

/**
 * Creates a ProductsClient with the provided product to recipient model converter configuration.
 * @param productConverterFactory Product converter factory instance with custom product converters
 * @return The initialized ProductsClient object.
 */
- (nonnull instancetype)initWithProductConverterFactory:(nonnull BBProductConverterFactory *)productConverterFactory;

/**
 * Creates a ProductsClient with the provided dbs url and product to recipient model converter configurations.
 * @param parser The NSObject that conforms to the BBJSONParser protocol.
 * If no parser is provided or the parser object does not conform to the BBJSONParser protocol the default one will be used. (BBBaseJSONParser).
 * @param productSummaryPath Product summary url configuration. Default  config: arrangement-manager/client-api/v2
 * @param accountsPath Accounts url configuration. Default  config: arrangement-manager/client-api/v2
 * @param productConverterFactory Product converter factory instance with custom product converters
 * @return The initialized ProductsClient object.
 */
- (nonnull instancetype)initWithParser:(nonnull NSObject<BBJSONParser> *)parser
                     productSummaryPath:(nonnull BBDbsClientPath *)productSummaryPath
                           accountsPath:(nonnull BBDbsClientPath *)accountsPath
                productConverterFactory:(nonnull BBProductConverterFactory *)productConverterFactory;

@end
