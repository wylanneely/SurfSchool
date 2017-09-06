//
//  User.swift
//  SurfSchool
//
//  Created by ALIA M NEELY on 8/15/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation
import CloudKit


class User {
    
    let username: String
    var displayName: String
    var age: Int
    var expirience: Expirience
    var yearsSurfingInMonths: Int
    let accountType: UserAccountType
    var reviews: [Review] = []
    var pricePerHour: Int = 30
    
    
    var ckRecord: CKRecord {
        let record = CKRecord(recordType: User.kCKRecordType, recordID: recordID)
        record.setValue(username, forKey: kName)
        record.setValue(displayName, forKey: kDisplayName)
        record.setValue(age, forKey: kAge)
        record.setValue(expirience, forKey: kExpirience)
        record.setValue(yearsSurfingInMonths, forKey: kYearsSurfingInMonths)
        record.setValue(accountType, forKey: kAccountType)
        record.setValue(recordUUID.uuidString, forKey: kRecordUUIDS)
        record.setValue(pricePerHour, forKey: kPricePerHour)
        return record
    }
    var recordID: CKRecordID {
      return CKRecordID(recordName: recordUUID.uuidString)
    }
    let recordUUID: UUID
    
    init(name: String, displayName: String = "", age: Int, expirience: Expirience, yearsSurfingInMonths: Int, accountType: UserAccountType) {
        self.username = name
        self.displayName = displayName
        self.age = age
        self.expirience = expirience
        self.yearsSurfingInMonths = yearsSurfingInMonths
        self.accountType = accountType
        self.recordUUID = UUID()
    }
    init?(cloudKitRecord: CKRecord){
        guard let name = cloudKitRecord[kName] as? String,
            let displayName = cloudKitRecord[kDisplayName] as? String,
            let age = cloudKitRecord[kAge] as? Int,
            let recordIDString = cloudKitRecord[kRecordUUIDS] as? String,
            let expirience = cloudKitRecord[kExpirience] as? Expirience,
            let accountType = cloudKitRecord[kAccountType] as? UserAccountType,
            let yearsSurfing = cloudKitRecord[kYearsSurfingInMonths] as? Int,
            let pricePerHour = cloudKitRecord[kPricePerHour] as? Int else {return nil}
        guard let recordUUID = UUID(uuidString: recordIDString) else {return nil}
        
        self.username = name
        self.pricePerHour = pricePerHour
        self.displayName = displayName
        self.age = age
        self.expirience = expirience
        self.yearsSurfingInMonths = yearsSurfing
        self.accountType = accountType
        self.recordUUID = recordUUID
    }
    
    //MARK: - Keys
    static fileprivate let kCKRecordType = "User"
    private let kName = "name"
    private let kDisplayName = "displayName"
    private let kAge = "age"
    private let kExpirience = "expirience"
    private let kYearsSurfingInMonths = "yearsSurfing"
    private let kRecordUUIDS = "recordUUIDS"
    private let kAccountType = "accountType"
    private let kPricePerHour = "pricePerHour"
    
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        if lhs.recordUUID == rhs.recordUUID {
            return true
        } else {
            return false
        }
    }
}

enum Expirience: String {
    case neverBeen = "NeverBeen"
    case catchingWhitewash = "CatchingWhiteWash"
    case standingWhitewash = "StandingInWhiteWash"
    case ridingFace = "RidingFace"
    case turningFace = "TurningFace"
    case instructor = "Instructor"
}

enum UserAccountType: String {
    case instructor = "Instructor"
    case student = "Student"
}
