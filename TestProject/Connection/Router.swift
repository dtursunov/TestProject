//
//  Router.swift
//  TestProject
//
//  Created by Diyor Tursunov on 21/04/21.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {

    private var basePath: String {
        return "https://gwstage.ttonline.ru/testbackend/test7/hs/Gateway/"
    }
    
    case getCarModels
    case getCarModel(id: Int)

    private var path: String {
        switch self {
        case .getCarModels:
            return "carModels"
        case .getCarModel:
            return "carModels"
        }
    }

    private var method: HTTPMethod {
        switch self {
        case .getCarModels:
            return .get
        case .getCarModel:
            return .get
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case .getCarModels:
            return [:]
        case .getCarModel(let id):
            return ["id": id]
        }
    }
    
//    private var headers: HTTPHeader {
//        let user = "TestUser"
//        let password = "sdcJUhz8Wj9i"
//        let auth = HTTPHeader.authorization(username: user, password: password)
//        return auth
//    }
    
    var headers:[String: String] {
        let user = "TestUser"
        let password = "sdcJUhz8Wj9i"

        let credentialData = "\(user):\(password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!

        let base64Credentials = credentialData.base64EncodedString()


           let headers = [
                    "Authorization": "Basic \(base64Credentials)",
                    "Accept": "application/json",
                    "Content-Type": "application/json" ]
        
    
        
        return headers
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getCarModels:
            return  URLEncoding.default
        default:
            return URLEncoding.default
        }
        
    }
    
    func asURLRequest() throws -> URLRequest {
        //        let url = try basePath.asURL()
        //        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        //        return try URLEncoding.default.encode(urlRequest, with: params)
        
        var url = try basePath.asURL()
        //        url = url.appendingPathComponent(RouterLite.api)
        //        url = url.appendingPathComponent(RouterLite.version.rawValue)
        url = url.appendingPathComponent(self.path)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.timeoutInterval = 60 // 10 secs
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        
        return urlRequest
    }

}