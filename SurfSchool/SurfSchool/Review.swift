//
//  Review.swift
//  SurfSchool
//
//  Created by ALIA M NEELY on 8/15/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation
import CloudKit


class Review {
    
    let title: String
    let rating: Int
    let body: String
    let reviewID: CKRecordID 
    let evaluatedUser: CKReference
    
    var ckRecord: CKRecord{
        let record =  CKRecord(recordType: Review.kCKRecordType, recordID: self.ckRecordID)
        record.setValue(title, forKey: kTitle)
        record.setValue(rating, forKey: kRating)
        record.setValue(body, forKey: kBody)
        record.setValue(reviewID, forKey: kAuthor) // RecordID ForCreator
        record.setValue(evaluatedUser, forKey: kEvaluatedUser)
        record.setValue(reviewRecordUUID.uuidString, forKey: kReviewRecordUUIDS)
        
        return record
    }
    var ckRecordID: CKRecordID {
        return CKRecordID(recordName: reviewRecordUUID.uuidString)
    }
    var reviewRecordUUID: UUID
    
    //MARK: - Inits
    
    init(title: String, rating: Int, body: String, author: User, evaluatedUser: CKReference){
        self.title = title
        self.rating = rating
        self.body = body
        self.reviewID = author.recordID
        self.evaluatedUser = evaluatedUser
        self.reviewRecordUUID = UUID()
    }
    
    init?(cloudKitRecord: CKRecord){
        guard let title = cloudKitRecord[kTitle] as? String,
            let rating = cloudKitRecord[kRating] as? Int,
            let body = cloudKitRecord[kBody] as? String,
            let authorRecordID = cloudKitRecord[kAuthor] as? CKRecordID,
            let evaluatedUserID = cloudKitRecord[kEvaluatedUser] as? CKReference,
            let reviewRecordUUIDS = cloudKitRecord[kReviewRecordUUIDS] as? String  else { return nil }
        guard let reviewRecordUUID = UUID(uuidString: reviewRecordUUIDS) else { return nil }
        
        self.title = title
        self.rating = rating
        self.body = body
        self.reviewID = authorRecordID
        self.evaluatedUser = evaluatedUserID
        self.reviewRecordUUID = reviewRecordUUID
        
    }
    
    
    //MARK: - Keys
    static private let kCKRecordType = "Review"
    private let kTitle = "title"
    private let kRating = "rating"
    private let kBody = "body"
    private let kAuthor = "author"
    private let kEvaluatedUser = "evaluatedUser"
    private let kReviewRecordUUIDS = "reviewRecordID"
    
}
















