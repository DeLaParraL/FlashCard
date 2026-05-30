//
//  CardDetailView.swift
//  FlashCard
//
//  Created by Lily Parra on 5/24/26.
//
import SwiftUI

@MainActor
struct CardDetailView: View {
    let card: Flashcard
    @Environment(\.dismiss) private var dismiss
    @State private var isFlipped = false

    var body: some View {
        ZStack {
            Theme.darkGreen.ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Theme.cream.opacity(0.7))
                            .frame(width: 36, height: 36)
                            .background(Theme.midGreen)
                            .clipShape(Circle())
                    }

                    Spacer()

                    if card.isInterviewMiss {
                        HStack(spacing: 6) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundColor(Theme.interviewRed)
                            Text("Interview Miss")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(Theme.interviewRed)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Theme.interviewRed.opacity(0.15))
                        .cornerRadius(20)
                    }

                    Spacer()

                    StatusBadge(status: card.reviewStatus)
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)

                Spacer()

                FlipCard(card: card, isFlipped: $isFlipped)
                    .frame(height: 480)
                    .padding(.horizontal, 20)
            
                Spacer()

                if !isFlipped {
                    Text("Tap card to reveal answer")
                        .font(.system(size: 14))
                        .foregroundColor(Theme.cream.opacity(0.4))
                        .padding(.bottom, 8)
                }

                if let section = card.section {
                    Text(section.name.uppercased())
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundColor(Theme.cream.opacity(0.3))
                        .padding(.bottom, 40)
                }
            }
        }
    }
}

struct StatusBadge: View {
    let status: ReviewStatus

    var label: String {
        switch status {
        case .gotIt:       return "Got It"
        case .notSure:     return "Not Sure"
        case .reviewAgain: return "Review Again"
        case .unreviewed:  return "Unreviewed"
        }
    }

    var color: Color {
        switch status {
        case .gotIt:       return Theme.gotItGreen
        case .notSure:     return Theme.notSureYellow
        case .reviewAgain: return Theme.reviewRed
        case .unreviewed:  return Theme.cream.opacity(0.4)
        }
    }

    var body: some View {
        Text(label)
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(color)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(color.opacity(0.15))
            .cornerRadius(20)
    }
}
