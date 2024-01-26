//
//  HomeView.swift
//  TestNotesFTC
//
//  Created by Phillip on 26.01.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var notes = Notes()
    @State private var showSheet = false
    @State private var confirmButton = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    NoteView()
                }
            }
            
            .navigationTitle("🫐 Notes")
            .navigationBarItems(trailing: EditButton())
            .sheet(isPresented: $showSheet) {
                AddNoteView()
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .destructive) {
                        withAnimation {
                            confirmButton = true
                        }
                    } label: {
                        Label("Delete all notes", systemImage: "trash")
                    }
                    .tint(Color(.systemRed))
                    .confirmationDialog("Delete ALL notes?", isPresented: $confirmButton, titleVisibility: .visible) {
                        Button("Yes, delete", role: .destructive) {
                            notes.deletAll()
                        }
                    } message: {
                        Text("Remember, you can't undo this action!")
                    }
                }
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button {
                        withAnimation {
                            showSheet.toggle()
                        }
                    } label: {
                        Label("New note", systemImage: "square.and.pencil")
                    }
                }
            }
        }
        .environmentObject(notes)
    }
}

#Preview {
    HomeView()
}
