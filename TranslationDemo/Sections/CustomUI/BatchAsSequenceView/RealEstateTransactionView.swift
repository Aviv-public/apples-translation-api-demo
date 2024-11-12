import SwiftUI
import Translation

struct RealEstateAgentProfileView: View {
    // Agent's profile information
    let agentName: String = "Jean Dupont"
    let agentBio: String = "Expert en immobilier avec plus de 10 ans d'expérience dans le marché belge. Je suis passionné par aider mes clients à trouver la maison de leurs rêves."

    // Customer reviews with dates and reviewer names
    @State var reviews: [Review] = .reviews

    @State private var isTranslated = false
    @State private var configuration: TranslationSession.Configuration?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Agent Profile Information
                Text(agentName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                Text(agentBio)
                    .font(.body)

                VStack(alignment: .leading, spacing: 8) {
                    // Reviews Section
                    Text("Customer Reviews")
                        .font(.headline)
                        .padding(.top)

                    // Info view saying that the questions are coming from the local real estate agency and maybe in different language.
                    HStack {
                        Button {
                            // Show translate overlay
                            triggerTranslation()
                        } label: {
                            Image(systemName: "translate")
                        }

                        Text("Translate all reviews to your preferred language.")
                            .lineLimit(nil)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.bottom)

                ForEach(reviews) { review in
                    LazyVStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text(review.text)
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Reviewed by \(review.reviewerName) on \(review.date)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                    }
                    .padding(.vertical, 4)
                }
                .translationTask(configuration) { session in
                    await translateSequence(session)
                }
            }
            .padding()
        }
    }

    private func triggerTranslation() {
        guard configuration == nil else {
            configuration?.invalidate()
            return
        }

        configuration = .init()
    }

    private func translateSequence(_ session: TranslationSession) async {
        Task { @MainActor in
            // Create an array of requests. Use the index as the client identifier.
            let requests: [TranslationSession.Request] =  reviews.enumerated().map { (index, review) in
                .init(sourceText: review.text, clientIdentifier: "\(index)")
            }

            do {
                // Translate the batch of requests.
                // For each response received, update the corresponding review in the array.
                for try await response in session.translate(batch: requests) {
                    guard let index = Int(response.clientIdentifier ?? "") else { continue }
                    withAnimation {
                        // The client identifier is used to match the response to the original reviews
                        reviews[index].text = response.targetText
                    }
                }
            } catch {
                // Handle error
            }
        }
    }
}

struct RealEstateAgentProfileView_Previews: PreviewProvider {
    static var previews: some View {
        RealEstateAgentProfileView()
    }
}
