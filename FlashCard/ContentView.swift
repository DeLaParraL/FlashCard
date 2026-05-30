//
//  ContentView.swift
//  FlashCard
//
//  Created by Lily Parra on 5/24/26.
//
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTab = 0
    @State private var showAddCard = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Theme.darkGreen.ignoresSafeArea()

            TabView(selection: $selectedTab) {
                CardListView()
                    .tag(0)

                ReviewPickerView()
                    .tag(1)

                Color.clear
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            CustomTabBar(
                selectedTab: $selectedTab,
                onAdd: { showAddCard = true }
            )
        }
        .sheet(isPresented: $showAddCard) {
            AddEditCardView(existingCard: nil)
        }
        .onAppear {
            SeedData.seedIfNeeded(context: modelContext)
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    var onAdd: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(icon: "rectangle.stack.fill", label: "Cards", isSelected: selectedTab == 0) {
                selectedTab = 0
            }

            Button(action: onAdd) {
                ZStack {
                    Circle()
                        .fill(Theme.cream)
                        .frame(width: 56, height: 56)
                        .shadow(color: .black.opacity(0.3), radius: 8, y: 4)
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Theme.darkGreen)
                }
            }
            .offset(y: -16)
            .frame(maxWidth: .infinity)

            TabBarButton(icon: "brain.head.profile", label: "Review", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
        .padding(.top, 12)
        .background(
            Theme.midGreen
                .ignoresSafeArea(edges: .bottom)
                .shadow(color: .black.opacity(0.25), radius: 12, y: -4)
        )
    }
}

struct TabBarButton: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(label)
                    .font(.system(size: 11, weight: .medium))
            }
            .foregroundColor(isSelected ? Theme.cream : Theme.cream.opacity(0.45))
            .frame(maxWidth: .infinity)
        }
    }
}
