import Foundation
import Combine // Importa o Combine (padrão Observer)

// O "VM" (ViewModel)
class TodoViewModel: ObservableObject {
    
    // O ViewModel é o "dono" do estado.
    // @Published avisa a View sempre que 'items' mudar.
    @Published var items: [TodoItem] = []
    
    // Título que a View vai ler
    let screenTitle = "Minhas Tarefas (MVVM)"
    
    // Lógica de negócios
    func loadInitialData() {
        items = [
            TodoItem(title: "Estudar MVVM"),
            TodoItem(title: "Refatorar o App"),
            TodoItem(title: "Fazer funcionar!")
        ]
    }
    
    func addNewItem(title: String) {
        guard !title.isEmpty else { return }
        let newItem = TodoItem(title: title)
        items.append(newItem)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        items[indexPath.row].isCompleted.toggle()
    }
    
    func deleteItem(at indexPath: IndexPath) {
        items.remove(at: indexPath.row)
    }
}
