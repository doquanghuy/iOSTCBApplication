//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

import Foundation

public extension Date {
    func string(withFormat format: String, locale: Locale = .current, timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter.string(from: self)
    }

    var isoString: String {
        return string(withFormat: DateFormat.isoOffsetDateFormatWithMilliseconds.rawValue)
    }
    
    var shortFormatDateString : String {
        return string(withFormat: DateFormat.shortDateFormat.rawValue)
    }

    func isInToday(inCalendar calendar: Calendar = .current) -> Bool {
        return calendar.isDateInToday(self)
    }

    func isInYesterday(inCalendar calendar: Calendar = .current) -> Bool {
        return calendar.isDateInYesterday(self)
    }

    func isInTomorrow(inCalendar calendar: Calendar = .current) -> Bool {
        return calendar.isDateInTomorrow(self)
    }

    func year(calendar: Calendar = .current) -> Int? {
        return calendar.dateComponents([.year], from: self).year
    }

    func month(calendar: Calendar = .current) -> Int? {
        return calendar.dateComponents([.month], from: self).month
    }

    func day(calendar: Calendar = .current) -> Int? {
        return calendar.dateComponents([.day], from: self).day
    }

    func isInSameDay(asDate date: Date, inCalendar calendar: Calendar = .current) -> Bool {
        let day1 = self
        let day2 = self
        let sameYear = day1.year(calendar: calendar) == day2.year(calendar: calendar)
        let sameMonth = day1.month(calendar: calendar) == day2.month(calendar: calendar)
        let sameDay = day1.day(calendar: calendar) == day2.day(calendar: calendar)
        return sameYear && sameMonth && sameDay
    }

    func date(byAdding component: Calendar.Component, value: Int, inCalendar calendar: Calendar = .current) -> Date? {
        return calendar.date(byAdding: component, value: value, to: self)
    }

    func truncated(calendar: Calendar = .current) -> Date {
        let comp = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: comp) ?? self
    }

    func firstDayOfMonth(calendar: Calendar = .current) -> Date? {
        var cal = calendar
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        var components = cal.dateComponents([.year, .month, .day], from: self)
        guard let range = cal.range(of: .day, in: .month, for: self) else { return nil }
        components.day = range.lowerBound
        return cal.date(from: components)
    }

    func lastDayOfMonth(calendar: Calendar = .current) -> Date? {
        var cal = calendar
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        var components = cal.dateComponents([.year, .month, .day], from: self)
        guard let range = cal.range(of: .day, in: .month, for: self) else { return nil }
        components.day = range.upperBound - 1
        return cal.date(from: components)
    }

    func mediumDateString(locale: Locale = .current, timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.timeZone = timeZone
        formatter.dateStyle = .medium
        formatter.doesRelativeDateFormatting = true
        return formatter.string(from: self)
    }

    func descriptiveString(calendar: Calendar = .current, locale: Locale = .current) -> String {
        if isInTomorrow(inCalendar: calendar) {
            return "shared_tomorrow".localized
        } else if isInToday(inCalendar: calendar) {
            return "shared_today".localized
        } else if isInYesterday(inCalendar: calendar) {
            return "shared_yesterday".localized
        }

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        let format: String = year(calendar: calendar) == Date().year(calendar: calendar) ? "MMM dd" : "MMM dd yyyy"
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: locale)

        return formatter.string(from: self)
    }

    func detailedString(calendar: Calendar = .current, locale: Locale = .current) -> String {
        let date = Date()

        guard
            date > self,
            let newDate = date.date(byAdding: .minute, value: -5),
            newDate < self
            else {
                return descriptiveString(calendar: calendar, locale: locale)
        }

        return "shared_just_now".localized
    }
}
