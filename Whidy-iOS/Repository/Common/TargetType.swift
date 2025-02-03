//
//  TargetType.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 8/26/24.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

protocol TargetType : URLRequestConvertible {
    var baseURL : URL { get }
    var method : HTTPMethod { get }
    var path : String { get }
    var header : [String:String] { get }
    var parameter : Parameters? { get }
    var queryItems : [URLQueryItem]? { get }
    var body : Data? { get }
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        let url = URL(string : baseURL.appendingPathComponent(path).absoluteString.removingPercentEncoding!)
        
        var request = URLRequest.init(url: url!)
        request.headers = HTTPHeaders(header)
        request.httpMethod = method.rawValue
        request.httpBody = body

        return try URLEncoding.default.encode(request, with: parameter)
    }
    
    func url() -> URL {
        return URL(string: "\(RemoteConstants.apiHost)")!
    }

    func adpat() -> [String:String] {
        if Defaults.accessToken.isNotEmpty {
            var header = setDefaultHTTPHeaderField()
            header[HTTPHeader.authorization.rawValue] = "Bearer " + Defaults.accessToken
            
            return header
        } else {
            return setDefaultHTTPHeaderField()
        }
    }
    
    func adpatRefresh() -> [String:String] {
        if Defaults.accessToken.isNotEmpty {
            var header = setDefaultHTTPHeaderField()
            header[HTTPHeader.authorization.rawValue] = "Bearer " + Defaults.refreshToken
            
            return header
        } else {
            return setDefaultHTTPHeaderField()
        }
    }
    
    private func setDefaultHTTPHeaderField() -> [String:String] {

        return [
            HTTPHeader.accept.rawValue: HTTPHeader.accept.value,
            HTTPHeader.contentType.rawValue: HTTPHeader.contentType.value
        ]
    }
}
