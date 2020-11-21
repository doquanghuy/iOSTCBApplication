//
//  Created by Backbase R&D B.V. on 23/10/2018.
//

#ifndef BBBaseWidget_h
#define BBBaseWidget_h

#import <Backbase/Backbase.h>
#import <CommonUtils/BBEventObserver.h>
#import <CommonUtils/BBEventMap.h>

NS_ASSUME_NONNULL_BEGIN

/// The class that is extended by the widget.
@interface BBBaseWidget : NativeRenderer

/// The array containing all modes that the widget understands and can operate under.
@property (strong, nonatomic) NSArray<NSString*> *allowedModes;

#pragma mark - Mode related methods

/**
 * Returns the mode the widget is currently in.
 * @return The current mode the widget is in.
 */
- (nullable NSString *)currentMode;

/**
 * Checks if the provided mode is allowed in the widgets current configuration. If not, a message will be logged with a warning level on the
 * BBLog stream.
 * @param mode The mode to check.
 */
- (void)checkMode:(nullable NSString *)mode;

#pragma mark - Event registration methods

/**
 * @return The default BBEventMap.
 */
- (BBEventMap *)defaultEventMap;

/**
 * Register a new event map to handle all navigation and other broadcasted events in the widget.
 * @param eventMap The new event map
 */
- (void)registerEventMap:(BBEventMap *)eventMap;

/**
 * Register specific event observers for a given mode.
 * @param observers An array of BBEventObserver objects to handle all events for the given mode.
 * @param mode The mode to register the observers for.
 */
- (void)registerObservers:(NSArray<BBEventObserver*> *)observers forMode:(NSString *)mode;

/**
 * Clears all observers registered with this widget, for all modes.
 */
- (void)clearObservers;

/**
 * Register a single selector for the given event, when the widget is in the specified mode.
 * @param selector The selector to register.
 * @param event The event to register the selector for.
 * @param mode The mode to handle the event in.
 */
- (void)registerSelector:(SEL)selector forEvent:(NSString *)event whenMode:(NSString *)mode;

/**
 * Removes the specified event for the given mode.
 * @param event The name of the event to remove.
 * @param mode The mode for which the event should be removed.
 */
- (void)unregisterEvent:(NSString *)event whenMode:(NSString *)mode;

/**
 * Publishes a _navigation_ event with the widget being the origin.
 * @param payload An NSString: NSObject dictionary representing the payload to be sent with the event.
 */
- (void)publishEvent:(NSString *)event payload:(nullable NSDictionary<NSString *, NSObject *> *)payload;

@end

NS_ASSUME_NONNULL_END

#endif
