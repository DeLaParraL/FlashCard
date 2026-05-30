//
//  AddEditCardView.swift
//  FlashCard
//
//  Created by Lily Parra on 5/24/26.
//

import SwiftUI
import SwiftData

struct AddEditCardView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \CardSection.createdAt) private var sections: [CardSection]

    var existingCard: Flashcard?

    @State private var question = ""
    @State private var answer = ""
    @State private var isInterviewMiss = false
    @State private var selectedSection: CardSection? = nil

    var isEditing: Bool { existingCard != nil }

    var isValid: Bool {
        !question.trimmingCharacters(in: .whitespaces).isEmpty &&
        !answer.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.darkGreen.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {

                        // Question
                        FieldLabel(text: "QUESTION")
                        TextEditor(text: $question)
                            .frame(minHeight: 100)
                            .padding(12)
                            .background(Theme.midGreen)
                            .cornerRadius(12)
                            .foregroundColor(Theme.cream)
                            .scrollContentBackground(.hidden)
                            .font(.system(size: 16))

                        // Answer
                        FieldLabel(text: "ANSWER")
                        TextEditor(text: $answer)
                            .frame(minHeight: 140)
                            .padding(12)
                            .background(Theme.midGreen)
                            .cornerRadius(12)
                            .foregroundColor(Theme.cream)
                            .scrollContentBackground(.hidden)
                            .font(.system(size: 16))

                        // Section picker
                        FieldLabel(text: "SECTION")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                SectionChip(
                                    label: "General",
                                    isSelected: selectedSection == nil,
                                    action: { selectedSection = nil }
                                )
                                ForEach(sections) { section in
                                    SectionChip(
                                        label: section.name,
                                        isSelected: selectedSection?.id == section.id,
                                        action: { selectedSection = section }
                                    )
                                }
                            }
                        }

                        // Interview miss toggle
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("INTERVIEW MISS")
                                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                                    .foregroundColor(Theme.cream.opacity(0.6))
                                Text("Flag if this was answered incorrectly in an interview")
                                    .font(.system(size: 13))
                                    .foregroundColor(Theme.cream.opacity(0.5))
                            }
                            Spacer()
                            Toggle("", isOn: $isInterviewMiss)
                                .tint(Theme.interviewRed)
                        }
                        .padding(16)
                        .background(
                            Theme.midGreen
                                .overlay(
                                    isInterviewMiss ?
                                    Theme.interviewRed.opacity(0.15) : Color.clear
                                )
                        )
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    isInterviewMiss ? Theme.interviewRed.opacity(0.6) : Color.clear,
                                    lineWidth: 1.5
                                )
                        )

                        // Save button
                        Button(action: save) {
                            HStack {
                                Image(systemName: isEditing ? "checkmark.circle.fill" : "plus.circle.fill")
                                Text(isEditing ? "Save Changes" : "Add Card")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(Theme.darkGreen)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(isValid ? Theme.cream : Theme.cream.opacity(0.3))
                            .cornerRadius(14)
                        }
                        .disabled(!isValid)

                        Spacer().frame(height: 40)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                }
            }
            .navigationTitle(isEditing ? "Edit Card" : "New Card")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(Theme.cream)
                }
            }
            .toolbarBackground(Theme.darkGreen, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .onAppear { loadExistingCard() }
    }

    func loadExistingCard() {
        guard let card = existingCard else { return }
        question = card.question
        answer = card.answer
        isInterviewMiss = card.isInterviewMiss
        selectedSection = card.section
    }

    func save() {
        if let card = existingCard {
            card.question = question
            card.answer = answer
            card.isInterviewMiss = isInterviewMiss
            card.section = selectedSection
        } else {
            let card = Flashcard(
                question: question,
                answer: answer,
                isInterviewMiss: isInterviewMiss,
                section: selectedSection
            )
            modelContext.insert(card)
        }
        dismiss()
    }
}

struct FieldLabel: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .bold, design: .monospaced))
            .foregroundColor(Theme.cream.opacity(0.55))
    }
}

struct SectionChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(isSelected ? Theme.darkGreen : Theme.cream)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Theme.cream : Theme.midGreen)
                .cornerRadius(20)
        }
    }
}
