//
//  NewsViewModel.swift
//  XCANews
//
//  Created by Elelan on 3/18/22.
//

import SwiftUI

enum DataFetchPase<T> {
    case empty
    case success(T)
    case failure(Error)
}

@MainActor
class NewsViewModel: ObservableObject {
    
    @Published var phase = DataFetchPase<[Article]>.empty
    @Published var selectedCategory: Category
    private let newsApi = NewsApi.shared
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.selectedCategory = selectedCategory
    }
    
    func loadArticles() async {
        phase = .empty
        do {
            let articles = Article.previewData//try await newsApi.fetch(from: selectedCategory)
            phase = .success(articles)
        } catch {
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
}
