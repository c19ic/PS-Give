//
//  chooseType.swift
//  PS Give
//
//  Created by Isha Chirimar on 8/7/17.
//

import UIKit

class chooseType: UIViewController {
    @IBOutlet weak var schoolbtn: UIButton!
    @IBOutlet weak var donorbtn: UIButton!
    @IBOutlet weak var cancel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //making buttons look good
        schoolbtn.layer.cornerRadius = 5
        schoolbtn.layer.borderWidth = 1
        donorbtn.layer.cornerRadius = 5
        donorbtn.layer.borderWidth = 1
        cancel.layer.borderWidth = 0.1
        cancel.layer.cornerRadius = 5
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

}
