//
//  ViewController.swift
//  facebookAPI
//
//  Created by Good on 07/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import UIKit
import FacebookLogin


class ViewController: UIViewController, LoginButtonDelegate {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //https://github.com/facebook/facebook-sdk-swift/blob/master/Sources/Core/Permissions/ReadPermission.swift
        //https://developers.facebook.com/docs/facebook-login/permissions
        //http://stackoverflow.com/questions/31977310/fbsdkloginmanager-with-fbsdkloginbehaviorweb-failing-with-not-logged-in-error
        
        if (FBSDKAccessToken.current() != nil) {
            // User is already logged in, do work such as go to next view controller.
            let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
            loginButton.center = view.center
            view.addSubview(loginButton)
            loginButton.delegate = self
            
            self.returnUserData()
            self.getProfilePicture()
            
        } else {
            let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
            loginButton.center = view.center
            view.addSubview(loginButton)
            loginButton.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("User Logged In")
        
        switch result {
        case .failed(let error):
            print("FACEBOOK LOGIN FAILED: \(error)")
        case .cancelled:
            print("User cancelled login.")
        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
            print("Logged in!")
            print("GRANTED PERMISSIONS: \(grantedPermissions)")
            print("DECLINED PERMISSIONS: \(declinedPermissions)")
            print("ACCESS TOKEN \(accessToken)")
        }
        
        self.returnUserData()
        self.getProfilePicture()
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("User Logged Out")
    }
    
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me?fields=id,name,email,birthday,gender,education,work", parameters: nil)
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                print("Error: \(error)")
            } else {
                let resultDic = result as! [String : Any]
                
                print("fetched user: \(result)")
                let userName : NSString = resultDic["name"] as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = resultDic["email"] as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }
    
    func getProfilePicture() {
        self.profilePictureRequest(completionHandler: {(url, error) -> Void in
            if (error == nil) {
                print("url: \(url)")
                if (url != nil) {
                    self.imageView.contentMode = .scaleAspectFit
                    self.downloadImage(url: url as! URL)
                }
            } else {
                print("error \(error)")
            }
            
        })
    }
    
    func profilePictureRequest(completionHandler:@escaping (NSURL?, NSError?) -> ()) {
        let pictureRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/picture?type=large&redirect=false", parameters: nil)
        pictureRequest.start(completionHandler: { (connection, result, error) -> Void in
        
            if error == nil {
                print("\(result)")
                let resultDic : [NSString : Any] = result as! [NSString : Any]
                //just an example, not for production.
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
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.imageView.image = UIImage(data: data)
            }
        }
    }

    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
}
