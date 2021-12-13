//
//  Session.swift
//  Homework
//
//  Created by Александр on 14.12.2021.
//

import Foundation

//Singletone Session
class Session {
    
    static let instance = Session()
    
    private init(){}
    
    var token: String = ""
    var userId: Int = 0
}
