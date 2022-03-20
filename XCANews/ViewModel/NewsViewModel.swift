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

struct FetchTaskToken: Equatable {
    var category: Category
    var token: Date
}

@MainActor
class NewsViewModel: ObservableObject {
    
    @Published var phase = DataFetchPase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken
    private let newsApi = NewsApi.shared
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
    }
    
    func loadArticles() async {
        phase = .success(Article.previewData)
//        phase = .empty
//        do {
//            let articles = try await newsApi.fetch(from: fetchTaskToken.category)
//            phase = .success(articles)
//        } catch {
//            print(error.localizedDescription)
//            phase = .failure(error)
//        }
    }
}
