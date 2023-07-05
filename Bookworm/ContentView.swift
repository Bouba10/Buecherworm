//
//  ContentView.swift
//  Bookworm
//
//  Created by Boubacar sidiki barry on 04.07.23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors : [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books : FetchedResults <Book>
    
    @State var showAddScreen = false
    
   
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailsView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }.onDelete(perform: deletBooks)
            }
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement : .navigationBarTrailing){
                        
                        Button{
                            showAddScreen = true
                            
                        }label: {
                            Label("Add Book", systemImage: "plus")
                        }
                        .sheet(isPresented: $showAddScreen){
                            AddBookView()
                            
                        }
                    }
                    
                }
            
        }
            
        
        .padding()
    }
    
    func deletBooks(at offsets : IndexSet){
        for offset in offsets {
            // find the book in our offsets
            let book = books[offset]
            
            //delet form the context
            
            moc.delete(book)
        }
        
        // save the context
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
