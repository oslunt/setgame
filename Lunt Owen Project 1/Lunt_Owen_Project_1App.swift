//
//  Lunt_Owen_Project_1App.swift
//  Lunt Owen Project 1
//
//  Created by IS 543 on 10/16/23.
//

import SwiftUI

@main
struct Lunt_Owen_Project_1App: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(setGame: SetGameViewModel())
        }
    }
}
