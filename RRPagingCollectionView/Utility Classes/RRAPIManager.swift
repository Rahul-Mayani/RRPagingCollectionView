//
//  RRAPIManager.swift
//  RRPagingCollectionView
//
//  Created by Rahul Mayani on 31/07/20.
//  Copyright © 2020 RR. All rights reserved.
//

import Foundation

public struct RRAPIManager {
        
    static let shared = RRAPIManager()
    
    func getUserList(_ page: Int, completion: @escaping (RRDataModel?, Error?) -> Void) {
        //create the url with NSURL
        let url = URL(string: "https://reqres.in/api/users?page=\(page)&per_page=8")! //change the url

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        let request = URLRequest(url: url)

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    completion(RRDataModel(fromDictionary: json), nil)
                }
            } catch let error {
                completion(nil, error)
            }
        })
        task.resume()
    }
}
