//
//  NoteEditView.swift
//  TestNotesFTC
//
//  Created by Phillip on 26.01.2024.
//

import SwiftUI

struct NoteEditView: View {
    @EnvironmentObject var notesData : Notes
    @State var note: Note
    @State private var text = ""
    @State private var bold = false
    @State private var italic = false
    @State private var fontSize = 20.0
    
    var displayFont: Font {
        let font = Font.system(size: CGFloat(fontSize), weight: bold == true ? .bold : .regular)
        return italic == true ? font.italic() : font
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("TempTitle", text: $note.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal, 30)
                Form {
                    Section {
                        TextEditor(text: $note.description)
                            .textSelection(.enabled)
                            .frame(height: 300)
                            .font(displayFont)
                        Button() {
                            notesData.editNote(id: note.id, title: note.title, description: note.description)
                        } label: {
                            Label("Save", systemImage: "square.and.pencil")
                        }
                    }
                }
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Stepper(
                        value: $fontSize,
                        in: 10...30,
                        step: 10
                    ) {
                        Text("")
                    }
                    Spacer()
                    Toggle(isOn: $bold) {
                        Image(systemName: "bold")
                    }
                    .padding()
                    Toggle(isOn: $italic) {
                        Image(systemName: "italic")
                    }
                }
            }
        }
    }
}

#Preview {
    NoteEditView(note: Note(id: UUID(), title: "TempTitle", description: "TempDescription", timeStamp: ""))
        .environmentObject(Notes())
}
