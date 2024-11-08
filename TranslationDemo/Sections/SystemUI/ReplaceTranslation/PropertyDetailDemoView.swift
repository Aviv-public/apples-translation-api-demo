import SwiftUI

/// A view that displays a property's details and allows the user to replace the translation of the property's description.
/// The user can also revert the translation to the original description.
struct PropertyDetailDemoView: View {
    @Environment(PropertyDetailDemoViewModel.self) var viewModel

    @State private var isDescriptionExpanded = false
    @State private var isTranslationOverlayPresented = false
    @State private var shouldShowRevertButton = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: viewModel.property.imageUrl) { image
                    in
                    image
                        .resizable()
                } placeholder: {
                    Color.red
                }
                .cornerRadius(12)
                .frame(height: 300)

                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.property.title)
                        .font(.title)
                        .fontWeight(.bold)

                    Text("\(viewModel.property.location), \(viewModel.property.state)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("€ \(viewModel.property.price, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)

                    HStack(spacing: 20) {
                        PropertyFeature(iconName: "bed.double", value: "\(viewModel.property.bedrooms) Beds")
                        PropertyFeature(iconName: "bathtub", value: "\(viewModel.property.bathrooms) Baths")
                        PropertyFeature(iconName: "square.3.stack.3d.down.right", value: "\(viewModel.property.squareFootage) sqft")
                    }
                    .padding(.top)
                }

                VStack(alignment: .leading) {
                    Text(viewModel.propertyDescription)
                        .font(.body)
                        .lineLimit(isDescriptionExpanded ? nil : 3)
                        .translationPresentation(
                            isPresented: $isTranslationOverlayPresented,
                            text: viewModel.property.description
                        ) { translatedText in
                            shouldShowRevertButton = true
                            viewModel.propertyDescription = translatedText
                        }

                    HStack {
                        Button(
                            action: {
                                withAnimation {
                                    isDescriptionExpanded.toggle()
                                }
                            }
                        ) {
                            Text(isDescriptionExpanded ? "Read less" : "Read more")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }

                        Spacer()

                        if shouldShowRevertButton {
                            Button {
                                withAnimation {
                                    shouldShowRevertButton = false
                                    viewModel.revertTranslation()
                                }
                            } label: {
                                Image(systemName: "arrow.uturn.backward")
                            }
                        }

                        Button {
                            isTranslationOverlayPresented = true
                        } label: {
                            Image(systemName: "translate")
                        }
                    }
                    .padding(.bottom, 64)

                    Button(action: {
                        print("Contact Seller tapped")
                    }) {
                        Text("Contact Seller")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    PropertyDetailDemoView()
        .environment(PropertyDetailDemoViewModel(property: .mock))
}
