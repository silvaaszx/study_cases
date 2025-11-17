import UIKit
import Combine // Importa o Combine para "ouvir" o ViewModel

// O "V" (View)
// Note que esta classe não tem mais um array 'items' e não toma decisões.
class ViewController: UITableViewController {

    // 1. A View "tem" um ViewModel
    private var viewModel: TodoViewModel!
    
    // 2. Um Set para guardar as "inscrições" do Combine
    private var cancellables = Set<AnyCancellable>()
    
    private let cellIdentifier = "TodoCell"

    // 3. Criamos um 'init' para injetar o ViewModel
    // (Isso é Injeção de Dependência, que aprendemos)
    init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    // (Este 'init' é obrigatório quando criamos o acima)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
        // A View "chuta" a lógica inicial
        viewModel.loadInitialData()
    }
    
    // Configura a UI
    private func setupUI() {
        self.title = viewModel.screenTitle // Lê o título do ViewModel
        self.view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    // 4. A MÁGICA DO MVVM: Conectar (bind) a View ao ViewModel
    private func setupBindings() {
        // "Ouvimos" o publisher @Published var items do ViewModel
        viewModel.$items
            .receive(on: DispatchQueue.main) // Garante que a UI atualize na thread principal
            .sink { [weak self] _ in
                // O ViewModel mudou. A View só obedece e recarrega.
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    // MARK: - Ações (A View delega para o ViewModel)

    @objc private func addButtonTapped() {
        let alert = UIAlertController(title: "Nova Tarefa", message: "Digite o título da tarefa", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Ex: Estudar VIPER" }
        
        let addAction = UIAlertAction(title: "Adicionar", style: .default) { [weak self] _ in
            guard let title = alert.textFields?.first?.text else { return }
            
            // A View AVISA o ViewModel
            self?.viewModel.addNewItem(title: title)
        }
        
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    // MARK: - UITableView DataSource (A View lê dados do ViewModel)

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count // Pergunta ao ViewModel
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let item = viewModel.items[indexPath.row] // Pega o item do ViewModel
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isCompleted ? .checkmark : .none
        return cell
    }

    // MARK: - UITableView Delegate (A View avisa o ViewModel)

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath) // AVISA o ViewModel
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteItem(at: indexPath) // AVISA o ViewModel
        }
    }
}
