//
//  signInVC.swift
//
//LOG IN KEYS FOR APPROVED SCHOOL TESTING: ps258, test


//

import UIKit
import Parse


class signInVC: UIViewController {
    
    // textfield
   
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    // buttons
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    
    
   
    
    
    // default func
    override func viewDidLoad() {
        super.viewDidLoad()
        //Styling buttons border, rounding
        signInBtn.layer.cornerRadius = 5
        signInBtn.layer.borderWidth = 0.3
        signInBtn.layer.borderColor = UIColor.lightGray.cgColor
        signUpBtn.layer.cornerRadius = 5
        signUpBtn.layer.borderWidth = 0.3
        signUpBtn.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    // hide keyboard func
    func hideKeyboard(_ recognizer : UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    
    // clicked sign in button
    @IBAction func signInBtn_click(_ sender: AnyObject) {
        print("DEBUG: sign in pressed")
        
        // hide keyboard
        self.view.endEditing(true)
        
        // if textfields are empty
        if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty {
            
            // show alert message
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        // login functions
        PFUser.logInWithUsername(inBackground: usernameTxt.text!.lowercased(), password: passwordTxt.text!){(user, error) -> Void in
            if DEBUG{
                print(user)
            }
            if error == nil {
                UserDefaults.standard.set(user!.object(forKey:"fullname"), forKey: "username")
                UserDefaults.standard.set(self.usernameTxt.text!, forKey: "login_id")
                let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
                
            } else {
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            
            
        }
 
        
    }
    
}
