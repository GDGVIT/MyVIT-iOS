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
    
    // A function to store all the user data into UserDefaults
    
    func storeData(userData: JSON)  {
        
        let defaults = UserDefaults.standard
        defaults.set(userData["name"].string, forKey: "name" )
        
        // Set Grade Summary
        
        let grades = userData["academic_history"]["grade summary"].dictionaryObject
        print(type(of: grades))
        defaults.set(grades, forKey: "grades")
        
        /* You can use grades as : let userGrades = defaults.dictionary(forKey: "grades")!
         -> returns dictionary. 
         To access S grades : let S_Grades = userGrades["S grades"]!
 
        */
        //Faculty Advisor Details
        
        let facultyDetails = userData["faculty_advisor"]["faculty_det"]
        defaults.set(userData["school"].string, forKey: "school" )
        defaults.set(facultyDetails["Name"].string, forKey: "faculty_name" )
        defaults.set(facultyDetails["Designation"].string, forKey: "faculty_designation" )
        defaults.set(facultyDetails["Mobile No/Phone No"].string, forKey: "faculty_contact" )
        defaults.set(facultyDetails["Room No"].string, forKey: "faculty_cabin" )
        defaults.set(facultyDetails["School"].string, forKey: "faculty_school" )
        defaults.set(facultyDetails["photo"].string, forKey: "faculty_photo" )
        defaults.synchronize()
       
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let uc = URLController()
        let regNo = UserDefaults.standard.string(forKey: "regNo")!
        let psswd = UserDefaults.standard.string(forKey: "psswd")!
        let refreshURL = uc.refreshURL
        
        
        
        let parameters = ["regNo": regNo, "psswd": psswd]
        
        Alamofire.request(refreshURL, method: .post, parameters: parameters)
            .responseJSON{ response in
                
                if let result = response.result.value{
                    let userData = JSON(result)
                    self.storeData(userData: userData)
                    let defaults = UserDefaults.standard
                    let firstName = defaults.string(forKey: "name")!.components(separatedBy: " ")[0]
                    self.greetingsLabel.text = "Hey " + firstName + "! What's up?"
                    
                    
                    
                    
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
