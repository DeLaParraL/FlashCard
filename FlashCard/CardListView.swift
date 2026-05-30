//
//  CardListView.swift
//  FlashCard
//
//  Created by Lily Parra on 5/24/26.
//
import SwiftUI
import SwiftData

struct CardListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \CardSection.createdAt) private var sections: [CardSection]
    @Query(sort: \Flashcard.createdAt) private var allCards: [Flashcard]

    @State private var showAddSection = false
    @State private var cardToEdit: Flashcard? = nil
    @State private var newSectionName = ""
    @State private var activeFilter: StatusFilter? = nil
    @State private var collapsedSections: Set<String> = []

    enum StatusFilter: String, Identifiable {
        case gotIt, notSure, missed
        var id: String { rawValue }

        var title: String {
            switch self {
            case .gotIt:   return "Got It"
            case .notSure: return "Not Sure"
            case .missed:  return "Missed"
            }
        }

        var color: Color {
            switch self {
            case .gotIt:   return Theme.gotItGreen
            case .notSure: return Theme.notSureYellow
            case .missed:  return Theme.interviewRed
            }
        }
    }

    var unsectionedCards: [Flashcard] {
        allCards.filter { $0.section == nil }
    }

    var body: some View {
        ZStack {
            Theme.darkGreen.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {

                    // ── Header ──────────────────────────────────────
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("FLASHCARDS")
                                    .font(.system(size: 11, weight: .semibold, design: .monospaced))
                                    .foregroundColor(Theme.cream.opacity(0.5))
                                Text("Study Deck")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(Theme.cream)
                            }
                            Spacer()
                            Button {
                                showAddSection = true
                            } label: {
                                HStack(spacing: 6) {
                                    Image(systemName: "folder.badge.plus")
                                    Text("Section")
                                        .font(.system(size: 13, weight: .medium))
                                }
                                .foregroundColor(Theme.cream)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(Theme.midGreen)
                                .cornerRadius(20)
                            }
                        }

                        // Stat / filter chips
                        HStack(spacing: 10) {
                            // Total — not tappable
                            VStack(spacing: 2) {
                                Text("\(allCards.count)")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .foregroundColor(Theme.cream)
                                Text("Total")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundColor(Theme.cream.opacity(0.6))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Theme.cream.opacity(0.1))
                            .cornerRadius(12)

                            filterChip(
                                value: allCards.filter { $0.reviewStatus == .gotIt }.count,
                                label: "Got It",
                                filter: .gotIt,
                                color: Theme.gotItGreen
                            )
                            filterChip(
                                value: allCards.filter { $0.reviewStatus == .notSure }.count,
                                label: "Unsure",
                                filter: .notSure,
                                color: Theme.notSureYellow
                            )
                            filterChip(
                                value: allCards.filter { $0.isInterviewMiss }.count,
                                label: "Missed",
                                filter: .missed,
                                color: Theme.interviewRed
                            )
                        }

                        // Active filter hint
                        if let filter = activeFilter {
                            HStack(spacing: 6) {
                                Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(filter.color)
                                Text("Filtering by \"\(filter.title)\" — tap chip to clear")
                                    .font(.system(size: 12))
                                    .foregroundColor(Theme.cream.opacity(0.55))
                            }
                            .transition(.opacity)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 60)
                    .padding(.bottom, 20)

                    // ── Named sections ───────────────────────────────
                    ForEach(sections) { section in
                        let cards = filteredCards(
                            section.cards.sorted { $0.createdAt < $1.createdAt }
                        )
                        if !cards.isEmpty || activeFilter == nil {
                            CollapsibleSection(
                                title: section.name,
                                cards: cards,
                                isCollapsed: collapsedSections.contains(section.name),
                                onToggle: { toggleSection(section.name) },
                                onEdit: { cardToEdit = $0 },
                                onDelete: { modelContext.delete($0) }
                            )
                            .padding(.bottom, 8)
                        }
                    }

                    // ── General / unsectioned ────────────────────────
                    let general = filteredCards(unsectionedCards)
                    if !general.isEmpty {
                        CollapsibleSection(
                            title: "General",
                            cards: general,
                            isCollapsed: collapsedSections.contains("General"),
                            onToggle: { toggleSection("General") },
                            onEdit: { cardToEdit = $0 },
                            onDelete: { modelContext.delete($0) }
                        )
                        .padding(.bottom, 8)
                    }

                    Spacer().frame(height: 100)
                }
            }
        }
        .sheet(item: $cardToEdit) { card in
            AddEditCardView(existingCard: card)
        }
        .alert("New Section", isPresented: $showAddSection) {
            TextField("Section name", text: $newSectionName)
            Button("Create") {
                let trimmed = newSectionName.trimmingCharacters(in: .whitespaces)
                guard !trimmed.isEmpty else { return }
                let section = CardSection(name: trimmed)
                modelContext.insert(section)
                newSectionName = ""
            }
            Button("Cancel", role: .cancel) { newSectionName = "" }
        }
    }

    // MARK: - Helpers

    func toggleSection(_ name: String) {
        withAnimation(.spring(response: 0.3)) {
            if collapsedSections.contains(name) {
                collapsedSections.remove(name)
            } else {
                collapsedSections.insert(name)
            }
        }
    }

    @ViewBuilder
    func filterChip(value: Int, label: String, filter: StatusFilter, color: Color) -> some View {
        let isActive = activeFilter == filter
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                activeFilter = isActive ? nil : filter
            }
        } label: {
            VStack(spacing: 2) {
                Text("\(value)")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(color)
                Text(label)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(color.opacity(0.8))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(isActive ? color.opacity(0.25) : color.opacity(0.12))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isActive ? color : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }

    func filteredCards(_ cards: [Flashcard]) -> [Flashcard] {
        guard let filter = activeFilter else { return cards }
        switch filter {
        case .gotIt:   return cards.filter { $0.reviewStatus == .gotIt }
        case .notSure: return cards.filter { $0.reviewStatus == .notSure }
        case .missed:  return cards.filter { $0.isInterviewMiss }
        }
    }
}

// MARK: - Collapsible Section

struct CollapsibleSection: View {
    let title: String
    let cards: [Flashcard]
    let isCollapsed: Bool
    let onToggle: () -> Void
    let onEdit: (Flashcard) -> Void
    let onDelete: (Flashcard) -> Void

    var body: some View {
        VStack(spacing: 0) {

            // Section header — tap to collapse
            Button(action: onToggle) {
                HStack {
                    Text(title.uppercased())
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundColor(Theme.cream.opacity(0.55))

                    Spacer()

                    Text("\(cards.count)")
                        .font(.system(size: 11, weight: .semibold, design: .monospaced))
                        .foregroundColor(Theme.cream.opacity(0.35))

                    Image(systemName: isCollapsed ? "chevron.down" : "chevron.up")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(Theme.cream.opacity(0.35))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            }
            .buttonStyle(.plain)

            // Card rows — hidden when collapsed
            if !isCollapsed {
                VStack(spacing: 6) {
                    ForEach(cards) { card in
                        CardRowView(
                            card: card,
                            onEdit: { onEdit(card) },
                            onDelete: { onDelete(card) }
                        )
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}

// MARK: - Card Row with Long Press Menu
@MainActor
struct CardRowView: View {
    let card: Flashcard
    let onEdit: () -> Void
    let onDelete: () -> Void

    @State private var confirmDelete = false
    @State private var showDetail = false

    var statusColor: Color {
        switch card.reviewStatus {
        case .gotIt:       return Theme.gotItGreen
        case .notSure:     return Theme.notSureYellow
        case .reviewAgain: return Theme.reviewRed
        case .unreviewed:  return Theme.cream.opacity(0.25)
        }
    }

    var body: some View {
        Button {
            showDetail = true
        } label: {
            HStack(spacing: 12) {
                Circle()
                    .fill(statusColor)
                    .frame(width: 8, height: 8)

                Text(card.question)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Theme.cream)
                    .lineLimit(2)

                Spacer()

                if card.isInterviewMiss {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Theme.interviewRed)
                }

                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(Theme.cream.opacity(0.3))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 13)
            .background(Theme.midGreen.opacity(0.6))
            .cornerRadius(10)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .contextMenu {
            Button {
                onEdit()
            } label: {
                Label("Edit Card", systemImage: "pencil")
            }
            Button(role: .destructive) {
                confirmDelete = true
            } label: {
                Label("Delete Card", systemImage: "trash")
            }
        } preview: {
            // Shows a preview of the card front when long pressing
            VStack(alignment: .leading, spacing: 12) {
                Text("QUESTION")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(Theme.cream.opacity(0.4))
                Text(card.question)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(Theme.cream)
                if card.isInterviewMiss {
                    HStack(spacing: 6) {
                        Image(systemName: "exclamationmark.circle.fill")
                        Text("Interview Miss")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundColor(Theme.interviewRed)
                }
            }
            .padding(20)
            .frame(width: 300)
            .background(Theme.cardBack)
        }
        .confirmationDialog(
            "Delete this card?",
            isPresented: $confirmDelete,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) { onDelete() }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text(card.question)
        }
        .sheet(isPresented: $showDetail) {
            CardDetailView(card: card)
        }
    }
}
