

import Parse
import UIKit

import Bolts

import Moltin

var DEBUG:Bool = true;

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Moltin.clientID = "O2ZB02FUHrFNCkrYSenrhzHQitePkJa4Ft7hNE0uyz"
        Parse.enableLocalDatastore()
        let config = ParseClientConfiguration{
            $0.applicationId = "bc796d4a83bd4b125e16a84608fa198f1a56cd2d"
            $0.clientKey = "0c55a9443f592a5705d44e4a01e0d98ee04baeb0"
            $0.server = "http://ec2-35-167-70-149.us-west-2.compute.amazonaws.com:80/parse"
            
            //"http://ec2-35-167-70-149.us-west-2.compute.amazonaws.com:80/parse"
        }
        
        Parse.initialize(with: config)
        
        // call login function
        login()
        

        
        //background color
        window?.backgroundColor = .white
       
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func login() {
        
      
        let username : String? = UserDefaults.standard.string(forKey: "username")
        
        
        // if logged in
        if (username == nil){
            if (DEBUG) {print ("DEBUG: username is nil")}
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let signInVC = storyboard.instantiateViewController(withIdentifier: "signInVC")
            window?.rootViewController = signInVC
            
        } else {
            let user = PFUser.current()!
            if (DEBUG) {print ("DEBUG: \n",username!)}
            
           
            let type:String = user.value(forKey: "type") as! String
            if DEBUG {print("DEBUG", type)}
            if type == "school"{
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let myTabBar = storyboard.instantiateViewController(withIdentifier: "SchoolTabBar") as! UITabBarController
                self.window?.rootViewController = myTabBar
             } else {
                
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let myTabBar = storyboard.instantiateViewController(withIdentifier: "donorTabBar") as! UITabBarController
                window?.rootViewController = myTabBar
            }
        }
        
    }
    
}




