//
//  Responses.swift
//  mock-app
//
//  Created by Eric Ming on 11/18/23.
//

import Foundation

class Response: Decodable {
    var responseId: String
    init(response: String) {
        self.responseId = response
    }
    
    // Implement the initializer required by Decodable
    // This initializer will be called during the decoding process
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Decode each property from the container
        self.responseId = try container.decode(String.self, forKey: .responseId)
    }

    enum CodingKeys: String, CodingKey {
        case responseId
    }
}

