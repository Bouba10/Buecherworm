//
//  DetailsView.swift
//  Bookworm
//
//  Created by Boubacar sidiki barry on 04.07.23.
//

import SwiftUI
import CoreData
struct DetailsView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    
    let book : Book
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(book.genre ?? "Fantasy")
                        .resizable()
                        .scaledToFit()
                    
                    Text(book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                Text(book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(book.review ?? "No review")
                    .padding()
                
                RatingView(rating: .constant(Int(book.rating)))
                    .font(.largeTitle)
                
                Text((book.date ?? Date.now), format: .dateTime.day().month().year())
              
                
            }
            .navigationTitle(book.title ?? "Unknown Book")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Delete Book ?", isPresented: $showAlert){
                Button("Delete",role: .destructive, action: deleteBook)
                Button("Cancel", role: .cancel){}
            }message: {
                Text("Are you sure you want to the delete ?")
            }
            .toolbar {
                Button{
                    showAlert = true
                }label:{
                    Label("Delete this Book", systemImage: "trash")
                }
            }
        }
        
    }
    func deleteBook(){
        
        moc.delete(book)
        
        try? moc.save()
        dismiss()
        
    }
}
//
//struct DetailsView_Previews: PreviewProvider {
//    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//
//    static var previews: some View {
//        let book = Book(context: moc)
//        book.title = "Test book"
//        book.author = "Test author"
//        book.genre = "Fantasy"
//        book.rating = 4
//        book.review = "This was a great book; I really enjoyed it."
//
//        return NavigationView {
//            DetailsView(book: book)
//        }
//    }
//}
