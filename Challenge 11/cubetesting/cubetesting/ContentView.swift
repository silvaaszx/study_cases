import SwiftUI
import RealityKit

struct ContentView: View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        // 1. MUDANÇA: Usamos .ar para pegar o movimento do iPad,
        // mas vamos pintar o fundo de preto para parecer VR.
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        
        // 2. MUDANÇA: Pintar o fundo de PRETO (Esconde a câmera real)
        arView.environment.background = .color(.black)
        
        // Material e Mesh (Cubo)
        // Mudei para Azul para ficar mais bonito e adicionei metallic para brilhar
        let material = SimpleMaterial(color: .blue, isMetallic: true)
        let mesh = MeshResource.generateBox(size: 0.15) // Aumentei um pouco (15cm)
        
        let cubo = ModelEntity(mesh: mesh, materials: [material])
        
        // 3. MUDANÇA: Vamos girar o cubo para ele não parecer um quadrado chapado
        // Girar 45 graus no eixo X e Y
        cubo.orientation = simd_quatf(angle: .pi / 4, axis: [1, 1, 0])
        
        // Criar a âncora a 50cm na frente da câmera (z: -0.5)
        let anchor = AnchorEntity(world: [0, 0, -0.5])
        anchor.addChild(cubo)
        
        arView.scene.anchors.append(anchor)
        
        // Luz para dar profundidade
        let light = PointLight()
        light.light.intensity = 2000
        let lightAnchor = AnchorEntity(world: [0, 0.5, 0.5])
        lightAnchor.addChild(light)
        arView.scene.anchors.append(lightAnchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
