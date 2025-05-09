//
//  AddBookView.swift
//  Bookworm
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    @Environment(\.dismiss) var dismiss
    
    var hasValidBook: Bool {
        !title.isEmpty && !author.isEmpty && !genre.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, createdAt: Date.now)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
                .disabled(!hasValidBook)
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
