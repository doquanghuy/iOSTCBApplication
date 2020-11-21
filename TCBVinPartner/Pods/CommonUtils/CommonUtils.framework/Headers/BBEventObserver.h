//
//  Created by Backbase R&D B.V. on 14/11/2018.
//

#ifndef BBEventObserver_h
#define BBEventObserver_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Helper class to create a BBEventMap
@interface BBEventObserver: NSObject

/// Name of the event to observe.
@property (strong, nonatomic, readwrite) NSString *event;

/// The selector to call when the provided event is observed.
@property (nonatomic, readwrite) SEL selector;

/**
 * Initializes the BBEvenObserver object.
 * @param selector A selector to call when the event is observed.
 * @param event The name of the event to observe.
 */
- (instancetype)initWithSelector:(SEL)selector event:(NSString *)event;

/**
 * Convenience method to initializes the BBEvenObserver object.
 * @param selector A selector to call when the event is observed.
 * @param event The name of the event to observe.
 */
+ (instancetype)observerWithSelector:(SEL)selector event:(NSString *)event;

@end

NS_ASSUME_NONNULL_END

#endif
