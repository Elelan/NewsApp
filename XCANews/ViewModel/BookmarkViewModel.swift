//
//  BookmarkViewModel.swift
//  XCANews
//
//  Created by Elelan on 3/19/22.
//

import Foundation


@MainActor
class BookmarkViewModel: ObservableObject {
    
    @Published private(set) var bookmarks: [Article] = []
    private let bookmarkStore = PlistDataStore<[Article]>(fileName: "bookmarks")
    
    static let shared = BookmarkViewModel()
    
    private init() {
        async {
            await load()
        }
    }
    
    private func load() async {
        bookmarks = await bookmarkStore.load() ?? []
    }
    
    func isBookmarked(for article: Article) -> Bool {
        bookmarks.first {article.id == $0.id} != nil
    }
    
    func addBookMark(for article: Article) {
        guard !isBookmarked(for: article) else {
            return
        }
        bookmarks.insert(article, at: 0)
        bookmarkUpdated()
    }
    
    func removeBookmark(for article: Article) {
        guard let index = bookmarks.firstIndex(where: { $0.id == article.id }) else {
            return
        }
        bookmarks.remove(at: index)
        bookmarkUpdated()
    }
    
    private func bookmarkUpdated() {
        let bookmarks = self.bookmarks
        async {
            await bookmarkStore.save(bookmarks)
        }
    }
}
