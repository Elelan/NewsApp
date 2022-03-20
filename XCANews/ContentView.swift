//
//  ContentView.swift
//  XCANews
//
//  Created by Elelan on 3/17/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsTabView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            BookmarkTabView()
                .tabItem{
                    Label("saved", systemImage: "bookmark")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    @StateObject static var viewModel = BookmarkViewModel.shared

    static var previews: some View {
        ContentView()
            .environmentObject(viewModel)
    }
}
