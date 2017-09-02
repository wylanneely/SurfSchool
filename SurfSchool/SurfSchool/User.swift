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
    
    let name: String
    var displayName: String
    var age: Int
    var expirience: Expirience
    var yearsSurfingInMonths: Int
    let accountType: UserAccountType
    let reviews: [Review] = []
    
    var ckRecord: CKRecord {
        let record = CKRecord(recordType: User.kCKRecordType, recordID: recordID)
        record.setValue(name, forKey: kName)
        record.setValue(displayName, forKey: kDisplayName)
        record.setValue(age, forKey: kAge)
        record.setValue(expirience, forKey: kExpirience)
        record.setValue(yearsSurfingInMonths, forKey: kYearsSurfingInMonths)
        record.setValue(accountType, forKey: kAccountType)
        record.setValue(recordUUID.uuidString, forKey: kRecordUUIDS)
        return record
    }
    var recordID: CKRecordID {
      return CKRecordID(recordName: recordUUID.uuidString)
    }
    let recordUUID: UUID
    
    init(name: String, displayName: String = "", age: Int, expirience: Expirience, yearsSurfing: Int, accountType: UserAccountType) {
        self.name = name
        self.displayName = displayName
        self.age = age
        self.expirience = expirience
        self.yearsSurfingInMonths = yearsSurfing
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
            let yearsSurfing = cloudKitRecord[kYearsSurfingInMonths] as? Int else {return nil}
        guard let recordUUID = UUID(uuidString: recordIDString) else {return nil}
        
        self.name = name
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
