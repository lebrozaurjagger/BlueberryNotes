//
//  NoteView.swift
//  TestNotesFTC
//
//  Created by Phillip on 26.01.2024.
//

import SwiftUI

struct NoteView: View {
    @EnvironmentObject var eachNote: Notes
    
    var body: some View {
        List {
            ForEach(eachNote.notes) { note in
                NavigationLink(destination: NoteEditView(note: note)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .lineLimit(1)
                                .font(.headline)
                                .foregroundColor(Color(.systemIndigo))
                            Text(note.description)
                                .lineLimit(2)
                                .padding(.vertical, 4)
                            Text(note.timeStamp)
                                .font(.subheadline)
                                .foregroundColor(Color(.systemGray2))
                        }
                    }
                }
            }
            .onDelete(perform: deleteNote)
        }
    }
    
    func deleteNote(at offsets: IndexSet) {
        eachNote.notes.remove(atOffsets: offsets)
    }
}

#Preview {
    NoteView()
        .environmentObject(Notes())
}
