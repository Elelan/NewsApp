//
//  ArticleListView.swift
//  XCANews
//
//  Created by Elelan on 3/18/22.
//

import SwiftUI

struct ArticleListView: View {
    
    let articles: [Article]
    @State private var selectedArticle: Article?
    
    
    var body: some View {
        List {
            ForEach(articles) { item in
                ArticleRowView(article: item)
                    .onTapGesture {
                        selectedArticle = item
                    }
                
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .sheet(item: $selectedArticle) {
            SafariView(url: $0.articleURL)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    
    @StateObject static var viewModel = BookmarkViewModel.shared
    
    static var previews: some View {
        NavigationView {
            ArticleListView(articles: Article.previewData)
                .environmentObject(viewModel)
        }
    }
}
