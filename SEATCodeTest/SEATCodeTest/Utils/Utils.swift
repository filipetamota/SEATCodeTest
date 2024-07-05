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
    
    static func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
