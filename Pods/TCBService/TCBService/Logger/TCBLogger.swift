//
//  Logger.swift
//  TCBService
//
//  Created by Duong Dinh on 11/19/20.
//

import Foundation

class Logger {
    class func log(_ messages: [(key: String, value: Any?)] = [],
                   withEmoji: Bool = true,
                   filename: String = #file,
                   function: String =  #function,
                   line: Int = #line) {
        
        if withEmoji {
            let body = emojiBody(filename: filename, function: function, line: line)
            emojiLog(messageHeader: emojiHeader(), messageBody: body)
            
        } else {
            let body = regularBody(filename: filename, function: function, line: line)
            regularLog(messageHeader: regularHeader(), messageBody: body)
        }
        
        for (key, value) in messages {
            if let data = value as? Data {
                let str = String(decoding: data, as: UTF8.self)
                print(" └ 📣  \(key) -> \(str)\n")
            } else if let error = value as? Error {
                print(" └ 📣  \(key) -> \(error.localizedDescription)\n")
            } else if let response = value as? URLResponse {
                print(" └ 📣  \(key) -> \(response.description)\n")
            } else if let value = value {
                let messageString = String(describing: value)
                print(" └ 📣  \(key) -> \(messageString)\n")
            }
        }
    }
}

extension Logger {
    class func emojiHeader() -> String {
        return "⏱ \(formattedDate())"
    }
    
    class func emojiBody(filename: String, function: String, line: Int) -> String {
        return "🗂 \(filenameWithoutPath(filename: filename)), in 🔠 \(function) at #️⃣ \(line)"
    }
    
    class func emojiLog(messageHeader: String, messageBody: String) {
        print("\(messageHeader) │ \(messageBody)")
    }
}

extension Logger {
    
    class func regularHeader() -> String {
        return " \(formattedDate()) "
    }
    
    class func regularBody(filename: String, function: String, line: Int) -> String {
        return " \(filenameWithoutPath(filename: filename)), in \(function) at \(line) "
    }
    
    class func regularLog(messageHeader: String, messageBody: String) {
        let headerHorizontalLine = horizontalLine(for: messageHeader)
        let bodyHorizontalLine = horizontalLine(for: messageBody)
        
        print("┌\(headerHorizontalLine)┬\(bodyHorizontalLine)┐")
        print("│\(messageHeader)│\(messageBody)│")
        print("└\(headerHorizontalLine)┴\(bodyHorizontalLine)┘")
    }
    
    /// Returns a `String` composed by horizontal box-drawing characters (─) based on the given message length.
    ///
    /// For example:
    ///
    ///     " ViewController.swift, in viewDidLoad() at 26 " // Message
    ///     "──────────────────────────────────────────────" // Returned String
    ///
    /// Reference: [U+250x Unicode](https://en.wikipedia.org/wiki/Box-drawing_character)
    class func horizontalLine(for message: String) -> String {
        return Array(repeating: "─", count: message.count).joined()
    }
}

extension Logger {
    /// "/Users/blablabla/Class.swift" becomes "Class.swift"
    class func filenameWithoutPath(filename: String) -> String {
        return URL(fileURLWithPath: filename).lastPathComponent
    }
    
    /// E.g. `15:25:04.749`
    class func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        return "\(dateFormatter.string(from: Date()))"
    }
}
