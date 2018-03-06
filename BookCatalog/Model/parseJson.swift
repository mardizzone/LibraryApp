//
//  parseJson.swift
//  BookCatalog
//
//  Created by Michael Ardizzone on 3/4/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation

//JSON parser class
class parseJSON {
    class func parseBooks(data: Data) -> [Book]? {
        let decoder = JSONDecoder()
        do {
            let bookJson = try decoder.decode([Book].self, from: data)
            return bookJson
        } catch {
            print("error trying to convert data to JSON")
            print(error)
            return nil
        }
    }
    
    class func parseSingleBook(data: Data) -> Book? {
        let decoder = JSONDecoder()
        do {
            let bookJson = try decoder.decode(Book.self, from: data)
            return bookJson
        } catch {
            print("error trying to convert data to JSON")
            print(error)
            return nil
        }
    }
}
