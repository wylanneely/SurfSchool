//
//  UserController.swift
//  SurfSchool
//
//  Created by ALIA M NEELY on 9/2/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    static var shared = UserController()
    
    var user: User? = nil
    var localUserRecordID: CKRecordID? = nil
    
    func fetchLocalCKUserRecordID(){
        CKContainer.default().fetchUserRecordID { (record, error) in
            if let error = error {
                print("\(error.localizedDescription)")
            }
            self.localUserRecordID = record
        }
    }
    
    func setPricePerHour(user: User, price: Int) -> User {
        user.pricePerHour = price
        return user
    }
    
    
    
    
    
    
    
}
