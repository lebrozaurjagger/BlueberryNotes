//
//  NotesModel.swift
//  TestNotesFTC
//
//  Created by Phillip on 26.01.2024.
//

import Foundation
import SwiftUI

struct Note : Hashable, Codable, Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var timeStamp: String
}

@MainActor class Notes : ObservableObject {
    private let notesKey = "A2"
    let date = Date()
    var notes: [Note] {
        didSet {
            saveData()
            objectWillChange.send()
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: notesKey) {
            if let decodedNotes = try? JSONDecoder().decode([Note].self, from: data) {
                notes = decodedNotes
                return
            }
        }
        notes = [Note(title: "Туториал 🥳", description: "📋 Чтобы редактировать, нажмите на заметку \r👩‍💻 Чтобы удалить, свайпните влево \r✍️ Чтобы создать нажмите на симвод с карандашом", timeStamp: date.getFormattedDate(format: "yy.MM.dd HH:mm"))]
    }
    
    func addNote(title: String, description: String) {
        let temporaryNote = Note(title: title, description: description, timeStamp: date.getFormattedDate(format: "yy.MM.dd HH:mm"))
        notes.insert(temporaryNote, at: 0)
        saveData()
    }
    
    func editNote(id: UUID, title: String, description: String) {
        if let editingNote = notes.first(where: { $0.id == id }) {
            let index = notes.firstIndex(of: editingNote)
            notes[index!].title = title
            notes[index!].description = description
        }
    }
    
    func deletAll() {
        UserDefaults.standard.removeObject(forKey: notesKey)
        UserDefaults.resetStandardUserDefaults()
        notes = []
    }
    
    private func saveData() {
        if let encodedNotes = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encodedNotes, forKey: notesKey)
        }
    }
}

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
}
