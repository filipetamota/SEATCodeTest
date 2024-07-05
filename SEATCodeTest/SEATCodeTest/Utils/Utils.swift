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
    
    static func isEmailValid(email: String) -> Bool {
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            return emailPredicate.evaluate(with: email)
    }
}
