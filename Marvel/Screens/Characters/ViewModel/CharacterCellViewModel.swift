//
//  CharacterCellViewModel.swift
//  Marvel
//
//  Created by Monika Saini on 10/03/22.
//  Copyright © 2022 capgemini. All rights reserved.
//

import Foundation

/*
 - Define a closure TYPE for updating a UIImageView once an image downloads.
 - parameter imageData: raw NSData making up the image
*/
public typealias ImageDownloadCompletionClosure = (_ imageData: NSData ) -> Void

struct CharacterCellViewModel {
    let id: Int
    var name: String
    var description: String
    let poster: Thumbnail

    func download(completionHanlder: @escaping ImageDownloadCompletionClosure){
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)

        let url = URL(string: poster.path + "." + poster.thumbnailExtension.rawValue)!
        let request = URLRequest(url:url)
               
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    let rawImageData = NSData(contentsOf: tempLocalUrl)
                    completionHanlder(rawImageData!)
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
            } else {
                print("Error took place while downloading a file. Error description: \(String(describing: error?.localizedDescription))")
            }
        } // end let task
               
        task.resume()
    }
}
