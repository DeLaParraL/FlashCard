//
//  ReviewPickerView.swift
//  FlashCard
//
//  Created by Lily Parra on 5/24/26.
//

import SwiftUI
import SwiftData


struct ReviewPickerView: View {
    @Query(sort: \CardSection.createdAt) private var sections: [CardSection]
    @Query(sort: \Flashcard.createdAt) private var allCards: [Flashcard]

    @State private var reviewTarget: ReviewTarget? = nil

    enum ReviewTarget: Identifiable {
        case all
        case section(CardSection)
        case missedOnly

        var id: String {
            switch self {
            case .all: return "all"
            case .section(let s): return s.persistentModelID.hashValue.description            case .missedOnly: return "missed"
            }
        }
    }

    var missedCards: [Flashcard] {
        allCards.filter { $0.isInterviewMiss }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.darkGreen.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        // Header
                        VStack(alignment: .leading, spacing: 4) {
                            Text("REVIEW MODE")
                                .font(.system(size: 11, weight: .semibold, design: .monospaced))
                                .foregroundColor(Theme.cream.opacity(0.5))
                            Text("Choose a Deck")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Theme.cream)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 60)
                        .padding(.bottom, 28)

                        // All cards
                        ReviewDeckTile(
                            title: "All Cards",
                            subtitle: "Every card in the deck",
                            count: allCards.count,
                            icon: "rectangle.stack.fill",
                            accentColor: Theme.cream
                        ) {
                            reviewTarget = .all
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 10)

                        // Interview misses
                        if !missedCards.isEmpty {
                            ReviewDeckTile(
                                title: "Interview Misses",
                                subtitle: "Cards flagged from last interview",
                                count: missedCards.count,
                                icon: "exclamationmark.circle.fill",
                                accentColor: Theme.interviewRed
                            ) {
                                reviewTarget = .missedOnly
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 10)
                        }

                        // Divider
                        Text("BY SECTION")
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundColor(Theme.cream.opacity(0.4))
                            .padding(.horizontal, 20)
                            .padding(.top, 12)
                            .padding(.bottom, 12)

                        // Per-section tiles
                        ForEach(sections) { section in
                            let count = section.cards.count
                            ReviewDeckTile(
                                title: section.name,
                                subtitle: "Section deck",
                                count: count,
                                icon: "folder.fill",
                                accentColor: Theme.lightGreen
                            ) {
                                reviewTarget = .section(section)
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 10)
                        }

                        Spacer().frame(height: 100)
                    }
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(item: $reviewTarget) { target in
                ReviewSessionView(cards: cardsFor(target))
            }
        }
    }

    func cardsFor(_ target: ReviewTarget) -> [Flashcard] {
        switch target {
        case .all:
            return allCards.shuffled()
        case .section(let s):
            return s.cards.shuffled()
        case .missedOnly:
            return missedCards.shuffled()
        }
    }
}

struct ReviewDeckTile: View {
    let title: String
    let subtitle: String
    let count: Int
    let icon: String
    let accentColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(accentColor.opacity(0.15))
                        .frame(width: 50, height: 50)
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(accentColor)
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Theme.cream)
                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundColor(Theme.cream.opacity(0.5))
                }

                Spacer()

                Text("\(count)")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(accentColor)
                    .frame(minWidth: 32, minHeight: 32)
                    .background(accentColor.opacity(0.15))
                    .clipShape(Circle())

                Image(systemName: "chevron.right")
                    .font(.system(size: 13))
                    .foregroundColor(Theme.cream.opacity(0.3))
            }
            .padding(16)
            .background(Theme.midGreen)
            .cornerRadius(16)
        }
    }
}
