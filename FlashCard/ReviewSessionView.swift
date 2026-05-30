//
//  ReviewSessionView.swift
//  FlashCard
//
//  Created by Lily Parra on 5/24/26.
//

import SwiftUI

struct ReviewSessionView: View {
    let cards: [Flashcard]
    @Environment(\.dismiss) private var dismiss

    @State private var currentIndex = 0
    @State private var isFlipped = false
    @State private var dragOffset: CGSize = .zero
    @State private var sessionComplete = false

    // Track results this session
    @State private var gotItCount = 0
    @State private var notSureCount = 0
    @State private var reviewAgainCount = 0

    var currentCard: Flashcard? {
        guard currentIndex < cards.count else { return nil }
        return cards[currentIndex]
    }

    var progress: Double {
        guard !cards.isEmpty else { return 1 }
        return Double(currentIndex) / Double(cards.count)
    }

    var body: some View {
        ZStack {
            Theme.darkGreen.ignoresSafeArea()

            if sessionComplete || cards.isEmpty {
                SessionCompleteView(
                    total: cards.count,
                    gotIt: gotItCount,
                    notSure: notSureCount,
                    reviewAgain: reviewAgainCount,
                    onDismiss: { dismiss() }
                )
            } else {
                VStack(spacing: 0) {
                    // Top bar
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

                        Text("\(currentIndex + 1) / \(cards.count)")
                            .font(.system(size: 14, weight: .semibold, design: .monospaced))
                            .foregroundColor(Theme.cream.opacity(0.6))

                        Spacer()

                        // Placeholder to balance layout
                        Color.clear.frame(width: 36, height: 36)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 60)

                    // Progress bar
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(Theme.midGreen).frame(height: 4)
                            Capsule()
                                .fill(Theme.cream)
                                .frame(width: geo.size.width * progress, height: 4)
                                .animation(.spring(), value: progress)
                        }
                    }
                    .frame(height: 4)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                    Spacer()

                    // Card
                    if let card = currentCard {
                        FlipCard(card: card, isFlipped: $isFlipped)
                            .frame(height: 380)
                            .padding(.horizontal, 20)
                            .offset(x: dragOffset.width)
                            .rotationEffect(.degrees(dragOffset.width / 20))
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        if isFlipped {
                                            dragOffset = value.translation
                                        }
                                    }
                                    .onEnded { value in
                                        handleSwipe(value.translation.width)
                                    }
                            )
                    }

                    Spacer()

                    // Action buttons (only after flip)
                    if isFlipped {
                        HStack(spacing: 12) {
                            RatingButton(
                                label: "Review Again",
                                icon: "arrow.counterclockwise",
                                color: Theme.reviewRed
                            ) {
                                rate(.reviewAgain)
                            }
                            RatingButton(
                                label: "Not Sure",
                                icon: "questionmark",
                                color: Theme.notSureYellow
                            ) {
                                rate(.notSure)
                            }
                            RatingButton(
                                label: "Got It",
                                icon: "checkmark",
                                color: Theme.gotItGreen
                            ) {
                                rate(.gotIt)
                            }
                        }
                        .padding(.horizontal, 20)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    } else {
                        Text("Tap card to reveal answer")
                            .font(.system(size: 14))
                            .foregroundColor(Theme.cream.opacity(0.4))
                            .padding(.bottom, 4)
                    }

                    Spacer().frame(height: 40)
                }
            }
        }
        .animation(.spring(response: 0.35), value: isFlipped)
    }

    func handleSwipe(_ width: CGFloat) {
        let threshold: CGFloat = 100
        if abs(width) > threshold && isFlipped {
            let status: ReviewStatus = width > 0 ? .gotIt : .reviewAgain
            withAnimation(.spring()) {
                dragOffset = CGSize(width: width > 0 ? 600 : -600, height: 0)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                rate(status)
                dragOffset = .zero
            }
        } else {
            withAnimation(.spring()) { dragOffset = .zero }
        }
    }

    func rate(_ status: ReviewStatus) {
        guard let card = currentCard else { return }
        card.reviewStatus = status

        switch status {
        case .gotIt: gotItCount += 1
        case .notSure: notSureCount += 1
        case .reviewAgain: reviewAgainCount += 1
        case .unreviewed: break
        }

        withAnimation(.spring(response: 0.3)) {
            isFlipped = false
            dragOffset = .zero
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            if currentIndex + 1 >= cards.count {
                withAnimation { sessionComplete = true }
            } else {
                currentIndex += 1
            }
        }
    }
}

// MARK: - Flip Card

struct FlipCard: View {
    let card: Flashcard
    @Binding var isFlipped: Bool

    var body: some View {
        ZStack {
            // Front
            CardFace(
                text: card.question,
                label: "QUESTION",
                isFront: true,
                isInterviewMiss: card.isInterviewMiss
            )
            .opacity(isFlipped ? 0 : 1)
            .rotation3DEffect(.degrees(isFlipped ? -90 : 0), axis: (x: 0, y: 1, z: 0))

            // Back
            CardFace(
                text: card.answer,
                label: "ANSWER",
                isFront: false,
                isInterviewMiss: card.isInterviewMiss
            )
            .opacity(isFlipped ? 1 : 0)
            .rotation3DEffect(.degrees(isFlipped ? 0 : 90), axis: (x: 0, y: 1, z: 0))
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.75)) {
                isFlipped.toggle()
            }
        }
    }
}

struct CardFace: View {
    let text: String
    let label: String
    let isFront: Bool
    let isInterviewMiss: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                Text(label)
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(isFront ? Theme.cream.opacity(0.4) : Theme.darkGreen.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)

                // Scrollable content area
                ScrollView(showsIndicators: !isFront) {
                    Text(text)
                        .font(.system(size: text.count > 120 ? 16 : 20, weight: .medium))
                        .foregroundColor(isFront ? Theme.cream : Theme.darkGreen)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }

                if isFront {
                    HStack {
                        Image(systemName: "hand.tap.fill")
                        Text("tap to flip")
                    }
                    .font(.system(size: 12))
                    .foregroundColor(Theme.cream.opacity(0.3))
                    .padding(.top, 12)
                }
            }
            .padding(28)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(isFront ? Theme.cardBack : Theme.cream)
            .cornerRadius(24)
            .shadow(color: .black.opacity(0.25), radius: 20, y: 8)

            // Interview miss badge
            if isInterviewMiss {
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.system(size: 22))
                    .foregroundColor(Theme.interviewRed)
                    .padding(16)
            }
        }
    }
}


// MARK: - Rating Button

struct RatingButton: View {
    let label: String
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .bold))
                Text(label)
                    .font(.system(size: 11, weight: .semibold))
                    .multilineTextAlignment(.center)
            }
            .foregroundColor(color)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(color.opacity(0.15))
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(color.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

// MARK: - Session Complete

struct SessionCompleteView: View {
    let total: Int
    let gotIt: Int
    let notSure: Int
    let reviewAgain: Int
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Text("✓")
                .font(.system(size: 64))

            VStack(spacing: 8) {
                Text("Session Complete")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Theme.cream)
                Text("\(total) cards reviewed")
                    .font(.system(size: 16))
                    .foregroundColor(Theme.cream.opacity(0.5))
            }

            VStack(spacing: 12) {
                ResultRow(label: "Got It", value: gotIt, total: total, color: Theme.gotItGreen)
                ResultRow(label: "Not Sure", value: notSure, total: total, color: Theme.notSureYellow)
                ResultRow(label: "Review Again", value: reviewAgain, total: total, color: Theme.reviewRed)
            }
            .padding(.horizontal, 32)

            Spacer()

            Button(action: onDismiss) {
                Text("Done")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Theme.darkGreen)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Theme.cream)
                    .cornerRadius(14)
            }
            .padding(.horizontal, 32)

            Spacer().frame(height: 40)
        }
    }
}

struct ResultRow: View {
    let label: String
    let value: Int
    let total: Int
    let color: Color

    var fraction: Double {
        total == 0 ? 0 : Double(value) / Double(total)
    }

    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Text(label)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Theme.cream)
                Spacer()
                Text("\(value)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(color)
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Theme.midGreen).frame(height: 6)
                    Capsule()
                        .fill(color)
                        .frame(width: geo.size.width * fraction, height: 6)
                }
            }
            .frame(height: 6)
        }
    }
}
