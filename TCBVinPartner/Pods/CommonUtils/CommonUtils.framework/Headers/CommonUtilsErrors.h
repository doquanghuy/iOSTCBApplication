//
//  Created by Backbase R&D B.V. on 30/03/2018.
//

#ifndef CommonUtilsErrors_h
#define CommonUtilsErrors_h

/// Error domain for only Common Utils operations related errors
extern const NSErrorDomain _Nonnull BBCommonUtilsErrorDomain;
typedef NS_ENUM(NSInteger, BBCommonUtilsErrors) {
    kBBCommonUtilsErrorIBANConfigurationFileNotFound = -1000
};

/// Error domain for Parsing related errors
extern const NSErrorDomain _Nonnull BBParseErrorDomain;
typedef NS_ENUM(NSInteger, BBParseErrors) {
    
    /// Object could not be parsed to requested type.
    kBBParseErrorObjectParsingFailed = -1000,
    
    /// No data received in server response.
    kBBParseErrorNoDataReceived = -1001,
    
    /// Parsing an array item failed.
    kBBParseErrorObjectListParsingFailed = -1002
};

#endif /* CommonUtilsErrors_h */
