//
//  NewsApiResponse.swift
//  XCANews
//
//  Created by Elelan on 3/18/22.
//

import Foundation

struct NewsApiResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
}
