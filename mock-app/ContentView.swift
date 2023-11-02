//
//  ContentView.swift
//  SocketTest
//
//  Created by Eric Ming on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var websocket = Websocket()
    @State private var textInput = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            TextField(
                "Send this to websocket",
                text: $textInput
            ).onSubmit {
                websocket.sendMessage(textInput)
            }
            List(websocket.messages, id: \.self) { message in
                Text(message)
            }
        }
        .padding()
    }
}

class Websocket: ObservableObject {
    @Published var messages = [String]()
    private var webSocketTask: URLSessionWebSocketTask?
    init() {
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
                    print(error.localizedDescription)
                case .success(let message):
                    switch message {
                    case .string(let text):
                        self.messages.append(text)
                        break
                    case .data(let data):
                        //handle binary data
                        print(data)
                    @unknown default:
                        break
                    }
            }
        }
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
