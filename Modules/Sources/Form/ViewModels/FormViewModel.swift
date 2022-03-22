import Foundation

public final class FormViewModel {
    
    @Published private(set) var sections: [FormSection]
    
    public init(sections: [FormSection]) {
        self.sections = sections
    }
    
    // MARK: - Public methods
    
    public func setSections(_ sections: [FormSection]) {
        self.sections = sections
    }
    
    public func insertSection(_ section: FormSection, at index: Int) {
        sections.insert(section, at: index)
    }
    
}
