//
//  Parchment.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import SwiftUI
import RealityKit
import Combine



class ParchmentEntity: ObjectEntity, ObservableObject {
    var textureRequest: AnyCancellable? = nil
    var offset: OffsetStruct = OffsetStruct()
    
    
    struct SizeStruct {
        var width: Float = 0.3
        var height: Float = 0.3
    }
    
    struct OffsetStruct {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var width: CGFloat = .infinity
    }
    
    
    init(modelName: String, anchorEntity: AnchorEntity? = nil, scene: RealityKit.Scene? = nil, parchmentText: String? = nil, textPosition: SIMD3<Float>? = nil, identifier: UUID = UUID(), scale: SIMD3<Float>? = nil, orient: Orientation? = nil) {
        super.init(name: modelName, identifier: identifier)
        self.offset = getImageOffset(modelName)
        
        if #available(iOS 15.0, *) {
            
            textureRequest = TextureResource.loadAsync(named: modelName, in: nil).sink { (error) in
                print(error)
            } receiveValue: { (texture) in
                
                guard let image = UIImage(named: modelName, in: nil, with: nil) else {
                    return
                }
                
                let size = self.adjustSize(baseSize: SizeStruct(), imageSize: SizeStruct(width: Float(image.size.width), height: Float(image.size.height)))
                
                self.width = size.width
                self.height = size.height
                
                
                let mesh = MeshResource.generateBox(width: size.width, height: size.height, depth: 0)
                var material = UnlitMaterial()
                
                material.color = .init(tint: .white.withAlphaComponent(0.99),
                                       texture: MaterialParameters.Texture(texture))
                
                
                
                self.modelEntity = CustomModelEntity(mesh: mesh, materials: [material])
                self.modelEntity?.width = self.width
                self.modelEntity?.height = self.height
                self.modelEntity?.name = "\(Utils.parchmentPrefix.rawValue)\(identifier.uuidString)"
                self.modelEntity!.identifier = self.identifier
                if(anchorEntity != nil && scene != nil){
                    
                    let mesh = MeshResource.generateText(
                        parchmentText!,
                        extrusionDepth: 0.0001,
                        font: .systemFont(ofSize: 0.01),
                        containerFrame: CGRect(x: 0, y: 0, width: 0.3, height: 0.3),
                        alignment: .left,
                        lineBreakMode: .byWordWrapping)
                    
                    let sm = UnlitMaterial(color: UIColor.white)
                    
                    let textEntity = ModelEntity(mesh: mesh, materials: [sm])
                    
                    self.modelEntity!.addChild(textEntity)
                    
                    textEntity.setPosition(textPosition!, relativeTo: self.modelEntity!)
                    
                    self.modelEntity!.generateCollisionShapes(recursive: true)
                    
                    self.modelEntity!.identifier = identifier
                    self.modelEntity!.objectEntity = self
                    self.modelEntity!.synchronization = nil
                    self.modelEntity!.scale = scale!
                    self.modelEntity!.orientation = simd_quatf.init(angle: orient!.angle, axis: orient!.axis)
                    anchorEntity?.addChild(self.modelEntity!)
                    scene?.addAnchor(anchorEntity!)
                    
                    
                    
                }
            }
            
            
        } else {
            return
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    
    
    private func getImageOffset(_ name: String) -> OffsetStruct {
        let values = name.split(separator: "-")
        return OffsetStruct(x: CGFloat(Float(values[1])!) , y: CGFloat(Float(values[2])!) , width: CGFloat(Float(values[3])!) )
    }
    
    
    private func adjustSize(baseSize: SizeStruct, imageSize: SizeStruct) -> SizeStruct {
        
        
        
        if(imageSize.width >= imageSize.height) {
            return SizeStruct(width: baseSize.width, height: ((baseSize.height * imageSize.height) / imageSize.width))
            
            
            
        } else {
            return SizeStruct(width: ((baseSize.width * imageSize.width) / imageSize.height), height: baseSize.height)
        }
        
    }
    
}
