

import UIKit
import Parse
class schoolHome: UIViewController {

    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var pending: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()!
        name.text = user.value(forKey: "username") as! String?
        user.value(forKey: "type") as! String
        bio.text = user.value(forKey: "bio") as! String!
        website.text = user.value(forKey: "web") as! String?
        print("DEBUG: \(user.object(forKey: "approved"))")
        
        var approved = user.object(forKey: "approved") as! Bool
        if approved {
            
            pending.text = ""
        }
        else {
            status.text = "pending"
        }
        
        var avaFile = user.object(forKey: "ava") as! PFFile
        
        avaFile.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
            let image = UIImage(data: imageData!)
            if image != nil {
                self.avaImg.image = image
            }
        })
        
        // Do any additional setup after loading the view.
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func logout(_ sender: Any) {
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
