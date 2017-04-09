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
        
        let parameters = ["regNo": regNo, "psswd": psswd]
        
        Alamofire.request(loginURL, method: .post, parameters: parameters)
            .responseJSON{ response in
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        print("STATUS OK")
                    case 401:
                        print("Internal error")
                    default:
                        print("Network error")
                    }
            
        }
                if let result = response.result.value{
                    let loginData = JSON(result)
                    print(loginData)
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
