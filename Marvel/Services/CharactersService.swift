//
//  CharactersService.swift
//  Marvel
//
//  Created by Monika Saini on 10/03/22.
//  Copyright © 2022 capgemini. All rights reserved.
//

import Foundation

protocol CharactersServiceProtocol {
    // Fetches characters
    func getCharacters(completion: @escaping (_ success: Bool, _ results: CharactersList?, _ error: String?) -> ())
    
    // Fetches details for character with specified id
    func characterDetails(with id: Int, completion: @escaping (_ success: Bool, _ result: Character?, _ error: String?) -> ())

    // Loads image for the given movie
    //func loadImage(for character: Character, size: ImageSize) -> AnyPublisher<UIImage?, Never>
}

class CharactersService: CharactersServiceProtocol {
    func getCharacters(completion: @escaping (Bool, CharactersList?, String?) -> ()) {
        let url = ApiConstants.baseUrl.appendingPathComponent("/characters")
        let hashValue:String = ApiConstants.ts + ApiConstants.privateKey + ApiConstants.apiKey
        let digest = HashProvider().MD5(string: hashValue)
        let parameters: [String : String] = [
            "apikey": ApiConstants.apiKey,
            "ts": ApiConstants.ts,
            "hash": digest
        ]
        
        HttpRequestHelper().GET(url: url.absoluteString, params: parameters, httpHeader: .application_json) { success, data in
            if success {
                do {

                    let model = try JSONDecoder().decode(CharactersList.self, from: data!)
                    print(model.results.count)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Characters to model")
                }
            } else {
                completion(false, nil, "Error: Characters GET Request failed")
            }
        }
    }
    
    
    func characterDetails(with id: Int, completion: @escaping (Bool, Character?, String?) -> ()) {
        let url = ApiConstants.baseUrl.appendingPathComponent("/characters")
        let hashValue:String = ApiConstants.ts+ApiConstants.privateKey+ApiConstants.apiKey
        let digest = HashProvider().MD5(string: hashValue)
        let parameters: [String : String] = [
            "apikey": ApiConstants.apiKey,
            "ts": ApiConstants.ts,
            "hash": digest
        ]
        
        HttpRequestHelper().GET(url: url.absoluteString, params: parameters, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Character.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Character to model")
                }
            } else {
                completion(false, nil, "Error: Character-detail GET Request failed")
            }
        }
    }
}
