//
//  DetailPersonVC.swift
//  PersonListExam
//
//  Created by JLCS on 09/07/2018.
//  Copyright © 2018 JLCS. All rights reserved.
//

import UIKit

class DetailPersonVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactPersonLabel: UILabel!
    @IBOutlet weak var contactPersonNumberLabel: UILabel!
    
    
    // MARK: - Properties
    var person: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        displayInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Helpers
    func displayInfo() {
        if let person = self.person {
            self.firstNameLabel.text = person.firstName ?? ""
            self.lastNameLabel.text = person.lastName ?? ""
            self.birthdayLabel.text = person.birthdayPrettyPrinted
            self.ageLabel.text = "\(person.age) Years Old"
            self.mobileNumberLabel.text = person.mobileNumber ?? ""
            self.emailAddressLabel.text = person.emailAddress ?? ""
            self.addressLabel.text = person.address ?? ""
            self.contactPersonLabel.text = person.contactPerson ?? ""
            self.contactPersonNumberLabel.text = person.contactPersonNumber ?? ""
        }
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
