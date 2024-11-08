import SwiftUI
import Translation

struct PrepareTranslationView: View {
    @State private var configuration = TranslationSession.Configuration(
        source: Locale.Language(identifier: "pt_BR"),
        target: Locale.Language(identifier: "ko_KR")
    )

    @State private var buttonTapped = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Prepare for In-App Translations")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text("Powered by Apple.")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            Text("Tap the button below to download the required language packs for use. This will enable faster and more reliable translations, even without an internet connection.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            Button(action: {
                configuration.invalidate()
                buttonTapped = true
            }) {
                Text("Download language packs")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
            }

            Spacer()
        }
        .padding()
        .translationTask(configuration) { session in
            if buttonTapped {
                do {
                    try await session.prepareTranslation()
                } catch {
                    // Handle any errors.
                }
            }
        }
        .padding()
    }
}

#Preview {
    PrepareTranslationView()
}
