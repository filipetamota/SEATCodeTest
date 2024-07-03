//
//  Utils.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 3/7/24.
//

import Foundation

final class Utils {
    static func getAPIInfoFromPlist(propertyName: String) -> String? {
        guard
            let path = Bundle.main.path(forResource: "APIInfo", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let property = dict[propertyName] as? String
        else {
            return nil
        }
        
        return property
    }

    static func buildURLRequest(requestData: RequestData, queryParams: [String: String]? = nil, pathVariable: String? = nil) -> URLRequest? {
        guard
            let domain = getAPIInfoFromPlist(propertyName: "Domain"),
            let baseURL = URL(string: domain)
        else {
            assertionFailure()
            return nil
        }
        var url = baseURL.appendingPathComponent(requestData.path())
        
        if let pathVariable = pathVariable {
            url = url.appendingPathComponent(pathVariable)
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        if  let queryParams = queryParams {
            components?.queryItems = queryParams.compactMap({ item in
                URLQueryItem(name: item.key, value: item.value)
            })
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = requestData.method()

        return urlRequest
    }
}
