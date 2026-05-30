//
//  FlashCardApp.swift
//  FlashCard
//
//  Created by Lily Parra on 5/24/26.
//

import SwiftUI
import SwiftData

@main
struct FlashcardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [CardSection.self, Flashcard.self])
    }
}
