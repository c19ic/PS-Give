

import UIKit
import Parse


class donorHomeVC: UIViewController {
    
    // refresher variable
    var refresher : UIRefreshControl!
    
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var username: UILabel!
   
    @IBOutlet weak var barbutton: UIBarButtonItem!
    
    
    
    
    // default func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.current()
        name.text = user!.object(forKey: "fullname") as! String?
        bio.text = user!.object(forKey: "bio") as! String?
        
        username.text = ("@\(user!.object(forKey: "username") as! String)")
/*
         if let userPicture = object.valueForKey("Image")! as! PFFile {
            userPicture.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
                let image = UIImage(data: imageData!)
                    if image != nil {
                        self.imageArray.append(image!)
                    }
                })
         }
 */
        // receive notification from editVC
        NotificationCenter.default.addObserver(self, selector: #selector(donorHomeVC.reload(_:)), name: NSNotification.Name(rawValue: "reload"), object: nil)
        
        var avaFile = user!.object(forKey: "ava") as! PFFile
            
        avaFile.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
            let image = UIImage(data: imageData!)
            if image != nil {
                self.avaImg.image = image
            }
        })
                // title at the top
        self.navigationItem.title = "MY PROFILE"
        var color:UIColor = UIColor.init(colorLiteralRed: 27, green: 100, blue: 164, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: color, NSFontAttributeName: UIFont(name: "Nunito-Regular", size: 17)!]
       
        
       barbutton.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Nunito-Regular", size: 15)!], for: UIControlState.normal)
    }
    


    func reload(_ notification:Notification) {
        self.view.setNeedsDisplay()
    }
    
    // clicked log out
    @IBAction func logout(_ sender: AnyObject) {
        // implement log out
        PFUser.logOutInBackground { (error) -> Void in
            if error == nil {
                    
                // remove logged in user from App memory
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.synchronize()
                    
                let signin = self.storyboard?.instantiateViewController(withIdentifier: "signInVC") as! signInVC
                let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = signin
                    
            }
        }
        
        
    }
    
   
}

