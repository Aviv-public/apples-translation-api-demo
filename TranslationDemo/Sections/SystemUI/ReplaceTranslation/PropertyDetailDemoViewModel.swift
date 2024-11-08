import Foundation

@Observable
class PropertyDetailDemoViewModel {
    let property: Property
    var propertyDescription: String

    init(property: Property) {
        self.property = property
        self.propertyDescription = property.description
    }

    func revertTranslation() {
        propertyDescription = property.description
    }
}
