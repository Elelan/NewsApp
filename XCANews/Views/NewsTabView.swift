//
//  NewsTabView.swift
//  XCANews
//
//  Created by Elelan on 3/18/22.
//

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var viewModel = NewsViewModel()
    
    
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .task(id: viewModel.fetchTaskToken, loadTask)
                .refreshable(action: refreshTask)
                .navigationTitle(viewModel.fetchTaskToken.category.text)
                .navigationBarItems(trailing: menu)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        
        switch viewModel.phase {
        case .empty: ProgressView()
        case .success(let articles) where articles.isEmpty: EmptyPlaceholderView(text: "No Articles", image: Image(systemName: "bookmark"))
        case .failure(let error): RetryView(text: error.localizedDescription, retryAction: refreshTask)
        default: EmptyView()
        }
    }
    
    private var articles: [Article] {
        if case let .success(articles) = viewModel.phase {
            return articles
        } else {
            return []
        }
    }
    
    @Sendable
    private func loadTask() async{
        await viewModel.loadArticles()
    }
    
    @Sendable
    private func refreshTask() {
        viewModel.fetchTaskToken = FetchTaskToken(category: viewModel.fetchTaskToken.category, token: Date())
    }
    
    private var menu: some View {
        Menu {
            Picker("Category", selection: $viewModel.fetchTaskToken.category) {
                ForEach(Category.allCases) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
        }
    }
}

struct NewsTabView_Previews: PreviewProvider {
    
    @StateObject static var viewModel = BookmarkViewModel.shared

    static var previews: some View {
        NewsTabView(viewModel: NewsViewModel(articles: Article.previewData, selectedCategory: .general))
            .environmentObject(viewModel)
    }
}
