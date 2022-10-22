//
//  APIController.swift
//  Converter
//
//  Created by Pierre David on 10/22/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

class APIController {
    
    private static let sharedInstance = APIController()
    
    class func shared() -> APIController {
        return APIController.sharedInstance
    }
    
    func getConversion(amount: Double, from: String, to: String, completion: @escaping (_ jsonMessage: String?, _ converted: ConverterModel?) -> Void) {
        var params: String = "currency/commercial/exchange/\(amount)-" + from + "/" + to + "/latest"
        guard let converterURL = URL(string: URLs.baseURL + params) else {
            return
        }
        
        AF.request(converterURL, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("API Response: \(response)")
            if Connectivity.isConnectedToInternet() {
                guard let data = response.data else {
                    print("Did not get and data from API")
                    return
                }
                
                do {
                    let json = try JSON(data: response.data!)
                    if json["error"].exists() {
                        let msg = json["error_description"].stringValue
                        completion(msg, nil)
                    } else {
                        let results = try ConverterModel.init(json: json)
                        completion(nil, results)
                    }
                    
                    
                } catch let error {
                    print(error, "Catch")
                }
                
            } else {
                print("No Internet Connection")
            }
        }
    }
    
}
