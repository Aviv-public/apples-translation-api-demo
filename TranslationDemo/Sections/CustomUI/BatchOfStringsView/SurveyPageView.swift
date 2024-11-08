import SwiftUI
import Translation

struct SurveyPageView: View {
    // Sample statements about the property detail page in Dutch
    @State var statements = [
        "De details van het eigendom waren duidelijk.",
        "De foto’s van het eigendom waren van goede kwaliteit.",
        "De beschrijving van het eigendom was nauwkeurig.",
        "De locatie-informatie was nuttig.",
        "De prijsinformatie was begrijpelijk en duidelijk.",
        "De specificaties van het eigendom waren volledig.",
        "Het contact met de verkoper was gemakkelijk te vinden.",
        "De lay-out van de detailpagina was aantrekkelijk.",
        "De informatie over de buurt was voldoende.",
        "De detailpagina laadde snel."
    ]

    // State to track responses for each statement (1 to 5 rating)
    @State private var responses: [Int] = Array(repeating: 0, count: 10)
    @State private var isSubmitted: Bool = false
    @State private var isTranslated: Bool = false

    @State private var configuration: TranslationSession.Configuration?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Property Detail Page Survey")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            // Info view saying that the questions are coming from the local real estate agency and maybe in different language.
            if !isTranslated {
                HStack {
                    Button {
                        // Show translate overlay
                        triggerTranslation()
                    } label: {
                        Image(systemName: "translate")
                    }

                    Text("These survey statements are provided by the local real estate agency and may be in a different language. You can translate using the button left.")
                        .lineLimit(nil)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }

            List {
                ForEach(0..<statements.count, id: \.self) { index in
                    VStack(alignment: .leading) {
                        Text(statements[index])
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.bottom, 4)

                        // Rating Scale (1 to 5)
                        HStack {
                            ForEach(1...5, id: \.self) { rating in
                                Button(action: {
                                    responses[index] = rating
                                }) {
                                    Text(ratingLabel(for: rating))
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(responses[index] == rating ? Color.blue : Color.gray.opacity(0.2))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .translationTask(configuration) { session in
                await translateAllAtOnce(using: session)
            }

            // Submit Button
            Button(action: submitSurvey) {
                Text("Submit Survey")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8)
            }
            .padding()
            .alert(isPresented: $isSubmitted) {
                Alert(title: Text("Survey Submitted"), message: Text("Thank you for your feedback!"), dismissButton: .default(Text("OK")))
            }
        }
    }

    // Helper function to provide labels for rating scale
    private func ratingLabel(for rating: Int) -> String {
        switch rating {
        case 1: return "😡"
        case 2: return "😞"
        case 3: return "😑"
        case 4: return "🙂"
        case 5: return "😃"
        default: return ""
        }
    }

    private func submitSurvey() {
        // Additional submit logic can be added here if needed
        isSubmitted = true
    }

    private func triggerTranslation() {
        guard configuration == nil else {
            configuration?.invalidate()
            return
        }

        configuration = .init()
    }

    private func translateAllAtOnce(using session: TranslationSession) async {
        // Translate all statements at once
        Task { @MainActor in
            let requests: [TranslationSession.Request] = statements.map {
                // Map each item into a request.
                TranslationSession.Request(sourceText: $0)
            }

            do {
                let responses = try await session.translations(from: requests)
                withAnimation {
                    statements = responses.map {
                        // Update each item with the translated result.
                        $0.targetText
                    }

                    isTranslated = true
                }

            } catch {
                // Handle any errors.
            }
        }
    }
}

#Preview {
    SurveyPageView()
}
