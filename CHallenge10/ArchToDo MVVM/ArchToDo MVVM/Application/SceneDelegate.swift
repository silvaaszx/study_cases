import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // O tipo de 'session' foi corrigido aqui
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let newWindow = UIWindow(windowScene: windowScene)
        
        // --- A MUDANÇA ESTÁ AQUI ---
        
        // 1. Criamos o "Cérebro"
        let viewModel = TodoViewModel()
        
        // 2. Criamos a "View Burra" e injetamos o cérebro nela
        let todoViewController = ViewController(viewModel: viewModel)
        
        // 3. "Embrulhamos" em um Navigation Controller
        let navigationController = UINavigationController(rootViewController: todoViewController)
        
        // --- FIM DA MUDANÇA ---
        
        newWindow.rootViewController = navigationController
        self.window = newWindow
        newWindow.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called when the scene has been disconnected from the app (see also application:didDiscardSceneSessions:).
        // This can occur shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created on the next connection.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex: an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
