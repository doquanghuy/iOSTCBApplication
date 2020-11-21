//
//  Created by Backbase R&D B.V. on 30/10/2018.
//

#ifndef BBSingleIdResponse_h
#define BBSingleIdResponse_h

#import <CommonUtils/Additions.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBSingleIdResponse : Additions

@property (strong, nonatomic, nonnull, readonly) NSString *identifier;

@end

NS_ASSUME_NONNULL_END

#endif
