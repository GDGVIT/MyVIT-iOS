//
//  LoginViewController.swift
//  MyVIT
//
//  Created by Ashwini Purohit on 09/04/17.
//  Copyright © 2017 GDG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var registrationNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func loginButton(_ sender: Any) {
        let uc = URLController()
        let loginURL = uc.loginURL
        
        let regNo = registrationNumber.text!
        let psswd = password.text!
        
        // Save registration number and password in UserDefaults
        let defaults = UserDefaults.standard
        defaults.set(regNo, forKey: "regNo")
        defaults.set(psswd, forKey: "psswd")
        defaults.synchronize()
        
        let parameters = ["regNo": regNo, "psswd": psswd]
        
        Alamofire.request(loginURL, method: .post, parameters: parameters)
            .responseJSON{ response in
                
                
                if let result = response.result.value{
                    
                    let loginData = JSON(result)
                    let statusCode = loginData["status"]["code"].int
                    
                    //Check if user logged in successfully : 
                    
                    if(statusCode==0){
                        
                        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "HomeView")
                        self.show(vc as! UIViewController, sender: vc)
                        
                    } else if (statusCode==12){
                        
                        self.view.makeToast("Invalid Credentials")
                        
                    } else{
                        
                        self.view.makeToast("Internal Server Error")
                        
                    }
                    
                    
                }
        
       
                // Do any additional setup after loading the view, typically from a nib.
        }

        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
