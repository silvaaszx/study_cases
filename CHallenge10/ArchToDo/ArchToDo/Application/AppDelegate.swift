import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // 1. O AppDelegate agora é o "dono" da janela (window)
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 2. Criamos a janela (UIWindow) manualmente com o tamanho da tela
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        // 3. Criamos o nosso Controller (o "C" do MVC)
        let todoViewController = ViewController()
        
        // 4. "Embrulhamos" ele num Navigation Controller para ter a barra no topo
        let navigationController = UINavigationController(rootViewController: todoViewController)
        
        // 5. Definimos o Navigation Controller como o 'root' (início) do app
        window.rootViewController = navigationController
        
        // 6. Tornamos a janela visível e a armazenamos
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}
