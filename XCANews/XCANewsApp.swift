//
//  XCANewsApp.swift
//  XCANews
//
//  Created by Elelan on 3/17/22.
//

import SwiftUI

@main
struct XCANewsApp: App {
    
    @StateObject var viewModel = BookmarkViewModel.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
