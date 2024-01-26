//
//  AddNoteView.swift
//  TestNotesFTC
//
//  Created by Phillip on 26.01.2024.
//

import SwiftUI

struct AddNoteView: View {
    @State private var title = ""
    @State private var description = ""
    @EnvironmentObject var notes: Notes
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        dismiss()
                    }
                } label: {
                    Label("Back", systemImage: "chevron.left")
                }
                Spacer()
            }
            .padding()
            TextField("Give your note a title", text: $title)
                .padding(.horizontal)
                .font(.title)
                .fontWeight(.bold)
            TextField("Give your note a title", text: $description)
                .padding(.horizontal)
            Spacer()
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        notes.addNote(title: title, description: description)
                        dismiss()
                    }
                } label: {
                    Label("Add note!", systemImage: "square.and.pencil")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    AddNoteView()
        .environmentObject(Notes())
}
