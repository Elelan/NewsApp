//
//  BookmarkTabView.swift
//  XCANews
//
//  Created by Elelan on 3/19/22.
//

import SwiftUI

struct BookmarkTabView: View {
    
    @EnvironmentObject var viewModel: BookmarkViewModel
    @State var searchText: String = ""
    
    var body: some View {
        
        let articles = self.articles
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView(isEmpty: articles.isEmpty))
                .navigationTitle("Saved Articles")
                .searchable(text: $searchText)
        }
    }
    
    private var articles: [Article] {
        if searchText.isEmpty {
            return viewModel.bookmarks
        }
        return viewModel.bookmarks.filter {
            $0.title.lowercased().contains(searchText.lowercased()) ||
            $0.descriptionText.lowercased().contains(searchText.lowercased())
        }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No saved Articles", image: Image(systemName: "bookmark"))
        }
    }
}

struct BookmarkTabView_Previews: PreviewProvider {
    
    @StateObject static var viewModel = BookmarkViewModel.shared
    
    static var previews: some View {
        BookmarkTabView()
            .environmentObject(viewModel)
    }
}
