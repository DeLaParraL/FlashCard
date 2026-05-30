//
//  SeedData.swift
//  FlashCard
//
//  Created by Lily Parra on 5/24/26.
//

import Foundation
import SwiftData

struct SeedData {
    @MainActor
    static func seedIfNeeded(context: ModelContext) {
        // Check if already seeded
        let descriptor = FetchDescriptor<CardSection>()
        let existing = (try? context.fetch(descriptor)) ?? []
        guard existing.isEmpty else { return }

        // --- Sections ---
        let behavioral = CardSection(name: "Behavioral & STAR Stories")
        let takeHome = CardSection(name: "Take Home Mastery")
        let swiftFundamentals = CardSection(name: "Swift Fundamentals")
        let xctest = CardSection(name: "XCTest & Testing")
        let mvvm = CardSection(name: "MVVM Deep Dive")
        let healthKit = CardSection(name: "HealthKit & iOS Architecture")
        let systemDesign = CardSection(name: "System Design & Databases")
        let mockInterview = CardSection(name: "Mock Interview Questions")

        [behavioral, takeHome, swiftFundamentals, xctest, mvvm, healthKit, systemDesign, mockInterview].forEach { context.insert($0) }

        // --- BEHAVIORAL & STAR STORIES ---
        let behavioralCards: [(String, String, Bool)] = [
            ("Tell me your 2-minute pitch for this role.",
             "Beat 1 — The hospital problem:\n• Started nursing in 2020, COVID — ER, ICU, pediatric cardiac units\n• Technology was outdated, kept thinking 'this could be so much better'\n• That frustration drove me back to school\n\nBeat 2 — The grind:\n• 2021 — CS degree at UTSA while nursing full time\n• PatchRx (medication adherence tech) → company sold → Apple for almost 2 years\n• Teaching myself iOS the whole time — graduated December 2025\n\nBeat 3 — Cicla:\n• Saw women's health apps being careless with sensitive data\n• Built Cicla — privacy first, everything local, user has total control\n• Integrates HealthKit, animated character that reflects stress and recovery\n• MVVM architecture — because this is a health app and should be treated seriously\n\nBeat 4 — Why WHOOP:\n• You're helping people understand their body's signals in a way that changes behavior\n• As a nurse I saw what happens when people don't have that clarity\n• This isn't just a job that fits my skills — it's a mission I believe in",
             true),

            ("Tell me about a time you led a tough project. (STAR)",
             "Situation: Senior year at UTSA, mobile app development project, team of 4, building in Java on Android Studio.\n\nTask: Two teammates had never coded in Java. Needed to deliver a working mobile app.\n\nAction: Took initiative to lead the project. Taught teammates Java fundamentals, directed them to learning resources, delegated tasks based on their growing skill level, kept the project moving forward.\n\nResult: Successfully delivered the mobile application. Teammates were able to meaningfully contribute. Project completed as a team.\n\nWHOOP connection: 'I naturally step up when there's a knowledge gap on a team. I don't wait for someone to assign me a leadership role — I just do what needs to be done to move things forward.'",
             true),

            ("Tell me about a time you dealt with ambiguity. (STAR)",
             "Situation: First days at PatchRx, minimal training on the product, thrown into a clinical environment.\n\nTask: Had to pitch the product to patients AND answer technical and clinical questions from physicians — with very little background knowledge.\n\nAction: Absorbed everything fast, leaned on available resources, asked questions, learned on the fly, projected confidence while learning in real time.\n\nResult: Ended up with 200+ patients signed up — the most of any clinic in the company.\n\nWHOOP connection: 'Ambiguity doesn't slow me down — it activates me. I figure out what I need to know, find the resources, and execute. That's how I approached learning iOS development from scratch too.'",
             true),

            ("Tell me about a time you collaborated through conflict. (STAR)",
             "Situation: Working at PatchRx at a franchise clinic. Business owner physician wanted the product. The primary working physician did not. I was in the middle.\n\nTask: Navigate competing stakeholders, maintain the working relationship, keep the product in the clinic.\n\nAction: Instead of ignoring the tension or escalating, I created a presentation for the physician and staff explaining exactly how the product worked, what data was collected, and who had access to it.\n\nResult: Discovered his concern was about patient privacy and data surveillance — not the product itself. Reached a mutual professional understanding. Product stayed in the clinic. Working relationship remained intact.\n\nWHOOP connection: 'Conflict is usually just a communication gap. I've learned to find the real concern behind the resistance before trying to solve anything.'",
             true),

            ("Tell me about a time you learned something fast. (STAR)",
             "Situation: Working as a nurse, received a physician order for a blood transfusion requiring a blood warmer — a device I had never used before.\n\nTask: Patient needed the transfusion quickly. Their stability depended on it.\n\nAction: Tracked down the device from another department. Found my organization's own training videos online. Watched them. Did a practice run outside the patient's room to build confidence. Then executed.\n\nResult: Initiated the transfusion within one hour of receiving the order. Improved patient stability and comfort.\n\nWHOOP connection: 'Not knowing something has never stopped me. I find the resources, test my understanding before I execute, and I own the outcome. That's the same approach I take to every new technical challenge.'",
             false),

            ("Tell me about a failure and what you learned. (STAR)",
             "Situation: Working at AppleCare, a customer called after dropping their iPhone in a lake. They wanted to track the device but couldn't access their Apple account due to two-factor authentication.\n\nTask: Help the customer access their account or locate their device.\n\nAction: Spent over 30 minutes exploring every possible avenue — carrier transfer, browser sign-in, Find My — hitting dead end after dead end while the customer grew increasingly deflated.\n\nResult: Customer was ultimately unable to track the device.\n\nWhat I'd do differently: I should have assessed the situation earlier and set honest expectations within the first few minutes. The core issue was clear — no account access, no way to track. Spending 30 minutes gave the customer false hope.\n\nThe lesson: The most compassionate thing you can do is give someone an honest answer early. I carry that into engineering — if something isn't going to work I say so early so the team can pivot.\n\nWHOOP connection: Their engineering blog says 'if you're stuck, just say so.' That AppleCare call taught me that lesson the hard way.",
             true),

            ("What's your biggest weakness?",
             "Honest answer: 'I'm early in my formal testing career. I understand the concepts deeply — testing pyramid, mocks and stubs, XCTest, unit vs integration vs E2E — but I haven't yet worked in a large-scale production test suite.\n\nThat's exactly the kind of experience I'm here to build. I move fast when I'm learning — Cicla is proof of that. I went from zero iOS knowledge to a HealthKit-integrated app with MVVM architecture in under a year while working and finishing my degree.'\n\nKey: Be honest, be specific, show growth mindset, and pivot to evidence.",
             true),

            ("Why should we hire you over someone with more testing experience?",
             "'Because I bring something most candidates don't have — I've seen what happens when health data is wrong or inaccessible. Not abstractly, but in life-or-death clinical contexts.\n\nI'm not just building tests — I'm protecting something I genuinely care about. That changes how I think about quality. For me test coverage isn't a checkbox — it's making sure a real person gets accurate information about their body.\n\nI also learn fast under extreme pressure. Nursing, PatchRx, Apple, Cicla — I've never had the luxury of moving slowly and I've always delivered.'\n\nKey: Lead with unique perspective. Never try to compete on technical experience alone.",
             true),

            ("What don't you know yet?",
             "'I'm early in my formal testing career. I know the concepts and I've applied them in my own projects but I haven't worked in a large-scale production test suite with established automation frameworks.\n\nI also haven't worked with Android testing which this role requires — that's new territory for me. But given how quickly I picked up iOS development while working full time as a nurse and finishing my CS degree, I'm confident I can ramp up fast.\n\nI'd rather be honest about the gap than pretend it doesn't exist — especially in a quality engineering role where honesty and accuracy are the whole job.'\n\nKey: Own it confidently. Show self-awareness. Pivot to evidence of fast learning.",
             true),

            ("Where do you see yourself in 5 years?",
             "'I want to become a strong quality engineer who understands the full system — not just writing tests but understanding the architecture well enough to know where things break before they do.\n\nLonger term I'm interested in the intersection of quality and health tech specifically. I want to be someone who can look at a new health feature and immediately think through all the ways the data could be wrong or misleading — because I understand both the engineering and the clinical implications.\n\nI see WHOOP as the perfect place to build that combination of skills.'",
             false),

            ("Why WHOOP specifically?",
             "'WHOOP is solving a problem I've cared about my whole career — helping people understand what their body is actually telling them in a way that changes behavior.\n\nAs a nurse I watched people get data about their health but not understand it, not trust it, or not have it at the right moment. WHOOP is building tools that close that gap.\n\nWhat excites me specifically is that WHOOP is building features that don't exist anywhere else in consumer wearables — things like musculoskeletal strain tracking and blood pressure monitoring. That's exactly the kind of ambitious work I want to be part of.\n\nAnd the privacy-first philosophy resonates deeply — I built Cicla with the same principle. Member data should belong to the member.'",
             true),

            ("How do you handle being stuck on a technical problem?",
             "Step 1: Research first. Spend appropriate time digging before asking — Google, documentation, Stack Overflow, reading code.\n\nStep 2: Isolate the problem. Can I reproduce it reliably? Is it data, logic, or UI?\n\nStep 3: Rubber duck it. Explain the problem out loud — often you find the answer while explaining.\n\nStep 4: Ask for help. Come with what I've already tried and potential solutions I've thought through. Never just say 'I'm stuck.' Say 'I've tried X and Y, I think it might be Z, can you look at this with me?'\n\nWHOOP specifically said: 'When you are blocked, first take steps to research your challenge. If still blocked, ask your team, communicating the problem AND potential solutions you have thought through.' This is exactly their SWE1 framework.",
             false),
        ]

        for (q, a, miss) in behavioralCards {
            let card = Flashcard(question: q, answer: a, isInterviewMiss: miss, section: behavioral)
            context.insert(card)
        }

        // --- TAKE HOME MASTERY ---
        let takeHomeCards: [(String, String, Bool)] = [
            ("Walk me through the WHOOP recovery trend screen from your take home.",
             "The screen shows a user their recovery score over time with three aggregation options: weekly (W), monthly (M), and 6-month (6M).\n\nAt the top: a large average recovery percentage (52% in the example) and a trend indicator showing change from the previous period (↑11% past week).\n\nIn the middle: a bar chart showing individual daily recovery scores for each day in the selected period. Bars are color-coded — green (67-99%), yellow (34-66%), red (1-33%).\n\nAt the bottom: a recovery breakdown showing how many days fell into each category. In the example: 1x Green, 5x Yellow, 1x Red.\n\nThe user can navigate forward and backward through time periods using arrow controls.",
             true),

            ("Explain Function 1 — currentTimePeriodAverage — to an engineer.",
             "Function 1 calculates the average recovery score for a specific time window.\n\nInputs:\n• aggregation: String — 'w' for week, 'm' for month, '6m' for 6 months\n• startDate: Date — when the window begins\n• dataset: [RecoveryDataPoint] — all recovery scores ever recorded\n\nStep by step:\n1. Uses Calendar.current to calculate the end date based on aggregation\n2. Returns nil immediately for invalid aggregation strings (defensive programming)\n3. Filters the dataset to only data between startDate and endDate\n4. Returns nil if no data exists in that window\n5. Averages the filtered values using reduce and returns the result\n\nReturns: Double? — optional because real data has gaps. Nil is honest — it means no data, not zero recovery.",
             true),

            ("Why does Function 1 return Double? instead of Double?",
             "Because zero would be misleading.\n\nIf there's no recovery data in a time window and we returned 0.0, the user would see a 0% recovery score — implying they had terrible recovery when really they just weren't wearing their WHOOP, had a syncing issue, or had missing measurements.\n\nNil is honest. It tells the app 'no data exists' and the UI can handle that gracefully — show an empty state or a message instead of a misleading number.\n\nIn health data specifically, misleading values have real consequences. Users make decisions about training intensity based on these numbers. A false zero could cause someone to rest when they should train, or vice versa.",
             true),

            ("What happens in Function 1 if you pass an invalid aggregation string?",
             "The switch statement has a default case that immediately returns nil.\n\nThis is defensive programming — protecting against crashes and unexpected behavior from invalid input.\n\nInstead of crashing or returning garbage data, the function gracefully handles the bad input by returning nil, which the caller can handle appropriately.\n\nExample: if someone passes 'daily' or 'yearly' or an empty string, the function returns nil instead of trying to calculate something meaningless.",
             false),

            ("Explain Function 2 — percentageChangeFromPreviousPeriod — to an engineer.",
             "Function 2 calculates how much the recovery average changed compared to the equivalent previous period.\n\nSame inputs as Function 1: aggregation, startDate, dataset.\n\nStep by step:\n1. Calculates the previous period start date by going back one aggregation unit from startDate\n2. Returns nil for invalid aggregation (defensive programming)\n3. Calls Function 1 to get the current period average\n4. Returns nil if current average doesn't exist (no data)\n5. Filters dataset to previous period and calculates previous average\n6. Returns nil if previous data is empty\n7. Returns nil if previousAverage is 0 — can't divide by zero\n8. Returns ((currentAverage - previousAverage) / previousAverage) * 100\n\nReturns: Double? — optional for all the same reasons as Function 1 plus the division by zero case.",
             true),

            ("Why does Function 2 call Function 1 internally instead of recalculating the average itself?",
             "DRY principle — Don't Repeat Yourself.\n\nFunction 1 already solves the problem of calculating an average for a time period. Function 2 needs exactly that calculation for the current period. Instead of duplicating that logic, Function 2 simply calls Function 1.\n\nBenefits:\n1. If the averaging logic ever needs to change, you only change it in one place\n2. Reduces risk of inconsistency — two separate implementations could drift apart\n3. Cleaner, more maintainable code\n4. Easier to test — Function 1 is tested independently, Function 2 builds on that\n\nThis is a fundamental software engineering principle that applies everywhere.",
             true),

            ("What is the percentage change formula and why that formula specifically?",
             "Formula: ((currentAverage - previousAverage) / previousAverage) * 100\n\nThis measures relative change — how much did you change as a percentage of where you started.\n\nExample: going from 50% to 60% recovery:\n((60 - 50) / 50) * 100 = 20% improvement\n\nNot 10% — because 10 points is 20% of your baseline of 50.\n\nWhy relative and not absolute? Because context matters. Going from 50 to 60 is more meaningful than going from 90 to 100 even though both are 10 points — because improving from a low baseline is harder and more significant.\n\nThis is the same reason WHOOP shows percentage change instead of point difference.",
             true),

            ("What happens in Function 2 if previousAverage is 0?",
             "The function returns nil.\n\nTwo reasons:\n\n1. Mathematical: you cannot divide by zero — it's mathematically undefined. The formula ((current - previous) / previous) * 100 would crash or return infinity.\n\n2. Practical: a previousAverage of 0 means either the user had literally zero recovery (extremely rare and clinically significant) or there was no data for the previous period. In either case, a percentage change calculation would be meaningless or misleading.\n\nReturning nil lets the UI handle this gracefully — show 'no comparison available' instead of a nonsensical number.",
             false),

            ("What are your 5 tests and what is the overall testing philosophy?",
             "Test 1 — Average recovery calculation: Tests the core happy path. The average is the most important value on screen — if it's wrong, nothing else matters. User trust starts here.\n\nTest 2 — Recovery category breakdown: Tests green/yellow/red bucketing accuracy. The breakdown is the second most visible element. A miscategorized score gives users a false sense of their recovery trend.\n\nTest 3 — Missing/partial data: Tests behavior when some days have no recovery data. Real data is messy — users forget to wear the device, have syncing issues. The app must not crash or produce misleading averages.\n\nTest 4 — Date range and aggregation boundaries: Tests that w/m/6m produce correct date windows. Timezone bugs and month boundary bugs are invisible until they're not. One wrong day ruins the entire week's data.\n\nTest 5 — API/UI consistency: End-to-end test that the frontend displays exactly what the API returns. Perfect backend logic can still show wrong numbers if something breaks between layers.\n\nOverall philosophy: Every test connects back to user trust in the data. WHOOP's entire value proposition depends on users believing what they see. Bad data destroys that.",
             true),

            ("What is the database design for the recovery trend screen?",
             "Three tables:\n\nusers — stores basic member info\n• id (primary key)\n• email\n• name\n• timezone — critical for correct date grouping\n• created_at, updated_at\n\nrecovery_scores — one row per day of recovery data\n• id (primary key)\n• user_id (foreign key → users.id)\n• recovery_date\n• recovery_score\n• created_at, updated_at\n\nrecovery_categories — defines thresholds for green/yellow/red\n• id (primary key)\n• name (green, yellow, red)\n• min_score\n• max_score\n• display_color\n\nWhy three tables: Separation of concerns and normalization — each table owns one type of data. Reduces repetition and makes maintenance easier.\n\nKey design decision: I did NOT store recovery_category_id on recovery_scores because the category is a derived value — it can always be calculated from the score at query time. This avoids needing to update thousands of historical records if thresholds change.",
             true),

            ("What is the API request structure and why each parameter?",
             "{\n  'userId': 'user_123',\n  'aggregation': 'w',\n  'startDate': '2024-08-08',\n  'timezone': 'America/New_York'\n}\n\nuserId — tells the server whose data to fetch. Without this the server doesn't know which member is requesting.\n\naggregation — tells the server the selected time window. 'w', 'm', or '6m'. Maps directly to Function 1's aggregation parameter.\n\nstartDate — tells the server where the window begins. Combined with aggregation, the server can calculate the end date.\n\ntimezone — critical for correct date grouping. Recovery scores must be grouped by the correct local date for that user. A score recorded at 11:30pm Texas time could be assigned to the wrong day if the server doesn't know the user's timezone.",
             false),

            ("What is the API response structure and why each field?",
             "{\n  'userId': 'user_123',\n  'aggregation': 'w',\n  'startDate': '2024-08-08',\n  'endDate': '2024-08-14',\n  'averageRecovery': 52,\n  'previousPeriodAverage': 50,\n  'percentChange': 4.0,\n  'dataPoints': [...],\n  'breakdown': { 'green': 1, 'yellow': 5, 'red': 1 }\n}\n\naverageRecovery — the main number displayed at the top of the screen.\n\npreviousPeriodAverage + percentChange — needed for the trend indicator (↑11% past week). Backend calculates this so the frontend doesn't need to make a second API call.\n\ndataPoints — array of daily scores with date, value, and category. This is the raw material for the bar chart. Each object = one bar.\n\nbreakdown — the green/yellow/red count displayed at the bottom of the screen.\n\nWhy include category in dataPoints even though it's derived? The backend calculates it at query time and includes it so the frontend doesn't need to know the threshold business logic. Backend owns that logic, frontend just displays.",
             false),

            ("What is this line doing in Function 1: let values = dataset.filter { $0.date >= startDate && $0.date < endDate }.map { $0.value }",
             "This is a chained closure operation on the dataset array.\n\n.filter { $0.date >= startDate && $0.date < endDate }\n— Filters the array to only keep RecoveryDataPoints whose date falls within the window.\n— $0 refers to each element in the array (shorthand closure syntax).\n— >= startDate: include the start date itself.\n— < endDate: exclude the end date (half-open interval).\n\n.map { $0.value }\n— Transforms each RecoveryDataPoint into just its Double value.\n— Instead of an array of RecoveryDataPoints we now have an array of Doubles.\n\nWhy chain them? Cleaner and more readable than two separate variables. This is idiomatic Swift — filter to what you need, then transform to what you want.",
             true),

            ("What is this line doing: let total = values.reduce(0, +)",
             "reduce combines all elements of the array into a single value.\n\nreduce(0, +) means:\n• Start with an initial value of 0\n• For each element in values, add it to the running total using the + operator\n\nThis is equivalent to:\nvar total = 0.0\nfor value in values { total += value }\n\nBut in a single line using functional programming style.\n\nWhy use reduce instead of a for loop? More concise, less error-prone, and idiomatic Swift. The intent is immediately clear — sum all values.",
             false),

            ("What is this line doing: guard let endDate = endDate else { return nil }",
             "This is a guard let statement — early exit pattern.\n\nguard let safely unwraps the optional endDate.\n\nIf endDate is nil (which could happen if Calendar.date(byAdding:) fails), the else block runs and the function returns nil immediately.\n\nIf endDate has a value, it's unwrapped and available for the rest of the function.\n\nWhy guard let instead of if let? guard let exits immediately if the condition fails — it's the 'happy path stays unindented' pattern. The rest of the function can assume endDate is not nil. More readable and prevents deeply nested code.",
             true),
        ]

        for (q, a, miss) in takeHomeCards {
            let card = Flashcard(question: q, answer: a, isInterviewMiss: miss, section: takeHome)
            context.insert(card)
        }

        // --- SWIFT FUNDAMENTALS ---
        let swiftCards: [(String, String, Bool)] = [
            ("What is an optional in Swift?",
             "A value that might exist or might not. Swift forces you to acknowledge that something could be nil instead of crashing silently.\n\nThink of it like a gift box — the box exists but it might be empty. You have to check before using what's inside.\n\nDeclared with ?: var name: String? = nil\n\nWhy it matters: Other languages let you call methods on nil and crash at runtime. Swift makes you handle the nil case at compile time.\n\nIn your take home: Both functions return Double? because recovery data might not exist for a time period. Nil is honest — it means no data, not zero.",
             true),

            ("What is if let and when do you use it?",
             "if let safely unwraps an optional. If the optional has a value, the code inside runs with the unwrapped value. If it's nil, the else block runs.\n\nExample:\nvar name: String? = 'Lily'\nif let name = name {\n    print('Hello \\(name)') // runs if name has a value\n} else {\n    print('No name') // runs if name is nil\n}\n\nUse when: you want to do something if a value exists but the nil case is also a valid path through your code.\n\nDon't use when: failing the nil check should exit the function — use guard let instead.",
             false),

            ("What is guard let and when do you use it?",
             "guard let unwraps an optional but exits early if nil. The unwrapped value is available for the REST of the function, not just inside a block.\n\nExample:\nfunc greet(name: String?) {\n    guard let name = name else {\n        print('No name provided')\n        return // exits function\n    }\n    // name is available and unwrapped here\n    print('Hello \\(name)')\n}\n\nUse when: nil means the function cannot continue — you want to bail out early.\n\nWhy it's better than if let for this case: keeps the happy path unindented and readable. Prevents deeply nested code.",
             true),

            ("What is nil coalescing (??) in Swift?",
             "The ?? operator provides a default value if an optional is nil.\n\nExample:\nlet name: String? = nil\nlet displayName = name ?? 'Guest' // 'Guest' because name is nil\n\nlet score: Double? = 72.0\nlet display = score ?? 0.0 // 72.0 because score has a value\n\nThink of it as: 'use this value if it exists, otherwise use this default.'\n\nWhen to use: when nil is not an error — you just want a sensible fallback. Cleaner than writing if let just to provide a default.",
             false),

            ("What is the difference between struct and class in Swift?",
             "Struct — value type:\n• When you copy a struct you get a completely independent copy\n• Changing one does NOT affect the other\n• SwiftUI Views must be structs\n• Lightweight, no inheritance\n\nClass — reference type:\n• When you copy a class you get a reference to the SAME object\n• Changing one changes BOTH\n• SwiftData @Model requires classes\n• @Observable works on classes\n• Supports inheritance\n\nIn Cicla:\n• SymptomLog is a class — @Model requires it\n• HomeView, HistoryView are structs — SwiftUI requires it\n• HealthKitViewModel is a class — @Observable needs reference type\n\nMemory trick: Struct = photograph (independent copy). Class = Google Doc (shared reference).",
             true),

            ("What is a closure in Swift?",
             "A block of code you can pass around like a variable. Think of it as a function without a name.\n\nSyntax: { (parameters) in body }\n\nExamples:\n// Stored in variable\nlet greet = { (name: String) in print('Hello \\(name)') }\ngreet('Lily')\n\n// Trailing closure syntax\n[1,2,3].filter { $0 > 1 } // shorthand: $0 = first parameter\n\nIn your take home:\ndataset.filter { $0.date >= startDate && $0.date < endDate }\n.map { $0.value }\n\nIn Cicla HealthKit:\nwithCheckedContinuation { continuation in\n    // HealthKit callback wraps into async/await here\n}\n\nWhen to use: passing behavior as a parameter, completion handlers, transforming collections.",
             true),

            ("What is a protocol in Swift?",
             "A contract that defines requirements — properties and methods that conforming types must implement. It doesn't implement anything itself.\n\nExample:\nprotocol Animal {\n    var name: String { get }\n    func makeSound()\n}\n\nstruct Dog: Animal {\n    var name = 'Cici'\n    func makeSound() { print('Woof!') }\n}\n\nSwiftUI uses protocols everywhere:\n• Every View conforms to the View protocol which requires a body property\n• Identifiable protocol requires an id property\n• Codable protocol requires encode/decode capability\n\nWhy protocols matter for testing:\nYou can define a protocol for a dependency, then swap in a fake implementation during tests. This is dependency injection — the foundation of testable code.",
             false),

            ("What is async/await in Swift?",
             "A modern way to handle code that takes time — like network requests or HealthKit queries — without blocking everything else.\n\nasync marks a function that can pause while waiting.\nawait pauses execution at that point until the async function finishes.\n\nExample:\nfunc fetchData() async -> String {\n    // can pause here while waiting\n    return 'Data loaded'\n}\n\nfunc loadScreen() async {\n    let data = await fetchData() // pauses here\n    print(data)\n}\n\nWithout async/await you'd use callbacks — code that runs when something finishes. Async/await makes asynchronous code look like synchronous code — much more readable.\n\nIn Cicla: All HealthKit fetches are async because HealthKit queries take time to complete.",
             true),

            ("What is async let and how did you use it in Cicla?",
             "async let starts an async operation immediately but doesn't wait for it yet. Multiple async let operations run CONCURRENTLY — at the same time.\n\nExample from HealthKitViewModel:\nasync let hrv = service.fetchLatestHRV()\nasync let rhr = service.fetchRestingHeartRate()\nasync let sleep = service.fetchLastNightSleep()\nasync let temp = service.fetchWristTemperature()\n\n// All four fetches start at the same time\n// Then we wait for all of them here:\nlet (hrvResult, rhrResult, sleepResult, tempResult) = await (hrv, rhr, sleep, temp)\n\nWithout async let: each fetch would wait for the previous one to finish — 4x slower.\nWith async let: all four run simultaneously — finished in the time of the slowest one.\n\nWhy it matters: HealthKit data comes from the Apple Watch. Each query takes time. Running them concurrently makes the app feel fast.",
             true),

            ("What is @Observable in Swift and how is it different from ObservableObject?",
             "@Observable is the modern (iOS 17+) replacement for ObservableObject + @Published.\n\nOld way (ObservableObject):\nclass ViewModel: ObservableObject {\n    @Published var name = 'Lily'\n    @Published var score = 0\n}\n\nNew way (@Observable):\n@Observable\nclass ViewModel {\n    var name = 'Lily'\n    var score = 0\n}\n\nBenefits of @Observable:\n• No need to mark every property with @Published\n• More granular updates — SwiftUI only re-renders views that access changed properties\n• Less boilerplate\n• Better performance\n\nIn Cicla: All ViewModels use @Observable — HistoryViewModel, HealthKitViewModel, InsightsViewModel, HelpViewModel, SettingsViewModel.\n\nIn views, use @State instead of @StateObject:\n@State private var viewModel = HistoryViewModel()",
             true),

            ("What is an enum with associated values?",
             "An enum where each case can carry additional data.\n\nBasic enum (no associated values):\nenum Direction { case north, south, east, west }\n\nEnum with associated values:\nenum ViewState {\n    case loading\n    case success(data: [String])\n    case error(message: String)\n}\n\nUsage:\nvar state = ViewState.success(data: ['item1', 'item2'])\n\nswitch state {\ncase .loading:\n    print('Loading...')\ncase .success(let data):\n    print('Got \\(data.count) items')\ncase .error(let message):\n    print('Error: \\(message)')\n}\n\nIn Cicla: WongBakerRating enum has Int raw values and computed properties (emoji, label). CyclePhase has emoji and description properties.",
             false),

            ("What is @Query in SwiftData and why did you use it?",
             "@Query is SwiftData's way to fetch data directly in a SwiftUI view. It automatically updates the view whenever the underlying data changes.\n\nExample:\n@Query private var logs: [SymptomLog]\n@Query private var cycleLogs: [CycleLog]\n\nWhy @Query instead of fetching manually:\n• Reactive — when data changes, the view automatically re-renders\n• Less boilerplate — no need to write fetch descriptors manually in the view\n• Stays in sync with SwiftData's ModelContext automatically\n\nIn Cicla: HomeView uses @Query for logs and cycleLogs. HistoryView uses @Query for filtering and sorting. InsightsView uses @Query for chart data.\n\nNote: @Query is used directly in Views — the actual filtering and business logic lives in the ViewModel. This respects MVVM separation.",
             false),

            ("What is NavigationStack in SwiftUI?",
             "NavigationStack is the modern (iOS 16+) SwiftUI navigation system. It replaces the old NavigationView.\n\nHow it works:\n• Maintains a stack of views\n• Push a view onto the stack: NavigationLink\n• Pop back: the back button or dismiss\n\nExample:\nNavigationStack {\n    List(items) { item in\n        NavigationLink(item.name, value: item)\n    }\n    .navigationDestination(for: Item.self) { item in\n        DetailView(item: item)\n    }\n}\n\nIn Cicla: HomeView wraps everything in NavigationStack. LogSymptomView uses NavigationStack for the step-by-step logging flow.\n\nWhy NavigationStack over NavigationView: More flexible, supports programmatic navigation, handles deep linking better, is the Apple-recommended modern approach.",
             false),
        ]

        for (q, a, miss) in swiftCards {
            let card = Flashcard(question: q, answer: a, isInterviewMiss: miss, section: swiftFundamentals)
            context.insert(card)
        }

        // --- XCTEST & TESTING ---
        let xctestCards: [(String, String, Bool)] = [
            ("What is XCTest and how do you run tests?",
             "XCTest is Apple's built-in testing framework. It's included with Xcode — nothing to install.\n\nHow it works:\n• Create a test file that imports XCTest\n• Create a class that inherits from XCTestCase\n• Write functions that start with 'test'\n• Xcode automatically finds and runs all test functions\n\nRun tests: Cmd+U runs all tests. Click the diamond icon next to a test function to run just that one.\n\nIn Cicla: CiclaTests folder was created automatically when we selected XCTest during project setup.\n\nTest results: Green checkmark = passed. Red X = failed. The test output shows exactly which assertion failed and what values were expected vs actual.",
             true),

            ("What are the five most important XCTest assertions?",
             "XCTAssertEqual(a, b) — passes if a == b\nXCTAssertNil(x) — passes if x is nil\nXCTAssertNotNil(x) — passes if x is NOT nil\nXCTAssertTrue(x) — passes if x is true\nXCTAssertFalse(x) — passes if x is false\n\nAll assertions have an optional message parameter:\nXCTAssertEqual(result, 60.0, 'Average should be 60 for this dataset')\n\nThis message shows when the test fails — makes debugging much faster.\n\nFor your take home specifically:\n• Test happy path: XCTAssertEqual(result, expectedAverage)\n• Test nil returns: XCTAssertNil(result)\n• Test data exists: XCTAssertNotNil(result)",
             true),

            ("What is Arrange Act Assert (AAA)?",
             "The structure every test should follow.\n\nArrange — set up all the inputs and conditions you need\nAct — call the function or perform the action being tested\nAssert — check that the result is what you expected\n\nExample for Function 1:\n// Arrange\nlet startDate = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!\nlet dataset = [\n    RecoveryDataPoint(date: startDate, value: 60),\n    RecoveryDataPoint(date: calendar.date(byAdding: .day, value: 1, to: startDate)!, value: 80),\n]\n\n// Act\nlet result = currentTimePeriodAverage(aggregation: 'w', startDate: startDate, dataset: dataset)\n\n// Assert\nXCTAssertEqual(result, 70.0)\n\nWhy follow this structure: Makes tests readable and predictable. Anyone can look at a test and immediately understand what it does.",
             true),

            ("Write a unit test for currentTimePeriodAverage — happy path weekly average.",
             "func testWeeklyAverage_returnsCorrectAverage() {\n    // Arrange\n    let calendar = Calendar.current\n    let startDate = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!\n    let dataset = [\n        RecoveryDataPoint(\n            date: calendar.date(byAdding: .day, value: 0, to: startDate)!,\n            value: 60\n        ),\n        RecoveryDataPoint(\n            date: calendar.date(byAdding: .day, value: 1, to: startDate)!,\n            value: 80\n        ),\n        RecoveryDataPoint(\n            date: calendar.date(byAdding: .day, value: 2, to: startDate)!,\n            value: 40\n        ),\n    ]\n\n    // Act\n    let result = currentTimePeriodAverage(\n        aggregation: 'w',\n        startDate: startDate,\n        dataset: dataset\n    )\n\n    // Assert\n    XCTAssertEqual(result, 60.0) // (60+80+40)/3 = 60\n}\n\nThis tests the happy path — does the core function work correctly with valid data?",
             true),

            ("Write a unit test for currentTimePeriodAverage — empty dataset returns nil.",
             "func testEmptyDataset_returnsNil() {\n    // Arrange\n    let startDate = Date()\n\n    // Act\n    let result = currentTimePeriodAverage(\n        aggregation: 'w',\n        startDate: startDate,\n        dataset: [] // empty dataset\n    )\n\n    // Assert\n    XCTAssertNil(result)\n}\n\nWhy this test matters: Real data is missing. Users forget to wear their device. This confirms the function handles empty data gracefully instead of returning a misleading zero or crashing.",
             true),

            ("Write a unit test for currentTimePeriodAverage — invalid aggregation returns nil.",
             "func testInvalidAggregation_returnsNil() {\n    // Arrange\n    let startDate = Date()\n    let dataset = [\n        RecoveryDataPoint(date: startDate, value: 75)\n    ]\n\n    // Act\n    let result = currentTimePeriodAverage(\n        aggregation: 'invalid', // not w, m, or 6m\n        startDate: startDate,\n        dataset: dataset\n    )\n\n    // Assert\n    XCTAssertNil(result)\n}\n\nWhy this test matters: Defensive programming — confirms the function handles invalid input gracefully. Tests the default case in the switch statement.",
             false),

            ("Write a unit test that verifies data outside the time window is excluded.",
             "func testDataOutsideWindow_isExcluded() {\n    // Arrange\n    let calendar = Calendar.current\n    let startDate = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!\n    let dataset = [\n        // Inside window — day 1\n        RecoveryDataPoint(\n            date: calendar.date(byAdding: .day, value: 1, to: startDate)!,\n            value: 80\n        ),\n        // Outside window — 30 days later, outside a weekly window\n        RecoveryDataPoint(\n            date: calendar.date(byAdding: .day, value: 30, to: startDate)!,\n            value: 20\n        ),\n    ]\n\n    // Act\n    let result = currentTimePeriodAverage(\n        aggregation: 'w',\n        startDate: startDate,\n        dataset: dataset\n    )\n\n    // Assert — should only average the 80, NOT include the 20\n    XCTAssertEqual(result, 80.0)\n}\n\nWhy this test matters: Validates the date filtering logic — the heart of what makes these functions correct.",
             true),

            ("What is the difference between setUp() and tearDown() in XCTest?",
             "setUp() runs BEFORE each test function. Use it to set up shared state that every test needs.\n\ntearDown() runs AFTER each test function. Use it to clean up — reset state, close connections, delete test data.\n\nExample:\nclass RecoveryTests: XCTestCase {\n    var calendar: Calendar!\n    var startDate: Date!\n\n    override func setUp() {\n        super.setUp()\n        calendar = Calendar.current\n        startDate = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!\n    }\n\n    override func tearDown() {\n        calendar = nil\n        startDate = nil\n        super.tearDown()\n    }\n}\n\nWhy use them: Keeps tests DRY — don't repeat setup code in every test function. Also ensures each test starts with a clean, predictable state.",
             false),

            ("What makes a test brittle and how do you avoid it?",
             "A brittle test breaks when something changes that isn't related to the actual behavior being tested.\n\nCommon causes:\n• Testing against specific UI element positions or text labels\n• Depending on the current date/time (Date() in tests is non-deterministic)\n• Depending on network responses\n• Test order dependency — one test's state affects another\n• Hard-coded values that change frequently\n\nHow to avoid:\n• Inject dependencies instead of hardcoding them\n• For date-dependent tests: pass the date as a parameter instead of using Date()\n• Mock external dependencies (network, database)\n• Each test should set up its own state — never rely on another test's side effects\n• Test behavior not implementation details\n\nExample: Don't test 'the button text says Submit'. Test 'submitting the form saves the data'.",
             true),

            ("What is the difference between a mock and a stub?",
             "Both are fakes used in testing to replace real dependencies.\n\nStub — provides fake data:\n• Returns a predetermined value when called\n• Used when your function needs input to work\n• Example: a stub database that returns fake recovery scores\n• 'Stubs provide'\n\nMock — verifies behavior was called:\n• Records whether and how it was called\n• Used to verify your function DID something\n• Example: a mock ModelContext that verifies save() was called when logging a symptom\n• 'Mocks verify'\n\nIn Cicla:\n• Stub: fake HealthKit HRV value to test Cici's state calculation without real Apple Watch\n• Mock: verify that modelContext.insert() was called when user logs a symptom\n\nMemory trick: Stubs provide. Mocks verify.",
             true),

            ("What is test coverage and why isn't 100% always the goal?",
             "Test coverage = the percentage of your code that is executed by at least one test.\n\nWhy 100% isn't always the goal:\n• Coverage measures lines executed — not whether the tests are actually meaningful\n• You can have 100% coverage with tests that don't catch real bugs\n• Some code isn't worth testing: simple getters, third-party library code, generated boilerplate\n• Chasing 100% coverage can lead to writing low-quality tests just to hit the metric\n\nBetter goal: test the things that matter most — critical business logic, data transformations, edge cases where bugs are expensive.\n\nFor WHOOP specifically: you'd prioritize testing the recovery calculation logic over testing that a label displays the right font.\n\nCoverage is a signal not a guarantee.",
             false),

            ("What is a flaky test and how do you fix one?",
             "A flaky test passes sometimes and fails sometimes without any code changes. It's non-deterministic.\n\nCommon causes:\n• Timing issues — async code that doesn't wait properly\n• Test order dependency — relies on another test's state\n• Network calls — real network is unreliable\n• Using Date() — the current time changes between runs\n• Shared mutable state between tests\n\nHow to fix:\n• Make the test deterministic — inject fixed dates, mock network calls\n• Use XCTestExpectation for async code — wait properly for async operations\n• Isolate tests — each test sets up and tears down its own state\n• Add waits/timeouts appropriately\n• If a test is intermittently failing in CI, investigate immediately — don't just rerun it\n\nWhy flaky tests are dangerous: Engineers start ignoring failing tests because 'it's probably just flaky.' Then real bugs hide in the noise.",
             false),
        ]

        for (q, a, miss) in xctestCards {
            let card = Flashcard(question: q, answer: a, isInterviewMiss: miss, section: xctest)
            context.insert(card)
        }

        // --- MVVM DEEP DIVE ---
        let mvvmCards: [(String, String, Bool)] = [
            ("What is MVVM and what problem does it solve?",
             "MVVM = Model, View, ViewModel.\n\nThe problem it solves: In early iOS development, ViewControllers became massive — they handled UI, business logic, and data all in one place. Called 'Massive View Controller.' Hard to test, hard to maintain, hard to read.\n\nMVVM separates concerns:\n• Model: the data and data-related logic\n• View: the UI — only displays data, no business logic\n• ViewModel: the bridge — holds business logic, prepares data for the View\n\nWhy it matters for testing: Business logic in ViewModels can be tested independently without rendering any UI. Views are simple enough that they barely need testing.\n\nIn Cicla: 'I used MVVM because it separates concerns cleanly. The ViewModel handles all business logic which makes it independently testable — I can write XCTest unit tests for ViewModel functions without ever touching the UI. For a health app where data accuracy is critical that separation is really important.'",
             true),

            ("What is in Cicla's Model layer? Give specific examples.",
             "The Model layer contains the data structures and data-related types. No UI code, no business logic.\n\nIn Cicla:\n• SymptomLog.swift — the SwiftData model (@Model class) that stores every symptom entry a user logs\n• CycleLog.swift — the SwiftData model that stores cycle tracking data\n• SymptomType.swift — all the enums: SymptomType, BodySection, PainDescriptor, WongBakerRating, AbdominalQuadrant, PelvicSide, BristolStoolType, CyclePhase\n• CycleTracker.swift — CycleLog model with currentPhase() and daysUntilNextPeriod() computed methods\n\nKey principle: Models own the data. They don't know anything about the UI. If I wanted to use these models in a command-line tool or a different UI framework, they'd work exactly the same.",
             true),

            ("What is in Cicla's ViewModel layer? Give specific examples.",
             "The ViewModel layer holds all business logic and prepares data for the View. No UI code.\n\nIn Cicla:\n• HistoryViewModel — filtering, sorting, and searching symptom logs. formatDate(), sectionEmoji(), filteredLogs(), severityColor()\n• HealthKitViewModel — fetches HRV, resting heart rate, sleep, wrist temperature. Calculates ciciState based on health data. Contains hrv, restingHeartRate, sleepHours as @Observable properties\n• InsightsViewModel — processes symptom logs into chart data. topSymptoms(), logsPerDay(), severityOverTime(), averageSeverity()\n• HelpViewModel — manages the help screen state. expandedSection, callTarget, resources for each section\n• SettingsViewModel — handles data deletion, notifications, app version\n• EditLogViewModel — holds editable state for an existing SymptomLog entry\n\nAll ViewModels use @Observable and are instantiated in Views with @State.",
             true),

            ("What is in Cicla's View layer? Give specific examples.",
             "The View layer only displays data. It reads from ViewModels and SwiftData, but contains no business logic.\n\nIn Cicla:\n• HomeView — displays Cici, cycle phase card, action buttons. Reads from HealthKitViewModel\n• HistoryView — displays filtered, sorted list of symptom logs. Uses HistoryViewModel for filtering\n• LogSymptomView — multi-step symptom logging flow. Four steps: selectSection, selectSymptom, details, notes\n• InsightsView — charts and trend data using Swift Charts\n• HelpView — expandable sections with crisis resources\n• SettingsView — app settings with confirmation dialogs\n• CiciView — the animated dog character built entirely from SwiftUI shapes\n• OnboardingView, CycleSetupView — first-launch flows\n• LaunchScreenView, PrivacyScreenView — app lifecycle screens\n\nKey principle: Views are dumb. They display what they're told. No calculations, no data transformations.",
             false),

            ("How does a ViewModel connect to a View in Cicla?",
             "Using @State and @Observable.\n\nIn the View:\n@State private var viewModel = HistoryViewModel()\n\n@State creates and owns the ViewModel instance. @Observable makes the ViewModel automatically notify SwiftUI when its properties change.\n\nWhen a ViewModel property changes, SwiftUI automatically re-renders the View.\n\nExample flow in HistoryView:\n1. User types in search bar\n2. View updates viewModel.searchText\n3. ViewModel's filteredLogs() now returns different results\n4. View automatically re-renders with new results\n\nWhy @State instead of @StateObject: @Observable is the modern approach (iOS 17+). @StateObject was used with the old ObservableObject pattern. @Observable is cleaner — no need to mark individual properties with @Published.",
             true),

            ("Why is MVVM especially important for a health app?",
             "Three reasons specific to health applications:\n\n1. Data accuracy is critical: In a health app, a wrong number isn't just annoying — it could affect someone's decisions about their body. By keeping business logic in the ViewModel and testing it independently, you catch calculation errors before they reach users.\n\n2. Testability of health logic: The logic that determines Cici's state, calculates cycle phase, computes symptom frequency trends — this is testable in isolation when it lives in a ViewModel. You don't need to render any UI to test that low HRV + high resting heart rate = stressed state.\n\n3. Maintainability for evolving health features: Health apps grow. You add new symptom types, new HealthKit data sources, new chart types. When business logic is cleanly separated in ViewModels, you can add and change features without touching UI code.\n\n'This is a health app and should be treated seriously as such.'",
             true),

            ("What is the difference between @State, @Binding, and @StateObject?",
             "@State:\n• Source of truth owned by a View\n• When it changes, the View re-renders\n• Use for simple values local to a view\nExample: @State private var showingHistory = false\n\n@Binding:\n• A reference to someone else's @State\n• Changes in the binding change the source @State\n• Use for passing state down to child views\nExample: @Binding var hasCompletedOnboarding: Bool\n\n@StateObject (older pattern, now replaced by @State + @Observable):\n• Creates and owns an ObservableObject\n• The View owns the lifecycle of the object\n• Now replaced by @State with @Observable ViewModels\n\nIn Cicla:\n• @State private var showingLogSymptom = false — simple boolean\n• @State private var viewModel = HistoryViewModel() — ViewModel ownership\n• @Binding var hasCompletedOnboarding: Bool — in CycleSetupView, passed from parent",
             false),
        ]

        for (q, a, miss) in mvvmCards {
            let card = Flashcard(question: q, answer: a, isInterviewMiss: miss, section: mvvm)
            context.insert(card)
        }

        // --- HEALTHKIT & iOS ARCHITECTURE ---
        let healthKitCards: [(String, String, Bool)] = [
            ("What is HealthKit and how does it work?",
             "HealthKit is Apple's on-device health data store. It's a secure, encrypted database that lives on the iPhone.\n\nHow it works:\n• Apple Watch and other health apps write data TO HealthKit\n• Apps request permission to READ specific data types\n• Apple shows a standard permission sheet — you don't build this UI\n• User approves or denies each data type individually\n• Data never leaves the device unless the user explicitly shares it\n\nKey privacy aspects:\n• Every iPhone has HealthKit\n• Apple controls access — apps can only read what the user approved\n• The data is encrypted and sandboxed\n• HIPAA-relevant: HealthKit data stays with the user\n\nIn Cicla: 'HealthKit is perfect for Cicla's privacy-first philosophy. We're not building a server that receives health data — we're reading from a secure on-device store that Apple manages. The user's health data never leaves their iPhone.'",
             true),

            ("What HealthKit data types does Cicla read and why each one?",
             "HRV (heartRateVariabilitySDNN):\n• Measures variation in time between heartbeats\n• Low HRV = stressed or fatigued\n• High HRV = well-recovered\n• The same metric WHOOP uses for recovery score\n\nResting Heart Rate:\n• Elevated resting HR signals stress, illness, or overtraining\n• Combined with HRV gives a fuller picture of recovery state\n\nSleep (sleepAnalysis):\n• Total sleep time and sleep stages (core, deep, REM)\n• Poor sleep is both a trigger and symptom for PMDD, endo flares\n• Critical context for understanding why someone feels bad\n\nWrist Temperature (appleSleepingWristTemperature):\n• Apple Watch Series 8+ measures temperature deviation during sleep\n• Rises during luteal phase, drops before menstruation\n• Clinically relevant for cycle phase tracking\n\nMenstrual Flow (menstrualFlow/vaginalBleeding):\n• Read AND write — syncs with Apple Health\n• If user tracks period in another app, Cicla can read it automatically\n• If user logs in Cicla, it writes back to Apple Health\n\nCici's state is determined by HRV + resting heart rate + sleep combined.",
             true),

            ("How does the HealthKit permission flow work in Cicla?",
             "Step 1: App calls requestAuthorization(toShare:read:)\n• toShare: the types we want to WRITE (menstrual flow)\n• read: the types we want to READ (HRV, RHR, sleep, temp, menstrual flow)\n\nStep 2: Apple displays a standard permission sheet\n• Shows exactly which data types the app is requesting\n• User approves or denies each type individually\n• We don't build this UI — Apple handles it\n\nStep 3: User's choice is remembered\n• If denied, HealthKit returns nil for that data type\n• We handle nil gracefully — Cici defaults to calm state\n\nIn Cicla, this happens in HomeView:\n.task {\n    await healthKitViewModel.requestAuthorization()\n}\n\nThe .task modifier runs when the view appears. It's async so it doesn't block the UI.\n\nIMPORTANT: HealthKit is not available in the simulator for all data types. Real testing requires a physical iPhone with Apple Watch data.",
             true),

            ("How did you handle async HealthKit queries in Cicla?",
             "HealthKit uses a callback-based query API — old style. I wrapped it in async/await using withCheckedContinuation.\n\nExample from HealthKitService:\nprivate func fetchLatestQuantity(type: HKQuantityType, unit: HKUnit) async -> Double? {\n    return await withCheckedContinuation { continuation in\n        let query = HKSampleQuery(\n            sampleType: type,\n            predicate: nil,\n            limit: 1,\n            sortDescriptors: [sortDescriptor]\n        ) { _, samples, _ in\n            guard let sample = samples?.first as? HKQuantitySample else {\n                continuation.resume(returning: nil)\n                return\n            }\n            continuation.resume(returning: sample.quantity.doubleValue(for: unit))\n        }\n        healthStore.execute(query)\n    }\n}\n\nwithCheckedContinuation bridges callback-based code into async/await.\ncontination.resume() is called exactly once — either with a value or with nil.\n\nThen in fetchAll(), I use async let to run all four fetches concurrently.",
             true),

            ("What happens in Cicla if HealthKit data is nil?",
             "Graceful degradation — the app still works, just with less information.\n\nIn HealthKitViewModel, the ciciState computed property handles nil:\n\nvar ciciState: CiciState {\n    guard let hrv = hrv, let rhr = restingHeartRate else {\n        // No HRV or RHR data\n        if let sleep = sleepHours, sleep < 5 {\n            return .tired // only sleep data available\n        }\n        return .calm // default state\n    }\n    // calculate state from full data\n}\n\nSo if the user:\n• Hasn't granted HealthKit permission → Cici shows calm (default)\n• Denied HRV permission but has sleep data → Cici can still show tired if sleep < 5 hours\n• Has all data → full calculation\n\nCici always has a valid state. The app never crashes or shows an error state for missing health data.",
             false),

            ("What is SwiftData and how is it different from CoreData?",
             "SwiftData is Apple's modern on-device persistence framework introduced in iOS 17. It replaces CoreData.\n\nCoreData (old way):\n• NSManagedObject subclasses\n• XML or binary store format\n• Lots of boilerplate\n• Objective-C roots\n\nSwiftData (new way):\n• @Model macro on a Swift class\n• Automatic schema generation\n• @Query in SwiftUI views\n• Fully Swift-native\n• Much less boilerplate\n\nExample:\n// CoreData — lots of code\nclass SymptomLog: NSManagedObject {\n    @NSManaged var symptomType: String\n    // ... lots of setup code\n}\n\n// SwiftData — much cleaner\n@Model\nclass SymptomLog {\n    var symptomType: String\n    var severity: Int\n    // just declare properties\n}\n\nIn Cicla: I chose SwiftData because it's the Apple-recommended modern approach for iOS 17+, it integrates natively with SwiftUI, and it required significantly less boilerplate to implement.",
             true),

            ("What is the difference between SwiftData and UserDefaults?",
             "UserDefaults:\n• Key-value storage for SIMPLE types\n• Strings, Int, Bool, Double, Array of simple types\n• Persists across app launches\n• No relationships, no querying, no sorting\n• Use for: settings, preferences, flags\n\nSwiftData:\n• Structured storage for COMPLEX custom types\n• Full Swift classes with multiple properties\n• Relationships between models\n• Querying, filtering, sorting via @Query\n• Use for: app data, user-generated content\n\nIn Cicla:\n• UserDefaults: isDarkMode (Bool), hasCompletedOnboarding (Bool) via @AppStorage\n• SwiftData: SymptomLog (complex — has symptomType, severity, painDescriptors, date, location, notes, HealthKit snapshot), CycleLog (complex — has dates, lengths, birth control flag)\n\nRule of thumb: if it's a simple flag or preference → UserDefaults. If it's structured data with multiple fields → SwiftData.",
             true),

            ("What is @AppStorage and when did you use it in Cicla?",
             "@AppStorage is a SwiftUI property wrapper that reads and writes to UserDefaults automatically. When the value changes, SwiftUI re-renders the view.\n\nSyntax:\n@AppStorage('isDarkMode') private var isDarkMode = false\n@AppStorage('hasCompletedOnboarding') private var hasCompletedOnboarding = false\n\nIn Cicla:\n• hasCompletedOnboarding — used in CiclaApp to decide whether to show OnboardingView or ContentView. Set to true after user completes cycle setup.\n• isDarkMode — used in SettingsView for the dark mode toggle\n\nWhy @AppStorage over UserDefaults.standard.set():\n• Reactive — SwiftUI automatically re-renders when the value changes\n• Cleaner syntax — no need to manually read/write with string keys\n• Type-safe\n\nWhen the user completes onboarding:\nhasCompletedOnboarding = true\n— This single line updates UserDefaults AND triggers CiclaApp to switch from OnboardingView to ContentView.",
             false),
        ]

        for (q, a, miss) in healthKitCards {
            let card = Flashcard(question: q, answer: a, isInterviewMiss: miss, section: healthKit)
            context.insert(card)
        }

        // --- SYSTEM DESIGN & DATABASES ---
        let systemDesignCards: [(String, String, Bool)] = [
            ("What is a relational database and why use one?",
             "A relational database organizes data into tables with rows and columns. Tables are related to each other through foreign keys.\n\nWhy use one:\n• Structured data with relationships — user has many recovery scores\n• ACID compliance — Atomicity, Consistency, Isolation, Durability\n• Powerful querying with SQL — filter, sort, join, aggregate\n• Proven, well-understood technology\n\nIn your take home: users table relates to recovery_scores through user_id foreign key. One user, many scores.\n\nExamples: PostgreSQL, MySQL, SQLite (what SwiftData uses under the hood).\n\nWhen NOT to use: unstructured data, need for massive horizontal scaling, flexible schema requirements → consider NoSQL.",
             false),

            ("What is normalization and why does it matter?",
             "Normalization is organizing database tables to reduce repetition and improve data integrity.\n\nThe core principle: each piece of information should be stored in exactly ONE place.\n\nWithout normalization (denormalized):\nuser_id | user_email | recovery_date | score | category | min_score | max_score\n1 | lily@x.com | 2024-08-08 | 72 | yellow | 34 | 66\n1 | lily@x.com | 2024-08-09 | 45 | yellow | 34 | 66\n\nProblems: email repeated on every row, category thresholds repeated everywhere, update anomaly (if email changes, must update many rows).\n\nNormalized (your take home design):\n• users table: lily@x.com stored once\n• recovery_scores table: references user_id, stores score\n• recovery_categories table: thresholds defined once\n\nBenefits: less storage, easier maintenance, no update anomalies, data integrity.",
             true),

            ("What is a primary key and what is a foreign key?",
             "Primary key:\n• Uniquely identifies each row in a table\n• Every table should have one\n• Cannot be null, cannot be duplicated\n• Usually an auto-incrementing ID column\nExample: users.id = 1, 2, 3...\n\nForeign key:\n• A column in one table that references the primary key of another table\n• Enforces referential integrity — you can't have a recovery score for a user that doesn't exist\n• Creates the relationship between tables\nExample: recovery_scores.user_id references users.id\n\nIn your take home:\nPrimary keys: users.id, recovery_scores.id, recovery_categories.id\nForeign key: recovery_scores.user_id → users.id\n\n'It's all about having everything be locatable and identifiable. The foreign key is the thread that connects the score back to the person it belongs to.'",
             true),

            ("What is a one-to-many relationship?",
             "One row in Table A can relate to MANY rows in Table B. But each row in Table B relates to only ONE row in Table A.\n\nIn your take home:\nOne user → many recovery scores\nBut each recovery score → one user\n\nImplemented through the foreign key:\nrecovery_scores.user_id stores the id of the user that score belongs to.\n\nReal world analogy: one mother can have many children, but each child has one mother.\n\nOther common examples:\n• One customer → many orders\n• One author → many books\n• One WHOOP member → many daily recovery records\n\nThe 'many' side holds the foreign key.",
             false),

            ("What is a derived value and when do you use one?",
             "A derived value is calculated from existing data rather than stored separately.\n\nExample: Recovery category (green/yellow/red).\nYou store the score (72%). You don't store 'yellow.'\nYellow is derived: if score >= 34 && score <= 66 → yellow.\n\nWhen to use derived values:\n• When the value can always be calculated from stored data\n• When storing it would create maintenance problems\n• When thresholds or rules might change\n\nAdvantages:\n• No update anomalies — if thresholds change, just update the calculation\n• No redundant data\n• Always accurate — calculated fresh from source data\n\nDisadvantages:\n• Small computation cost at query time\n• Complex derivations can slow down queries (mitigated with indexes)\n\nIn your take home: 'I chose not to store the category because it's always derivable from the score. If WHOOP ever adjusts the thresholds, historical data stays accurate without needing mass updates.'",
             true),

            ("What is an API and what is the difference between a request and a response?",
             "API = Application Programming Interface. A way for two pieces of software to communicate.\n\nRestaurant analogy:\n• You = frontend (the app)\n• Kitchen = backend (the server)\n• Waiter = the API\n\nRequest: what the frontend sends TO the backend\n• Method: GET (retrieve), POST (create), PUT/PATCH (update), DELETE (remove)\n• Parameters: data needed to process the request\n• In your take home: userId, aggregation, startDate, timezone\n\nResponse: what the backend sends BACK\n• Status code: 200 (success), 400 (bad request), 404 (not found), 500 (server error)\n• Body: the data requested\n• In your take home: averageRecovery, dataPoints, breakdown, percentChange\n\nKey principle: the frontend should receive everything it needs to render the screen in ONE response. Multiple requests = slower app = worse user experience.",
             true),

            ("Why did you include timezone in the API request?",
             "Because recovery scores need to be grouped by the correct LOCAL date for each user.\n\nThe problem without timezone:\nA user logs recovery data at 11:30pm in Texas (CST).\nOn WHOOP's server (which might be in a different timezone), that timestamp might already be the next day.\nWithout knowing the user's timezone, the server assigns that score to the wrong day.\nNow the weekly chart shows data on incorrect dates.\n\nWith timezone:\nThe server knows the user is in America/Chicago (CST).\nIt correctly groups the 11:30pm entry as belonging to Tuesday in Texas.\nThe chart shows accurate data for the user's actual experience.\n\nThis is especially important for WHOOP because:\n• Members travel across timezones\n• Recovery patterns are analyzed day by day\n• One wrong day ruins the accuracy of the entire period's analysis",
             true),

            ("How would you design a test suite for a new WHOOP feature?",
             "Framework for approaching any test suite design question:\n\nStep 1: Clarify requirements\n• What does this feature do? What are the inputs and outputs?\n• What are the most critical user journeys?\n• What would be catastrophic if it broke?\n\nStep 2: Unit tests first (the base of the pyramid)\n• Test the core calculation logic in isolation\n• Test all edge cases: empty data, invalid input, boundary conditions\n• For recovery feature: test average calculation, category bucketing, date filtering\n\nStep 3: Integration tests\n• Test that data flows correctly between layers\n• Test that the API returns correctly formatted responses\n• Test database queries return expected results\n\nStep 4: End-to-end tests (few, high value)\n• Test the complete critical user journey\n• 'User selects weekly view and sees correct average and breakdown'\n• Test that UI matches API response\n\nStep 5: Edge cases and error states\n• Missing data, network failures, permission denied\n• The app should never crash — always degrade gracefully\n\nFor WHOOP specifically: data accuracy is the most critical thing. A wrong recovery score could affect someone's training decisions. Test the calculation logic exhaustively.",
             true),

            ("What is the testing pyramid and why does the shape matter?",
             "The testing pyramid shows the ideal distribution of test types:\n\n        /\\\n       /E2E\\ ← few\n      /------\\\n     /Integ   \\ ← some\n    /----------\\\n   /   Unit     \\ ← many\n  /--------------\\\n\nUnit tests (bottom, most):\n• Test one piece of code in isolation\n• Fast to run, fast to write, easy to maintain\n• Should make up the majority of your test suite\n\nIntegration tests (middle, some):\n• Test two or more pieces working together\n• Slower, more complex\n\nE2E tests (top, few):\n• Test the full app from user perspective\n• Slowest, most expensive, most brittle\n\nWhy the shape matters:\nHeavy E2E suite = slow CI, expensive, brittle tests that break on UI changes.\nHeavy unit suite = fast, cheap, reliable, catches logic errors early.\n\nA well-shaped pyramid means: fast feedback, cheap to run, catches bugs at the right level.",
             true),
        ]

        for (q, a, miss) in systemDesignCards {
            let card = Flashcard(question: q, answer: a, isInterviewMiss: miss, section: systemDesign)
            context.insert(card)
        }

        // --- MOCK INTERVIEW QUESTIONS ---
        let mockCards: [(String, String, Bool)] = [
            ("Brian asks: Walk me through your take home submission.",
             "Strong answer structure:\n\n1. Set context first — describe the screen, not the code\n'The take home showed the WHOOP recovery trend screen — it displays a member's average recovery score across a weekly, monthly, or 6-month window with a green/yellow/red breakdown of days.'\n\n2. Walk through what you built\n'I wrote two Swift functions and enumerated five tests with reasoning for each one. I also designed the database schema, relationships, and API structure.'\n\n3. Explain the functions at a high level\n'Function 1 calculates the current period average. It takes the aggregation type, start date, and full dataset, filters to the relevant window, and returns the average or nil if no data exists. Function 2 uses Function 1 internally — DRY principle — and returns the percentage change versus the previous equivalent period.'\n\n4. Explain your testing philosophy\n'Every test I picked connects back to user trust in the data. WHOOP's value depends on members believing what they see.'\n\nDon't read code line by line. Tell the story of what you built and why.",
             true),

            ("Brian asks: Why did you choose Swift for the take home?",
             "'Swift is where I'm strongest right now. I've spent the past year teaching myself iOS development and building Cicla — a full SwiftUI app with HealthKit integration and SwiftData persistence.\n\nI also felt Swift was appropriate because WHOOP builds native iOS apps, and demonstrating comfort with the platform they ship on seemed more relevant than choosing a language purely for familiarity.\n\nI'm aware the SDET role involves Android testing as well — that's new territory for me and I'm genuinely excited to learn it. Given how quickly I picked up Swift while working full time as a nurse and finishing my CS degree, I'm confident I can ramp up on the Android side.'",
             true),

            ("Brian asks: How did you approach testing in the take home — did you write actual test code?",
             "Be honest here. You described tests conceptually but didn't write XCTest code in the submission.\n\n'In the take home I enumerated and explained the five most important tests with reasoning for each — why I picked them and what they protect against. I didn't write the actual XCTest code in the submission itself.\n\nHowever since then I've been actively learning XCTest — I've written actual unit tests for my take home functions using the Arrange-Act-Assert pattern. For example, testing that the weekly average returns the correct value for in-window data, that empty datasets return nil, and that data outside the time window is excluded from the calculation.\n\nI understand the framework well enough to write and run tests in Xcode. I also understand the broader concepts — mocks, stubs, test coverage, the testing pyramid — and how they apply to a production quality engineering role.'",
             true),

            ("Brian asks: Tell me about Cicla's architecture.",
             "'Cicla is a women's health symptom tracker built in SwiftUI with a privacy-first philosophy — everything stored locally, nothing leaves the device.\n\nArchitecturally I used MVVM throughout. The Model layer has my SwiftData models — SymptomLog and CycleLog — and my Swift enums for symptom types, body sections, pain descriptors, and cycle phases. The ViewModel layer handles all business logic — HistoryViewModel for filtering and sorting logs, HealthKitViewModel for fetching biometric data and calculating Cici's state, InsightsViewModel for chart data. The View layer is purely display — no business logic.\n\nFor persistence: SwiftData for complex structured data like symptom logs, UserDefaults for simple flags like onboarding completion.\n\nFor health data: HealthKit reads HRV, resting heart rate, sleep, wrist temperature, and cycle data. I wrapped HealthKit's callback-based queries in async/await using withCheckedContinuation, and use async let to fetch all data sources concurrently.\n\nI structured it this way because this is a health app and should be treated seriously. Keeping business logic in testable ViewModels means data accuracy can be verified independently of the UI.'",
             true),

            ("Brian asks: What would you do differently if you redid the take home?",
             "This tests self-awareness and engineering judgment. Have a real answer ready.\n\n'A few things:\n\nFirst, I'd use an enum for aggregation instead of a String. Right now the functions accept any String and handle invalid input with a default nil return. An enum would make invalid aggregation impossible at compile time — the compiler would catch the mistake before runtime.\n\nSecond, I'd make the date handling more explicitly timezone-aware. I used Calendar.current which respects the device timezone, but in a production system where the function might run on a server, I'd explicitly pass and use a specific timezone to avoid edge cases.\n\nThird, I'd write the actual XCTest code as part of the submission rather than just describing the tests. Writing runnable tests demonstrates the thinking more concretely than prose description.\n\nFourth, for Function 2 I might add a previousEndDate parameter to be more explicit about the previous period boundaries instead of deriving it solely from startDate.'",
             true),

            ("Brian asks: How do you think about test coverage for a health wearable?",
             "'For a health wearable I think about coverage differently than for a standard app — because the stakes are higher.\n\nA wrong number in a social media app is annoying. A wrong recovery score could cause someone to overtrain when they should rest, or rest when they could push. That has real consequences for real people.\n\nSo I'd prioritize test coverage on:\n1. Data calculation logic — any function that transforms raw sensor data into a number a member sees. This needs exhaustive unit testing including edge cases.\n2. Data integrity across layers — does the number that comes from the backend match what shows on screen? Your test 5 from my take home.\n3. Error and missing data handling — WHOOP members travel, they forget to charge, they switch devices. The app must never crash or show misleading data when input is incomplete.\n4. Aggregation boundaries — date math bugs at month boundaries or timezone transitions are silent and insidious.\n\nI'd be less concerned about pixel-perfect UI tests — those are brittle and the stakes of a layout being slightly off are much lower than a data accuracy issue.'",
             true),

            ("Brian asks: What is your experience with Android and mobile testing frameworks?",
             "Be honest — you don't have Android experience yet.\n\n'I haven't worked with Android development or Android testing frameworks directly. My mobile experience is entirely in iOS — Swift, SwiftUI, XCTest, HealthKit.\n\nThat said, I understand the concepts transfer. The testing pyramid, unit vs integration vs E2E testing, mocks and stubs, test coverage — these are platform-agnostic principles. The syntax and tooling are different but the thinking is the same.\n\nFor Android specifically, I know Espresso is the primary UI testing framework and JUnit is the standard unit testing framework — the Android equivalent of XCTest. I haven't used them but I understand what they do.\n\nI'm genuinely excited to learn Android testing as part of this role. I've proven I can pick up new platforms quickly — I went from zero iOS knowledge to a HealthKit-integrated app in under a year while working full time and finishing my degree.'",
             true),

            ("Brian asks: How do you handle a bug you can't reproduce?",
             "'A bug I can't reproduce is actually one of the most interesting debugging challenges.\n\nMy approach:\n\n1. Gather all available information — what was the user doing? What device? What OS version? What network conditions? What was the app state? The more context, the better chance of finding the trigger.\n\n2. Look at logs and crash reports — in production, tools like Firebase Crashlytics capture stack traces and device state at the time of the crash. That's often where the answer is.\n\n3. Look for patterns — does it happen on specific devices? Specific OS versions? Specific times of day? Specific user actions in sequence?\n\n4. Write a test that TRIES to reproduce it — even if I can't reproduce it manually, I can write a test that exercises the suspected code path with edge case data.\n\n5. Add more logging around the suspected area — if I can't catch it now, instrument the code so if it happens again I'll have better data.\n\n6. Be honest with the team — if I'm stuck, I communicate what I've tried and what I think might be happening. I don't sit on it silently.'",
             false),

            ("Brian asks: Do you have any questions for me?",
             "Have these ready — pick 2-3 that feel most natural:\n\n1. 'You're relatively new to this role — what's your vision for the Healthcare QA team and what does success look like for you in building it out?'\n\n2. 'With WHOOP's recent funding, are there new healthcare features on the roadmap that this team will be focused on testing?'\n\n3. 'What does the collaboration look like between QA engineers and the iOS engineering team day to day?'\n\n4. 'What does the onboarding process look like for someone joining this team — how quickly would I be expected to be contributing to real test coverage?'\n\n5. 'What are the biggest quality challenges the team is currently working through?'\n\n6. 'Do you wear a WHOOP yourself? Has it changed anything for you personally?'\n\nAvoid: salary questions (already covered with Mikey), anything Google could answer, questions that suggest you didn't research WHOOP.",
             true),

            ("Brian asks: Why are you interested in quality engineering specifically, not just iOS development?",
             "'I'm interested in quality engineering because I think it's where my background gives me the most leverage.\n\nAs a nurse, I spent years in environments where data accuracy wasn't optional — it was the difference between the right treatment and the wrong one. That shaped how I think about software. I don't just want to build features — I want to make sure those features work correctly and reliably for real people.\n\nQuality engineering lets me be the person who asks 'but what happens when the data is missing?' or 'what if the user's timezone changes mid-period?' Those are the questions that matter for a health product.\n\nI'm also genuinely excited about the mobile automation aspect of this role specifically. Testing features on iOS — the platform I've been building on — means I understand both the code being tested and the test infrastructure. That combination feels like exactly where I can add the most value right now.\n\nAnd to be transparent — I'm also excited about iOS engineering more broadly. I mentioned to Mikey that I've applied for the iOS Engineer role as well. I see quality and iOS development as complementary — understanding how tests work makes you a better developer, and understanding how the app is built makes you a better tester.'",
             true),
        ]

        for (q, a, miss) in mockCards {
            let card = Flashcard(question: q, answer: a, isInterviewMiss: miss, section: mockInterview)
            context.insert(card)
        }
    }
}
