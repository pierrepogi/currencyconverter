//
//  APIRouter.swift
//  Converter
//
//  Created by Pierre David on 10/22/22.
//

import Foundation
import Alamofire
import SwiftyJSON

enum APIRouter: URLRequestConvertible {
    
    // GET: functions
    case convert
    
    // POST: functions
    
    // PATCH: functions
 
    // DELETE: functions
    
    

    // MARK: Endpoints
    private var path: String {
        switch self {
        
        // GET: Endpoints
        case .convert:
            return "/currency/commercial/exchange/"
            
        // POST: Endpoints
            
        // PATCH: Endpoints
    
        // DELETE: Endpoints
            
        } //END: Switch
        
    }
    
    // MARK: Methods
    private var method: HTTPMethod {
        switch self {
            
        // GET: Methods
        case .convert: return .get
            
        // POST: Methods
            
        // PATCH: Methods
            
        // DELETE: Methods
    
        
        } // END: Switch
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        var url = try URLs.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch self {
        // GET: URLRequestConvertible
         case .convert: break
        
        } // END: Switch
        
        return urlRequest
    }
    
    
}
