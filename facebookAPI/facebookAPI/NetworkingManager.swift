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

import UIKit
import Alamofire
import CoreData
import SugarRecord

class NetworkingManager: NSObject {
    
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
    
    func OMTestAlamofire(completion: @escaping ( _ data: OMFBProfile?) -> Void) {
        //https://developers.facebook.com/tools/explorer?method=GET&path=me%3Ffields%3Did%2Cname%2Cemail%2Cbirthday%2Cgender%2Cpicture%7Burl%7D%26redirect%3Dno&version=v2.4
        let URL = "https://graph.facebook.com/v2.4/me?fields=id%2Cname%2Cemail%2Cbirthday%2Cgender%2Ceducation%2Cwork%2Cpicture%7Burl%7D&redirect=no&access_token=EAACEdEose0cBALXah5QSgtY1wYfa3Epmx8H2XzqCYwGv1takHxZA97Jkmc7gBPkP7LYDsv9NhfCATul27CAwlBkZA0zskdqvWsEs7iNRQgiYzFHw514nbK7dZBhDZCZA8poJ9cuyFgYngBifXjACSkHAK8Qf9cMzmAYezS7EDkpn3HLy10g2QkBbvSbX5MSSHoXMRhNtZARAZDZD"
        
        OMTest(url: URL, completion: completion)
    }
    
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
            }
    }
    
    func OMTestWithFacebookGraphRequest(completion: @escaping (_ data: OMFBProfile?) -> Void) {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me?fields=id,name,email,birthday,gender,education,work", parameters: nil)
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                print("Error: \(error)")
            } else {
                let json = result as! [String : Any]
                let user = Mapper<OMFBProfile>().map(JSON: json)
                completion(user)
            }
        })
    }
}
