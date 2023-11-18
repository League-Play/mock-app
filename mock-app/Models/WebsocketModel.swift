//
//  Websocket.swift
//  mock-app
//
//  Created by Eric Ming on 11/2/23.
//

import Foundation

class WebsocketModel: ObservableObject {
    @Published var messages = [String]()
    @Published var flow: String?
    private var userId: String
    private var webSocketTask: URLSessionWebSocketTask?
    init(user: String) {
        userId = user
        self.connect()
    }
    private func connect() {
        guard let url = URL(string: "ws://localhost:8080/echo") else {
            return
        }
        let request = URLRequest(url: url)
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        receiveMessage()
    }
    private func receiveMessage() {
        webSocketTask?.receive { result in
            switch result {
                case .failure(let error):
                self.flow = nil
                    print(error.localizedDescription)
                case .success(let message):
                    switch message {
                    case .string(let text):
                        print("Message received! : " + text)
                        self.handleMessages(message: text);
                        DispatchQueue.main.async {
                            self.messages.append(text)
                        }
                        break
                    case .data(let data):
                        //handle binary data
                        print(data)
                    @unknown default:
                        self.flow = nil
                        break
                    }
                self.receiveMessage()
            }
        }
    }
    private func handleMessages(message: String) {
        do {
            // Use JSONDecoder to decode JSON into your class
            let response = try JSONDecoder().decode(Response.self, from: message.data(using: .utf8)!)
            // Now you can use yourClassInstance with the decoded data
            print(response.responseId)
            switch response.responseId {
            case "UserInfoRequest":
                print("here")
                sendUserInfo()
                break;
            case "FlowResponse":
                let flowResponse = try JSONDecoder().decode(FlowResponse.self, from: message.data(using: .utf8)!)
                flow = flowResponse.flow
            default:
                print("default")
            }
            
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    private func sendUserInfo() {
        sendMessage(UserInfoAction(user: userId).encodeToString()!)
    }
    func sendMessage(_ message: String) {
        guard let data = message.data(using: .utf8) else {return}
        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
