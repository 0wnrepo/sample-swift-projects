//
//  ViewController.swift
//  facebookAPI
//
//  Created by Good on 07/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import UIKit
import FacebookLogin
import Alamofire
import CoreData

class ViewController: UIViewController {
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
            
            self.retrieveUserData()
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
    
    //MARK: - graph requests
    
    func retrieveUserData() {
        self.returnUserData()
        self.getProfilePicture()
        
        //Alamofire networking + OBjectMapper JSON mapping to plain old SWift Object Model
        let nm = NetworkingManager.sharedInstance
        nm.OMTest(completion: { (profile) in
            print("parsed JSON data - user e-mail: \(profile?.email)")
        })
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
        let nm = NetworkingManager.sharedInstance
        nm.profilePictureRequest(completionHandler: {(url, error) -> Void in
            if (error == nil) {
                print("url: \(url)")
                if (url != nil) {
                    nm.getRawProfilePictureData(url: url as! URL, completion: { (data) in
                        self.savePictureData(data: data!)
                    })
                    self.getPictureData(completion: { (data) in
                        self.imageView.contentMode = .scaleAspectFit
                        self.imageView.image = UIImage(data: data!)
                    })
                    
                }
            } else {
                print("error \(error)")
            }
        })
    }
        
    //MARK: - CoreData helpers
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func savePictureData(data: Data) {
        let context = self.getContext()
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "FBProfile", in: context)
        
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        transc.setValue(data, forKey: "picture_data")
        //transc.setValue(1, forKey: "id")
        
        // Save the data to coredata
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func getPictureData (completion: @escaping (_ data: Data?) -> Void) {
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<FBProfile> = FBProfile.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for trans in searchResults as [NSManagedObject] {
                //get the Key Value pairs (although there may be a better way to do that...
                //print("\(trans.value(forKey: "picture_data"))")
                completion(trans.value(forKey: "picture_data") as! Data?)
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
}

extension ViewController: LoginButtonDelegate {
    //MARK: - LoginButtonDelegate
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("User Logged In")
        
        switch result {
        case .failed(let error):
            print("FACEBOOK LOGIN FAILED: \(error)")
            break
        case .cancelled:
            print("User cancelled login.")
            break
        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
            print("Logged in!")
            print("GRANTED PERMISSIONS: \(grantedPermissions)")
            print("DECLINED PERMISSIONS: \(declinedPermissions)")
            print("ACCESS TOKEN \(accessToken)")
            self.retrieveUserData()
            break
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("User Logged Out")
    }
}
