import Foundation

// O "M" (Model)
struct TodoItem {
    let id: UUID
    var title: String
    var isCompleted: Bool
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
    }
}
