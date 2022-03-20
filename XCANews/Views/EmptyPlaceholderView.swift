//
//  EmptyPlaceholderVIew.swift
//  XCANews
//
//  Created by Elelan on 3/18/22.
//

import SwiftUI

struct EmptyPlaceholderView: View {
    
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = self.image {
                image.imageScale(.large)
                    .foregroundColor(Color.green)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
}

struct EmptyPlaceholderVIew_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPlaceholderView(text: "No Bookmarks", image: Image(systemName: "bookmark"))
    }
}
