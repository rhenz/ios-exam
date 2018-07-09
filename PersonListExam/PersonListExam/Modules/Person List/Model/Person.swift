//
//  Person.swift
//  PersonListExam
//
//  Created by JLCS on 09/07/2018.
//  Copyright © 2018 JLCS. All rights reserved.
//

import Foundation

public struct Person: Codable {
    let firstName: String?
    let lastName: String?
    let birthday: String?
    let emailAddress: String?
    let mobileNumber: String?
    let address: String?
    let contactPerson: String?
    let contactPersonNumber: String?
    
    
    
    var age: Int {
        get {
            if let bday = birthday {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "m/d/yyyy"
                let birthdate = dateFormatter.date(from: bday)
                
                let now = Date()
                let calendar = Calendar.current
                
                let ageComponents = calendar.dateComponents([.year], from: birthdate!, to: now)
                let age = ageComponents.year!
                
                return age
            }
            return 0
        }
    }
    
    var birthdayPrettyPrinted: String {
        get {
        
            if let bday = birthday {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "m/d/yyyy"
                let birthdate = dateFormatter.date(from: bday)
                
                guard let date = birthdate else { return "" }
                dateFormatter.dateStyle = .long
                return dateFormatter.string(from: date)
            }
            
            return ""
        }
    }
    
    var fullName: String {
        get {
            guard let fName = firstName, let lName = lastName else { return "" }
            return fName + " " + lName
        }
    }
}
