//
//  HomeViewController.swift
//  MyVIT
//
//  Created by Ashwini Purohit on 09/04/17.
//  Copyright © 2017 GDG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {
    
    @IBOutlet weak var greetingsLabel: UILabel!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        let uc = URLController()
        let regNo = UserDefaults.standard.string(forKey: "regNo")!
        let psswd = UserDefaults.standard.string(forKey: "psswd")!
        let refreshURL = uc.refreshURL
        
        
        let parameters = ["regNo": regNo, "psswd": psswd]
        
        Alamofire.request(refreshURL, method: .post, parameters: parameters)
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
                    let userData = JSON(result)
                    self.greetingsLabel.text = "Hey " + userData["name"].string! + "! What's up?"
                }
                
                
                // Do any additional setup after loading the view, typically from a nib.
    
        }
    }

        // Do any additional setup after loading the view.
    

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
