//
//  NewsTabView.swift
//  XCANews
//
//  Created by Elelan on 3/18/22.
//

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var newsVM = NewsViewModel()
    
    
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .onAppear {
                    async {await newsVM.loadArticles() }
                }
                .navigationTitle(newsVM.selectedCategory.text)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        
        switch newsVM.phase {
        case .empty: ProgressView()
        //case .success(let articles) where articles.isEmpty:
        default: EmptyView()
        }
    }
    
    private var articles: [Article] {
        if case let .success(articles) = newsVM.phase {
            return articles
        } else {
            return []
        }
    }
}

struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(newsVM: NewsViewModel(articles: Article.previewData, selectedCategory: .general))
    }
}
