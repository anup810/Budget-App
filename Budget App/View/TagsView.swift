//
//  TagsView.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-12.
//

import SwiftUI

struct TagsView: View {
    @FetchRequest(sortDescriptors: []) private var tags: FetchedResults<Tag>
    @Binding var selectedTags: Set<Tag>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) { 
                ForEach(tags) { tag in
                    Text(tag.name ?? "")
                        .font(.headline)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(
                            selectedTags.contains(tag)
                            ? AnyView(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                            : AnyView(Color.gray.opacity(0.3))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                        .shadow(color: selectedTags.contains(tag) ? .blue.opacity(0.4) : .clear, radius: 5, x: 0, y: 2)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                if selectedTags.contains(tag) {
                                    selectedTags.remove(tag)
                                } else {
                                    selectedTags.insert(tag)
                                }
                            }
                        }
                        .foregroundColor(selectedTags.contains(tag) ? .white : .black)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct TagsViewContainerView: View {
    @State private var selectedTags: Set<Tag> = []
    
    var body: some View {
        TagsView(selectedTags: $selectedTags)
            .environment(\.managedObjectContext, CoreDataProvider.preview.context)
    }
}

#Preview {
    TagsViewContainerView()
}
