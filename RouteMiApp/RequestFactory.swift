//
//  RequestFactory.swift
//  RouteMiApp
//
//  Created by Teodor on 12/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import Foundation

enum RequestType: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

struct Header {
    let value: String
    let field: String
}

class RequestFactory {
    static func request(_ URL: String, type: RequestType, headers: [Header]?, addAPIKey: Bool, params: NSDictionary?, completionHandler: (_ data: [String: AnyObject]) -> ()) {
        let configuration = URLSessionConfiguration.default()
        let session = URLSession(configuration: configuration)
        let url = Foundation.URL(string: URL, relativeTo: Constants.endpoint as URL)
        let request = NSMutableURLRequest(url: url!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        if headers != nil {
            for header in headers! {
                request.setValue(header.value, forHTTPHeaderField: header.field)
            }
        }
        if addAPIKey {
            request.setValue(Constants.keychain["apiKey"], forHTTPHeaderField: "X-Access-Token")
        }
        request.httpMethod = type.rawValue
        if params != nil {
            do {
                if let params = params as? [String: AnyObject] {
                    request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                }
            } catch let error {
                print("Error parsing request parameters. \(error)")
            }
        }
        let task = session.dataTask(with: request) {
            data, response, error in
            do {
                if let data = data {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    if let result = result as? [String: AnyObject] {
                        completionHandler(data: result)
                    }
                }
            } catch let error {
                print("Error parsing response from server \(error)")
            }
        }
        task.resume()
    }
}
