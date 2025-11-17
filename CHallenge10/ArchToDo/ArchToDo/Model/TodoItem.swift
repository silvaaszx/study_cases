import Foundation

// Este é o nosso "M" (Model)
// É uma struct, um tipo por valor, como aprendemos no POP
struct TodoItem {
    let id: UUID
    var title: String
    var isCompleted: Bool
    
    // Construtor para facilitar
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
    }
}
