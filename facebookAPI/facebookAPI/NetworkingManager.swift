//
//  NetworkingManager.swift
//  facebookAPI
//
//  Created by Good on 12/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import Foundation
import Alamofire
import FacebookLogin
import ObjectMapper



class NetworkingManager: NSObject {
    
    //singleton
    class var sharedInstance: NetworkingManager {
        struct Static {
            static let instance: NetworkingManager = NetworkingManager()
        }
        return Static.instance
    }
    
    func profilePictureRequest(completionHandler:@escaping (NSURL?, NSError?) -> ()) {
        let pictureRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/picture?type=large&redirect=false", parameters: nil)
        pictureRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if error == nil {
                print("\(result)")
                let resultDic : [NSString : Any] = result as! [NSString : Any]
                //just an example, not for production need a better way of parsing json to a model
                guard let dataDic = resultDic["data"] as? [NSString : Any] else {
                    print("is nil")
                    completionHandler(nil,NSError.init(domain: "meh", code: 0, userInfo: ["index" : "help"]))
                    return
                }
                let resultURLString = dataDic["url"] as? NSString
                let resultURL : NSURL = NSURL(string: resultURLString as! String)!
                
                completionHandler(resultURL,error as? NSError)
            } else {
                print("\(error)")
                completionHandler (nil, error as? NSError)
            }
        })
    }
    
    func getRawProfilePictureData(url: URL, completion: @escaping (_ data: Data?) -> Void) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                completion(data)
            }
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func OMTest(completion: @escaping ( _ data: OMFBProfile?) -> Void) {
        //https://developers.facebook.com/tools/explorer?method=GET&path=me%3Ffields%3Did%2Cname%2Cemail%2Cbirthday%2Cgender%2Cpicture%7Burl%7D%26redirect%3Dno&version=v2.4
        let URL = "https://graph.facebook.com/v2.4/me?fields=id%2Cname%2Cemail%2Cbirthday%2Cgender%2Ceducation%2Cwork%2Cpicture%7Burl%7D&redirect=no&access_token=EAACEdEose0cBAAT2S9DCADVoGQaYes0tZCrPdX5xjBjxCX1yzkZCLxeB1B07nknzvlVeWq8OVtTcDx2c1TpJJu6uMNT5nhBPZBqF0PtjoQ6eC0i1v5MS5cCcOjmaU3qblKxS5Uvg2CVnUvq2FbOqxsvZBGMJCrlSLprq8CbNDn6nb37NdjMlySgSR3z30U9ccuFqcwpEUQZDZD"
        
        OMTest(url: URL, completion: completion)
    }
    
    //TODO: maybe implement JSON parsing with alamofire only and mapping to object model
    //https://gist.github.com/jpotts18/e39ee74de84ae094b270
    //https://grokswift.com/updating-alamofire-to-swift-3-0/
    
    //http://stackoverflow.com/questions/39468516/parsing-json-using-the-new-swift-3-and-alamofire
    //https://github.com/Alamofire/Alamofire/blob/master/Documentation/Alamofire%204.0%20Migration%20Guide.md
    func OMTest(url: String, completion: @escaping (_ data: OMFBProfile?) -> Void) {
        Alamofire.request(url)
            .responseJSON { response in
                //print(response)
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status) {
                        case 200, 201:
                            print("example success")
                            switch response.result {
                                case .success (let data):
                                    let json = data as! [String : Any]
                                    let user = Mapper<OMFBProfile>().map(JSON: json)
                                    completion(user)
                                break
                            case .failure(let error):
                                print("Error: \(error)")
                                break
                             }
                        default:
                            print("error with response status: \(status)")
                        }
                }
//                //to get JSON return value
//                if let result = response.result.value {
//                    let JSON = result as! NSDictionary
//                    print(JSON)
//                }
        }
    }
}
