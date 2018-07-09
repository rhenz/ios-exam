//
//  GetPersonList.swift
//  PersonListExam
//
//  Created by JLCS on 09/07/2018.
//  Copyright © 2018 JLCS. All rights reserved.
//

import Foundation
import Alamofire



typealias response = ([Person]?, Error?)->()
public class GetPersonList {
    
    class func fetch(completion: @escaping response) {
        let url = "https://my.api.mockaroo.com/person_list?key=01e9d5c0"
        
        Alamofire.request(URL(string: url)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                if let error = response.error {
                    completion(nil, error)
                    return
                }
                
                guard let data = response.data else {
                    return
                }
                
                do {
                    let jsondecoder = JSONDecoder()
                    jsondecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedCollection = try jsondecoder.decode([Person].self, from: data)
                    
                    try CacheManager.shared.storage?.setObject(decodedCollection, forKey: "PersonList")
                    
                    completion(decodedCollection, nil)

                } catch (let err){
                    completion(nil, err)
                }
        }
    }
    
}
