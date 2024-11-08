import SwiftUI
import Translation

struct ContactSellerView: View {
    @State private var name: String = "Luke McCarthy"
    @State private var email: String = "luke.mccarthy@example.com"
    @State private var phone: String = "+1 (555) 123-4567"
    @State private var message: String =
    """
    Hello, 
    I'm interested in your property. I like what you did with the interior design. I love the neighborhood and the location. But I'm looking for an at least 10% discount on the deal. Is it acceptable to you? Please let me know. 
    Thanks!
    """
    @State private var infoMessage: String = "The seller of this property is from Italy. Would you like to translate your message to Italian?"

    @State private var isMessageSent: Bool = false
    @State private var isTranslationSheetPresent: Bool = false
    @State private var isLoadingTranslation: Bool = false
    @State private var isTranslationBeingUsed: Bool = false

    @State private var configuration: TranslationSession.Configuration?
    @State private var translatedMessage: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Contact the Seller")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)

                // Name Field
                TextField("Your Name", text: $name)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                // Email Field
                TextField("Your Email", text: $email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                // Phone Field
                TextField("Your Phone Number", text: $phone)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                // Message Field
                TextEditor(text: $message)
                    .frame(height: 200)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                    .onChange(of: message) { _, newValue in
                        if newValue.isEmpty {
                            isTranslationBeingUsed = false
                        }
                    }

                if !isTranslationBeingUsed {
                    VStack(alignment: .leading, spacing: 16) {
                        // Information Label
                        Label {
                            Text(infoMessage)
                                .lineLimit(nil)
                                .font(.subheadline)
                                .foregroundColor(.red)
                                .padding(.top, 4)
                        } icon: {
                            Image(systemName: "info.circle")
                        }

                        Button {
                            triggerTranslation()
                        } label: {
                            HStack {
                                Text("See how it looks in 🇮🇹")
                            }
                        }
                        .translationTask(configuration) { session in
                            do {
                                // Use the session the task provides to translate the text.
                                let response = try await session.translate(message)
                                // Update the view with the translated result.
                                translatedMessage = response.targetText
                                isTranslationSheetPresent = true
                            } catch {
                                // Handle any errors.
                            }
                        }
                        .sheet(isPresented: $isTranslationSheetPresent) {
                            VStack {
                                // Message Field
                                TextEditor(text: $translatedMessage)
                                    .frame(height: 300)
                                    .padding()
                                    .background(Color(.secondarySystemBackground))
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    )

                                Spacer()

                                // Translate button
                                Button {
                                    withAnimation {
                                        isTranslationBeingUsed = true
                                        isTranslationSheetPresent = false
                                        message = translatedMessage
                                    }
                                } label: {
                                    Text("Use the translation")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                            }
                            .padding()
                            .presentationDragIndicator(.visible)
                            .presentationDetents([.medium])
                        }
                    }
                }

                // Send Button
                Button(action: {
                    sendMessage()
                }) {
                    Text("Send Message")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .alert(isPresented: $isMessageSent) {
                    Alert(
                        title: Text("Message Sent"),
                        message: Text("Your message has been sent to the seller."),
                        dismissButton: .default(Text("OK"))
                    )
                }

                Spacer()
            }
            .padding()
            .scrollDismissesKeyboard(.immediately)
        }
    }

    // Function to handle message sending
    private func sendMessage() {
        // Perform validation or any backend action here
        // For now, we'll just simulate a successful send
        if !name.isEmpty && !email.isEmpty && !message.isEmpty {
            isMessageSent = true
        }
    }

    private func triggerTranslation() {
        guard configuration == nil else {
            configuration?.invalidate()
            return
        }

        // Create a new configuration for the translation session.
        // This configuration will target Italian as the translation language.
        configuration = .init(target: .init(identifier: "it"))
    }
}

#Preview {
    ContactSellerView()
}
