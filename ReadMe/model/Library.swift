//
//  Library.swift
//  ReadMe
//
//  Created by Rodrigo Rovaron on 11/11/22.
//

import SwiftUI
import Combine

enum Section: CaseIterable {
    case readMe
    case finished
}

class Library: ObservableObject {
    
    var sortedBooks: [Section: [Book]] {
        get {
                let groupedBooks = Dictionary(grouping: booksCache, by: \.readMe)
                return Dictionary(uniqueKeysWithValues: groupedBooks.map {
                    (($0.key ? .readMe : .finished), $0.value)
                })
            }
        set {
            booksCache =
                newValue.sorted {
                    $1.key == .finished
                }
                .flatMap {
                    $0.value
                }
        }
    }
    
    func sortBooks() {
        booksCache =
            sortedBooks.sorted {
                $1.key == .finished
            }
            .flatMap {
                $0.value
            }
        objectWillChange.send()
    }
    
    func addNewBook(_ book: Book, image: Image?) {
        booksCache.insert(book, at: 0)
        images[book] = image
    }
    
    func deleteBook(atOffSets offsets: IndexSet, section: Section) {
        
        let booksBeforeDeletion = booksCache
        sortedBooks[section]?.remove(atOffsets: offsets)
        
        for change in booksCache.difference(from: booksBeforeDeletion) {
            if case .remove(_, let deletedBook, _) = change {
                images[deletedBook] = nil
            }
        }
    }
    
    func moveBooks(oldOffsets: IndexSet, newOffSet: Int, section: Section) {
        sortedBooks[section]?.move(fromOffsets: oldOffsets, toOffset: newOffSet)
    }
    
    @Published private var booksCache: [Book] = [
        .init(title: "Ein Neues Land", author: "Shaun Tan"),
        .init(title: "Bosch", author: "Laurinda Dixon", microReview: "Earthily Delightful."),
        .init(title: "Dare to Lead", author: "Brené Brown"),
        .init(title: "Blasting for Optimum Health Recipe Book", author: "NutriBullet"),
        .init(title: "Drinking with the Saints", author: "Michael P. Foley", microReview: "One of Ozma's favorites! 😻"),
        .init(title: "A Guide to Tea", author: "Adagio Teas"),
        .init(title: "The Life and Complete Work of Francisco Goya", author: "P. Gassier & J Wilson", microReview: "Book too large for a micro-review!"),
        .init(title: "Lady Cottington's Pressed Fairy Book", author: "Lady Cottington"),
        .init(title: "How to Draw Cats", author: "Janet Rancan"),
        .init(title: "Drawing People", author: "Barbara Bradley"),
        .init(title: "What to Say When You Talk to Yourself", author: "Shad Helmstetter")
    ]
    
    @Published var images: [Book: Image] = [:]
}
