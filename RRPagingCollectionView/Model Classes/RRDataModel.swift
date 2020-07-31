//
//  RRDataModel.swift
//  RRPagingCollectionView
//
//  Created by Rahul Mayani on 31/07/20.
//  Copyright © 2020 RR. All rights reserved.
//

import Foundation

// MARK: - RRDataModel -
struct RRDataModel {

    var data : [UserModel]!
    var page : Int!
    var perPage : Int!
    var total : Int!
    var totalPages : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]){
        
        data = [UserModel]()
        if let dataArray = dictionary["data"] as? [[String: Any]]{
            for dic in dataArray{
                let value = UserModel(fromDictionary: dic)
                data.append(value)
            }
        }
        page = dictionary["page"] as? Int
        perPage = dictionary["per_page"] as? Int
        total = dictionary["total"] as? Int
        totalPages = dictionary["total_pages"] as? Int
    }
}

// MARK: - UserModel -
struct UserModel {

    var avatar : String!
    var email : String!
    var firstName : String!
    var id : Int!
    var lastName : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]){
        avatar = dictionary["avatar"] as? String
        email = dictionary["email"] as? String
        firstName = dictionary["first_name"] as? String
        id = dictionary["id"] as? Int
        lastName = dictionary["last_name"] as? String
    }
}

extension UserModel {
    
    func fullName() -> String {
        return firstName + " " + lastName
    }
}
