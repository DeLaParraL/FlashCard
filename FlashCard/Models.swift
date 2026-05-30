//
//  Models.swift
//  FlashCard
//
//  Created by Lily Parra on 5/24/26.
//

import Foundation
import SwiftData

@Model
class CardSection {
    var name: String
    var createdAt: Date
    @Relationship(deleteRule: .cascade) var cards: [Flashcard]

    init(name: String) {
        self.name = name
        self.createdAt = Date()
        self.cards = []
    }
}

@Model
class Flashcard {
    var question: String
    var answer: String
    var isInterviewMiss: Bool
    var createdAt: Date
    var section: CardSection?

    // Review tracking
    var reviewStatus: ReviewStatus

    init(question: String, answer: String, isInterviewMiss: Bool = false, section: CardSection? = nil) {
        self.question = question
        self.answer = answer
        self.isInterviewMiss = isInterviewMiss
        self.createdAt = Date()
        self.section = section
        self.reviewStatus = .unreviewed
    }
}

enum ReviewStatus: String, Codable {
    case unreviewed
    case gotIt
    case notSure
    case reviewAgain
}
