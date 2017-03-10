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
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                print("Error: \(error)")
            } else {
                let resultDic = result as! [String : Any]
                
                print("fetched user: \(result)")
                let userName : NSString = resultDic["name"] as! NSString
                //let userName : NSString = resultDic.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                //let userEmail : NSString = resultDic["email"] as! NSString
                //let userEmail : NSString = resultDic.valueForKey("email") as! NSString
                //print("User Email is: \(userEmail)")
            }
        })
    }

}

