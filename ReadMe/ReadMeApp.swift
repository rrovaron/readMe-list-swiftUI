//
//  ReadMeApp.swift
//  ReadMe
//
//  Created by Rodrigo Rovaron on 11/11/22.
//

import SwiftUI

@main
struct ReadMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Library())
        }
    }
}
