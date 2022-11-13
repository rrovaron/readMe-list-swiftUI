//
//  Book Views.swift
//  ReadMe
//
//  Created by Rodrigo Rovaron on 11/11/22.
//

import SwiftUI


struct TitleAndAuthorStack: View {
    
    var book: Book
    let titleFont: Font
    let authorFont: Font
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(titleFont)
            Text(book.author)
                .font(authorFont)
                .foregroundColor(.secondary)
        }
        .lineLimit(1)
    }
}

extension Book {
    
    struct Image: View {
        
        let image: SwiftUI.Image?
        let title: String
        var size: CGFloat?
        var cornerRadius: CGFloat
        
        var body: some View {
            
            if let image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .cornerRadius(cornerRadius)
            } else {
                let symbol = SwiftUI.Image(title: title) ?? .init(systemName: "book")
                
                symbol
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .foregroundColor(.secondary.opacity(0.5))
            }
        }
    }
}

extension Image {
    init?(title: String) {
        guard
            let character = title.first,
            case let symbolName = "\(character.lowercased()).square",
            UIImage(systemName: symbolName) != nil
        else { return nil }        
        
        self.init(systemName: symbolName)
    }
}

extension Book.Image {
    /// A preview image
    init(title: String) {
        self.init(image: nil, title: title, cornerRadius: .init())
    }
}

extension View {
    var previewInAllColorSchemes: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: preferredColorScheme)
    }
}

struct BookPreviews_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TitleAndAuthorStack(book: .init(), titleFont: .title, authorFont: .title2)
            Book.Image(title: Book().title)
            Book.Image(title: "rodrigo")
            Book.Image(title: "🎉")
        }
        .previewInAllColorSchemes
        
    }
}

