//
//  LobbyView.swift
//  mock-app
//
//  Created by Eric Ming on 11/2/23.
//

import SwiftUI

class Player: Equatable, Hashable {
    @Published var username: String
    @Published var isReady: Bool
    init(username: String, isReady: Bool) {
        self.username = username
        self.isReady = isReady
    }
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.username == rhs.username
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(username)
    }
}


struct LobbyView: View {
    // getter for websocket to get the user id
    // send user id ready status to websocket
    // websocket sends all ready users
    @ObservedObject var websocket: WebsocketModel

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Text("Lobby")
                .font(.title)
            
            List(Array(websocket.players), id: \.username) { player in
                HStack {
                    Text(player.username)
                    Spacer()
                    if player.username == mockUser {
                        Button(action: {
                            togglePlayerReadyStatus(player)
                        }) {
                            Text(player.isReady ? "Ready" : "Not Ready")
                                .padding(8)
                                .background(player.isReady ? Color.green : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    } else {
                        Text(player.isReady ? "Ready" : "Not Ready")
                            .padding(8)
                            .background(player.isReady ? Color.green : Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .opacity(0.5)
                    }
                }
            }
        }
        .padding()
    }

    func togglePlayerReadyStatus(_ player: Player) {
        if let index = websocket.players.firstIndex(where: { $0.username == player.username }) {
            if websocket.players[index].username == player.username {
                websocket.players[index].isReady.toggle()
                websocket.sendMessage(ReadyAction(username: websocket.players[index].username, isReady: websocket.players[index].isReady).encodeToString()!)
            }
        }
    }
}

