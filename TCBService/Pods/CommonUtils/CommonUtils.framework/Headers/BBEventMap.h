//
//  Created by Backbase R&D B.V. on 16/11/2018.
//

#ifndef BBEventMap_h
#define BBEventMap_h

#import <Foundation/Foundation.h>
#import <CommonUtils/BBEventObserver.h>

NS_ASSUME_NONNULL_BEGIN

/// The class that extends the observer pattern implementation from the MSDK.
/// It is used by the widgets.
@interface BBEventMap: NSObject

/**
 * Initializes the event map with a dictionary of mode - array of BBEventObserver objects.
 * @param map An NSDictionary object with NSString keys and an array of BBEventObserver objects as values.
 */
- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSArray<BBEventObserver *> *> *)map;

/**
 * Returns all registered modes for the current widget in an NSArray.
 * @return Returns all registered modes for the current widget in an NSArray.
 */
- (nullable NSArray<NSString *> *)allModes;

/**
 * Returns all observers registered for the given mode
 * @param mode The mode to return all observers for.
 * @return Returns all observers registered for the given mode
 */
- (nullable NSArray<BBEventObserver *> *)observersForMode:(NSString *)mode;

/**
 * Adds or replaces a set of BBEventObserver objects for the given mode.
 * @param observers The array of BBEventObserver objects to add or replace.
 * @param mode The mode to add or replace the observers for.
 */
- (void)addOrReplaceObservers:(NSArray<BBEventObserver *> *)observers forMode:(NSString *)mode;

/**
 * Removes all observers for the given event.
 * @param event The name of the event.
 */
- (void)removeObserversForEvent:(NSString *)event;

/**
 * Removes all observers for the given mode.
 * @param mode The name of the mode.
 */
- (void)removeObserversForMode:(NSString *)mode;

@end

NS_ASSUME_NONNULL_END

#endif
