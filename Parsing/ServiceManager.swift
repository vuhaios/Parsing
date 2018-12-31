//
//  ServiceManager.swift
//  Parsing
//
//  Created by Sai Sailesh Kumar Suri on 02/11/18.
//  Copyright © 2018 Honeywell. All rights reserved.
//

import UIKit

protocol ServiceManagerDelegate {
    func didReceiveResponseFromServer(booksArrray : NSMutableArray)
}
class ServiceManager: NSObject {
    
    var delegate : ServiceManagerDelegate?
    var titlesArray : NSMutableArray = NSMutableArray.init()
func initiateGETRequest()
{
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=orange"
        var request = URLRequest(url: URL.init(string: urlString)!)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        request.addValue("application/json", forHTTPHeaderField: "Content_Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if data != nil{
                let dict : [String : Any] = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : Any]
                print(dict)
                let itemsArray = dict["items"] as! [Any]
                for dict in itemsArray{
                    let itemDictionary : [String : Any] = dict as! [String : Any]
                    let volumeInfoDictionary : [String : Any] = itemDictionary["volumeInfo"] as! [String : Any]
                    let title : String = volumeInfoDictionary["title"] as! String
                    let publishedDate : String = volumeInfoDictionary["publishedDate"] as! String
                    let contentVersion : String = volumeInfoDictionary["contentVersion"] as! String
                    let dictionary = NSMutableDictionary.init()
                    dictionary.setValue(title, forKey: "title")
                    dictionary.setValue(publishedDate, forKey: "date")
                    dictionary.setValue(contentVersion, forKey: "contentVersion")
                    
                    let searchInfoDictionary : [String : Any] = itemDictionary["searchInfo"] as? [String : Any] ?? [:]
                    let textSnippet : String? = searchInfoDictionary["textSnippet"] as? String ?? ""
                    if let text = textSnippet {
                        dictionary.setValue(text, forKey: "textSnippet")
                    }
                    
                    let salesInfoDict = itemDictionary["salesInfo"] as? [String : Any] ?? [:]
                    let country : String? = salesInfoDict["country"] as? String ?? ""
                    
                    if let text = country {
                        dictionary.setValue(text, forKey: "country")
                    }
                    
                    self.titlesArray.add(dictionary)
                }
                print(self.titlesArray)
                self.delegate?.didReceiveResponseFromServer(booksArrray: self.titlesArray)
            }
        }
        task.resume()
        
    }
    
}
