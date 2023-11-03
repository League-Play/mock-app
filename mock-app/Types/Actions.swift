//
//  Actions.swift
//  mock-app
//
//  Created by Eric Ming on 11/2/23.
//

import Foundation

class Action: Encodable {
    var action: String
    init(action: String) {
        self.action = action
    }
}

class RedirectAction: Action {
    var user: String
    init(user: String) {
        self.user = user
        super.init(action: "Redirect")
    }
    
    func encodeToString() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Optional for human-readable output

        do {
            let jsonData = try encoder.encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                return jsonString
            } else {
                return nil
            }
        } catch {
            print("Error encoding to JSON: \(error)")
            return nil
        }
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(action, forKey: .action)
        try container.encode(user, forKey: .user)
    }
    
    private enum CodingKeys: String, CodingKey {
        case action
        case user
    }
}

class JoinLobbyAction: Action {
    var username: String
    init(username: String) {
        self.username = username
        super.init(action: "JoinLobby")
    }
    
    func encodeToString() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Optional for human-readable output

        do {
            let jsonData = try encoder.encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                return jsonString
            } else {
                return nil
            }
        } catch {
            print("Error encoding to JSON: \(error)")
            return nil
        }
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(action, forKey: .action)
        try container.encode(username, forKey: .username)
    }
    
    private enum CodingKeys: String, CodingKey {
        case action
        case username
    }
}

class ReadyAction: Action {
    var username: String
    var ready: Bool
    init(username: String, ready: Bool) {
        self.username = username
        self.ready = ready
        super.init(action: "Ready")
    }
    func encodeToString() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Optional for human-readable output

        do {
            let jsonData = try encoder.encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                return jsonString
            } else {
                return nil
            }
        } catch {
            print("Error encoding to JSON: \(error)")
            return nil
        }
    }
}
