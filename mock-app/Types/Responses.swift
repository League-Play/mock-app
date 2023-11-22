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

class FlowResponse: Decodable {
    var flow: String
    
    init(response: String) {
        self.flow = response
    }
    
    // Implement the initializer required by Decodable
    // This initializer will be called during the decoding process
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Decode each property from the container
        self.flow = try container.decode(String.self, forKey: .flow)
    }

    enum CodingKeys: String, CodingKey {
        case flow
    }
}

class JoinLobbyResponse: Decodable {
    var username: String
    init(response: String) {
        self.username = response
    }
    
    // Implement the initializer required by Decodable
    // This initializer will be called during the decoding process
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Decode each property from the container
        self.username = try container.decode(String.self, forKey: .username)

    }

    enum CodingKeys: String, CodingKey {
        case username
    }
}

class ReadyResponse: Decodable {
    var username: String
    var isReady: Bool
    init(response: String) {
        self.username = response
        self.isReady = false
    }
    
    // Implement the initializer required by Decodable
    // This initializer will be called during the decoding process
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Decode each property from the container
        self.username = try container.decode(String.self, forKey: .username)
        self.isReady = try container.decode(Bool.self, forKey: .isReady)

    }

    enum CodingKeys: String, CodingKey {
        case username
        case isReady
    }
}
