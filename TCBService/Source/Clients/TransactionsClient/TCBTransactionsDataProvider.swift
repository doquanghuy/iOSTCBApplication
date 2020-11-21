//
//  TCBTransactionsDataProvider.swift
//  TCBService
//
//  Created by duc on 10/16/20.
//

import Backbase
import CommonUtils

final class TCBTransactionsDataProvider: TCBDataProvider {
    private let periodStartDateKeyName = "periodStartDate"
    private let periodEndDateKeyName = "periodEndDate"
    private let localFolderPath = "assets/backbase/conf/API"

    /*
     * Fix the path for us versions if needed
     */
    public override func data(for resourceFile: String) -> Data? {
        let correctFilePath = correctLocalFilePath(for: resourceFile)
        return try? Data(contentsOf: URL(fileURLWithPath: correctFilePath))
    }

    /*
     * This method is only used when the provider type is .local, on .remote a network request
     * is made and the response passed straight back to the widget.
     */
    override func createResponse(from request: String,
                                 httpMethod: HTTPMethod,
                                 queryItems: QueryItems?,
                                 resourceFile: String,
                                 body: Data?) -> ProviderResponse {
        var fileName: String = resourceFile

        fileName = getResourceFile(for: request, queryItems: queryItems) ?? ""
        let response = super.createResponse(from: request, httpMethod: httpMethod, queryItems: queryItems, resourceFile: fileName)

        if case let .success(_, data) = response {
            if httpMethod == .patch {
                return .success(successfulResponse, data)
            }
        }

        guard let queryItems = queryItems,
            !queryItems.isEmpty,
            case let .success(_, data) = response,
            let responseData = data else {
                return response
        }

        var filteredData = filter(data: responseData, by: queryItems, matching: "counterPartyName")

        if let category = queryItems.first(where: { $0.name == "category" })?.value {
            filteredData = filter(data: filteredData, category: category)
        }

        let paginatedData = paginate(data: filteredData, by: queryItems)

        return .success(successfulResponse, paginatedData)
    }

    override var successfulResponse: HTTPURLResponse {
        switch providerType {
        case let .local(path):
            return HTTPURLResponse(url: URL(fileURLWithPath: path), statusCode: 204, httpVersion: "1.0", headerFields: nil)!
        case let .remote(_, url):
            return HTTPURLResponse(url: url, statusCode: 204, httpVersion: "1.0", headerFields: nil)!
        }
    }

    public override func createResponse(resourceFile: String, for type: BehaviourResponseType) -> ProviderResponse {
        guard type == .empty else {
            return super.createResponse(resourceFile: resourceFile, for: type)
        }

        let url = URL(fileURLWithPath: resourceFile)
        let fileName = url.deletingPathExtension().lastPathComponent

        if fileName.contains("turnovers") {
            let emptyTurnOversResourceFile = resourceFile.replacingOccurrences(of: fileName, with: "turnovers-empty")

            let url = URL(fileURLWithPath: emptyTurnOversResourceFile)

            guard let emptyResponse = try? Data(contentsOf: url) else {
                fatalError("cannot load \(emptyTurnOversResourceFile)")
            }

            return .success(successfulResponse, emptyResponse)
        } else {
            return .success(successfulResponse, "[]".data(using: .utf8))
        }
    }

    private func getResourceFile(for fileName: String, queryItems: QueryItems?) -> String? {
        var fileName = fileName

        let uncompleted = URLQueryItem(name: "state", value: "UNCOMPLETED")
        if queryItems?.contains(uncompleted) == true {
            fileName += "-pending"
            return TCBService.bundle.path(forResource: "\(localFolderPath)\(fileName)", ofType: ".json")
        }

        let dateFormat = BBDateFormat.bbShortDateFormat.rawValue
        guard
            let startDate = queryItems?.first(where: { $0.name == periodStartDateKeyName })?.value,
            let endDate = queryItems?.first(where: { $0.name == periodEndDateKeyName })?.value,
            let startMonth = startDate.bb.date(withFormat: dateFormat)?.bb.month(),
            let endMonth = endDate.bb.date(withFormat: dateFormat)?.bb.month() else {
                let resourceFile = TCBService.bundle.path(forResource: "\(localFolderPath)\(fileName)", ofType: ".json")
                return resourceFile
        }

        if !fileName.hasSuffix("turnovers") {
            let uncompleted = URLQueryItem(name: "state", value: "UNCOMPLETED")
            if queryItems?.contains(uncompleted) == true {
                fileName += "-pending"
            }
            fileName = startMonth == endMonth ? "\(fileName)-\(startMonth)" : "\(fileName)-longterm"
        }
        let resourceFile = TCBService.bundle.path(forResource: "\(localFolderPath)\(fileName)", ofType: ".json")

        return resourceFile
    }

    func filter(data: Data, by queryItems: QueryItems?, matching key: String) -> Data {
        var data = data
        do {
            if let objects = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                let queryItems = queryItems,
                let query = queryItems.first(where: { $0.name == "query" })?.value,
                let offset = Int(queryItems.first(where: { $0.name == "from" })?.value ?? "0"),
                offset < objects.count {
                let filtered = objects.filter {
                    ($0[key] as? String)?.lowercased().range(of: query.lowercased()) != nil
                }
                data = try JSONSerialization.data(withJSONObject: Array(filtered), options: [])
            }
        } catch {
            Backbase.logError(self, message: error.localizedDescription)
        }
        return data
    }

    func filter(data: Data, category: String) -> Data {
        var data = data

        do {
            if var objects = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                for idx in 0 ..< objects.count {
                    objects[idx]["category"] = category
                }
                data = try JSONSerialization.data(withJSONObject: objects, options: [])
            }
        } catch {
            Backbase.logError(self, message: error.localizedDescription)
        }

        return data
    }

    func paginate(data: Data, by queryItems: QueryItems) -> Data {
        var data = data

        do {
            if let objects = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                let offset = Int(queryItems.first(where: { $0.name == "from" })?.value ?? "0"),
                let size = Int(queryItems.first(where: { $0.name == "size" })?.value ?? "0") {
                let firstIdx = offset * size
                let lastIdx = min(firstIdx + size, objects.count)
                guard firstIdx <= lastIdx else {
                    let emptyResult: [String] = []
                    data = try JSONSerialization.data(withJSONObject: emptyResult, options: [])
                    return data
                }
                let paginated = objects[firstIdx..<lastIdx]
                data = try JSONSerialization.data(withJSONObject: Array(paginated), options: [])
            }
        } catch {
            Backbase.logError(self, message: error.localizedDescription)
        }

        return data
    }
}

