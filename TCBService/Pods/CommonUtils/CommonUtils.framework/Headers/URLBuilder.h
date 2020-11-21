//
//  Created by Backbase R&D B.V. on 01/03/2018.
//

#import <Foundation/Foundation.h>

#ifndef URLBuilder_h
#define URLBuilder_h

/// Convenience class to be used when building a URL.
@interface URLBuilder : NSObject

/**
 * Construct a URL by combining a base URL, a path and query parameters.
 *
 * @param baseURL A base URL, e.g. http://www.google.com
 * @param path A path component, e.g. /path/to/subsite/
 * @param parameters A dictionary with additional parameters
 * @return The URL created by combining the base URL, path and parameters
 */
+ (NSURL *)URLWithBaseURL:(NSURL *)baseURL
                     path:(NSString *)path
               parameters:(NSDictionary <NSString *, NSString *> *)parameters;

@end

#endif /* URLBuilder_h */
