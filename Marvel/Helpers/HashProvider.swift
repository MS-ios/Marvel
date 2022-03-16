//
//  HashProvider.swift
//  Marvel
//
//  Created by Monika Saini on 11/03/22.
//  Copyright © 2022 capgemini. All rights reserved.
//

import Foundation
import CryptoKit


class HashProvider{
    
   func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
