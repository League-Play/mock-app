//
//  ContentView.swift
//  SocketTest
//
//  Created by Eric Ming on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    let mockUser = "user1"
    @ObservedObject var websocket = WebsocketModel()
    @State var username = ""
    @State private var textInput = ""
    var body: some View {
        if websocket.flow == nil {
            ProgressView("Loading...")
                .onAppear() {
                    websocket.sendMessage(RedirectAction(user: mockUser).encodeToString()!)
                }
        } else if websocket.flow == "Home" {
            LoginView(username: $username)
                .environmentObject(websocket)
        } else if websocket.flow == "Lobby" {
            LobbyView()
                .environmentObject(websocket)
        } else if websocket.flow == "GameReport" {
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
