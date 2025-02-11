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
        return URL(string: "\(RemoteConstants.apiHost)\(RemoteConstants.currentAPIVersion)")!
    }
    
    func naverApiUrl() -> URL {
        return URL(string: "https://openapi.naver.com/v1")!
    }

    func naverAuthAdpat() -> [String:String] {
        guard let tokenType = NaverSDKManager.shared.instance().tokenType else { Logger.error("NaverSDK non-init(tokenType)"); return [:] }
        guard let accessToken = NaverSDKManager.shared.instance().accessToken else { Logger.error("NaverSDK non-init(accessToken)"); return [:] }
        let authorization = "\(tokenType) \(accessToken)"
        
        return ["Authorization": authorization]
    }
    
    func adpat() -> [String:String] {
        if Defaults.bearerToken.isNotEmpty {
            
            var header = setDefaultHTTPHeaderField()
            header[HTTPHeader.authorization.rawValue] = "Bearer=" + Defaults.bearerToken
            
            return header
        } else {
            return setDefaultHTTPHeaderField()
        }
    }
    
    private func setDefaultHTTPHeaderField() -> [String:String] {

        return [
            HTTPHeader.accept.rawValue: HTTPHeader.accept.value,
            HTTPHeader.contentType.rawValue: HTTPHeader.contentType.value,
            HTTPHeader.deviceName.rawValue: HTTPHeader.deviceName.value,
            HTTPHeader.osKind.rawValue: HTTPHeader.osKind.value,
            HTTPHeader.version.rawValue: HTTPHeader.version.value,
            HTTPHeader.serviceKind.rawValue: HTTPHeader.serviceKind.value,
            HTTPHeader.appKind.rawValue: HTTPHeader.appKind.value,
            HTTPHeader.appTypeCd.rawValue: HTTPHeader.appTypeCd.value
        ]
    }
}
