//
//  Created by Backbase R&D B.V. on 01/10/2019.
//

#ifndef CommonUtils_BBDbsClientPath_h
#define CommonUtils_BBDbsClientPath_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// A default network configuration class used in all clients to construct network url components.
@interface BBDbsClientPath : NSObject

/// The base Uri version. Defaults to "v2"
@property(nonatomic, strong, readonly) NSString *baseURIVersion;

/// The base Uri. Defaults to "client-api/${getBaseUriVersion()}"
@property(nonatomic, strong, readonly) NSString *baseURI;

/// The service name of the presentation service.
@property (nonatomic, strong, readonly)NSString *serviceName;

/// Constructs the complete components path (serviceName + baseURI).
@property (nonatomic, strong, readonly) NSString *completePath;

- (instancetype)init NS_UNAVAILABLE;

/// Initilize BBDbsClientPath object with default values of baseURIVersion & baseURI. Example output: <service-prefix>/client-api/v2
/// @param serviceName the presentation service name you would like to connect.
- (instancetype)initWithServiceName:(NSString *)serviceName;

/// Initilize BBDbsClientPath object with default value & baseURI. Example output: <service-prefix>/client-api/v2
/// @param serviceName the presentation service name you would like to connect.
/// @param version The baseURI version you would like to connect. Default is 'v2'.
- (instancetype)initWithServiceName:(NSString *)serviceName withBaseURIVersion:(NSString *)version;

/// Initilize BBDbsClientPath object. Example output: <service-prefix>/client-api/v2
/// @param serviceName the presentation service name you would like to connect.
/// @param baseURI the baseURI you would like to connect. Default is 'client-api'.
/// @param version The baseURI version you would like to connect. Default is 'v2'.
- (instancetype)initWithServiceName:(NSString *)serviceName withBaseURI:(NSString *)baseURI withBaseURIVersion:(NSString *)version;

@end

NS_ASSUME_NONNULL_END
#endif /* BBDbsClientPath_h */
