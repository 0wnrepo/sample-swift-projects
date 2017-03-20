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
import SugarRecord

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
    
    func processProfile(_ jsonProfile: OMFBProfile) {
        print("parsed JSON data - user e-mail: \(jsonProfile.email)")
        
        let db = DbManager.sharedInstance
        
        let userDb = UserDbManager.init(mainContext: db.storage.mainContext, saveContext: db.storage.mainContext)
        let id_s : String = (jsonProfile.id_P)!
        var coreDataProfile : FBProfile? = userDb.fetchUser(with: id_s)
        
        if coreDataProfile == nil {
            userDb.saveUser(user: jsonProfile)
        }
        
        coreDataProfile = userDb.fetchUser(with: id_s)
        
        print("\(coreDataProfile?.email)")
    }
    
    //MARK: - requests
    func retrieveUserData() {
        self.getProfilePicture()
        
        //Alamofire networking + OBjectMapper JSON mapping to plain old SWift Object Model
        let nm = NetworkingManager.sharedInstance
        nm.OMTestAlamofire(completion: { (jsonProfile) in
            self.processProfile(jsonProfile!)
        })
        
        nm.OMTestWithFacebookGraphRequest(completion: { (jsonProfile) in
            self.processProfile(jsonProfile!)
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

//MARK: - LoginButtonDelegate

extension ViewController: LoginButtonDelegate {
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

//extension ViewController {
//    func loadDefaultStorage() -> CoreDataDefaultStorage {
//        let store = CoreDataStore.named("facebookAPI")
//        let model = CoreDataObjectModel.merged([Bundle.main])
//        return try! CoreDataDefaultStorage(store: store, model: model)
//    }
//}
