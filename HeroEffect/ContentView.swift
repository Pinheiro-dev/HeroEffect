//
//  ContentView.swift
//  HeroEffect
//
//  Created by Matheus Pinheiro on 01/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    CardView(item: item)
                }
            }
            .navigationTitle("Hero Effect")
        }
    }
}

/// Card View
struct CardView: View {
    var item: Item
    /// View Properties
    @State private var expandSheet: Bool = false
    var body: some View {
        HStack(spacing: 12) {
            SourceView(id: item.id.uuidString) {
                ImageView()
            }
            
            Text(item.title)
            
            Spacer(minLength: 0)
        }
        .contentShape(.rect)
        .onTapGesture {
            expandSheet.toggle()
        }
        .sheet(isPresented: $expandSheet) {
            DestinationView(id: item.id.uuidString) {
                ImageView()
                    .onTapGesture {
                        expandSheet.toggle()
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
            .interactiveDismissDisabled()
        }
        .heroLayer(id: item.id.uuidString, animate: $expandSheet) {
            ImageView()
        } completion: { _ in
            
        }
    }
    
    @ViewBuilder
    func ImageView() -> some View {
        Image(systemName: item.symbol)
            .font(.title3)
            .foregroundStyle(.white)
            .frame(width: 40, height: 40)
            .background(item.color.gradient, in: .circle)
    }
}

#Preview {
    ContentView()
}

/// Demo Item Model
struct Item: Identifiable {
    var id: UUID = .init()
    var title: String
    var color: Color
    var symbol: String
}

var items: [Item] = [
    .init(title: "Book Icon", color: .red, symbol: "book.fill"),
    .init(title: "Stack Icon", color: .blue, symbol: "square.stack.3d.up"),
    .init(title: "Rectangle Icon", color: .orange, symbol: "rectangle.portrait")
]
