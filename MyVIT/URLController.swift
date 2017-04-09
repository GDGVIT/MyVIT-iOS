//
//  URLController.swift
//  MyVIT
//
//  Created by Ashwini Purohit on 09/04/17.
//  Copyright © 2017 GDG. All rights reserved.
//

import Foundation

class URLController {
    static let port = "10443"
    static let baseURL = "https://myffcs.in:"+port+"/campus/vellore"
    let loginURL = baseURL + "/login"
    static let refreshURL = baseURL + "/refresh"
    
    
}
