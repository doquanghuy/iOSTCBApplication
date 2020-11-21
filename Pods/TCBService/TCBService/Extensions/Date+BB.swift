//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import CommonUtils

extension BackbaseWrapper where Base == Date {
    func string(withFormat format: String, locale: Locale = .current, timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter.string(from: base)
    }

    var isoString: String {
        return string(withFormat: BBDateFormat.bbISOOffsetDateFormatWithMilliseconds.rawValue)
    }

    var shortFormatDateString : String {
        return string(withFormat: BBDateFormat.bbShortDateFormat.rawValue)
    }

    func isInToday(inCalendar calendar: Calendar = .current) -> Bool {
        return calendar.isDateInToday(base)
    }

    func isInYesterday(inCalendar calendar: Calendar = .current) -> Bool {
        return calendar.isDateInYesterday(base)
    }

    func isInTomorrow(inCalendar calendar: Calendar = .current) -> Bool {
        return calendar.isDateInTomorrow(base)
    }

    func year(calendar: Calendar = .current) -> Int? {
        return calendar.dateComponents([.year], from: base).year
    }

    func month(calendar: Calendar = .current) -> Int? {
        return calendar.dateComponents([.month], from: base).month
    }

    func day(calendar: Calendar = .current) -> Int? {
        return calendar.dateComponents([.day], from: base).day
    }

    func isInSameDay(asDate date: Date, inCalendar calendar: Calendar = .current) -> Bool {
        let day1 = base
        let day2 = date
        let sameYear = day1.bb.year(calendar: calendar) == day2.bb.year(calendar: calendar)
        let sameMonth = day1.bb.month(calendar: calendar) == day2.bb.month(calendar: calendar)
        let sameDay = day1.bb.day(calendar: calendar) == day2.bb.day(calendar: calendar)
        return sameYear && sameMonth && sameDay
    }

    func date(byAdding component: Calendar.Component, value: Int, inCalendar calendar: Calendar = .current) -> Date? {
        return calendar.date(byAdding: component, value: value, to: base)
    }

    func truncated(calendar: Calendar = .current) -> Date {
        let comp = calendar.dateComponents([.year, .month, .day], from: base)
        return calendar.date(from: comp) ?? base
    }

    func firstDayOfMonth(calendar: Calendar = .current) -> Date? {
        var cal = calendar
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        var components = cal.dateComponents([.year, .month, .day], from: base)
        guard let range = cal.range(of: .day, in: .month, for: base) else { return nil }
        components.day = range.lowerBound
        return cal.date(from: components)
    }

    func lastDayOfMonth(calendar: Calendar = .current) -> Date? {
        var cal = calendar
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        var components = cal.dateComponents([.year, .month, .day], from: base)
        guard let range = cal.range(of: .day, in: .month, for: base) else { return nil }
        components.day = range.upperBound - 1
        return cal.date(from: components)
    }

    func mediumDateString(locale: Locale = .current, timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.timeZone = timeZone
        formatter.dateStyle = .medium
        formatter.doesRelativeDateFormatting = true
        return formatter.string(from: base)
    }

    func descriptiveString(calendar: Calendar = .current, locale: Locale = .current) -> String {
        if isInTomorrow(inCalendar: calendar) {
            return "shared_tomorrow".bb.localized
        } else if isInToday(inCalendar: calendar) {
            return "shared_today".bb.localized
        } else if isInYesterday(inCalendar: calendar) {
            return "shared_yesterday".bb.localized
        }

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        let format: String = year(calendar: calendar) == Date().bb.year(calendar: calendar) ? "MMM dd" : "MMM dd yyyy"
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: locale)

        return formatter.string(from: base)
    }

    func detailedString(calendar: Calendar = .current, locale: Locale = .current) -> String {
        let date = Date()

        guard
            date > base,
            let newDate = date.bb.date(byAdding: .minute, value: -5),
            newDate < base
            else {
                return descriptiveString(calendar: calendar, locale: locale)
        }

        return "shared_just_now".bb.localized
    }
}
