//
//  Networking.swift
//  BookCatalog
//
//  Created by Michael Ardizzone on 3/3/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Alamofire
import Foundation

//Networking Functions
class Networking {
    
    class func getBooks(completionHandler : @escaping ([Book]) -> Void) {
        Alamofire.request("http://prolific-interview.herokuapp.com/5a977bef6ee747000a5545db/books", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { response in
            switch response.result {
            case .success(let value):
                if let bookJson = parseJSON.parseBooks(data: value) {
                    completionHandler(bookJson)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    class func getSingleBook(id: Int, completionHandler: @escaping (Book) -> Void) {
        Alamofire.request("http://prolific-interview.herokuapp.com/5a977bef6ee747000a5545db/books/\(id)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { response in
            switch response.result {
            case .success(let value):
                if let bookJson = parseJSON.parseSingleBook(data: value) {
                    completionHandler(bookJson)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    class func addBook(inputParams: [String : String]) {
        let params =  inputParams
        Alamofire.request("http://prolific-interview.herokuapp.com/5a977bef6ee747000a5545db/books", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
    }
    
    class func deleteBook(id: Int, completionHandler: @escaping () -> () ) {
        Alamofire.request("http://prolific-interview.herokuapp.com/5a977bef6ee747000a5545db/books/\(id)", method: .delete).responseJSON(completionHandler: { response in
            completionHandler()
        })
    }
    
    class func deleteAllBooks(completionHandler: @escaping () -> () ) {
        Alamofire.request("http://prolific-interview.herokuapp.com/5a977bef6ee747000a5545db/clean", method: .delete).responseJSON(completionHandler: { response in
            completionHandler()
        })
    }
    
    class func checkOutBook(name: String, id: Int, completionHandler: @escaping (Book) -> Void ) {
        let params = ["lastCheckedOutBy": name]
        Alamofire.request("http://prolific-interview.herokuapp.com/5a977bef6ee747000a5545db/books/\(id)", method: .put, parameters: params, encoding: JSONEncoding.default, headers: nil).responseData { response in
            switch response.result {
            case .success(let value):
                if let bookJson = parseJSON.parseSingleBook(data: value) {
                    completionHandler(bookJson)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
