//
//  Parchment.swift
//  TreasureHuntAR
//
//  Created by MacBook on 20/04/22.
//

import SwiftUI
import RealityKit
import Combine



class ParchmentEntity: ObjectEntity {
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
    
    init(modelName: String) {
        super.init(name: modelName)
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
                
                self.modelEntity = ModelEntity(mesh: mesh, materials: [material])
                self.modelEntity?.width = self.width
                self.modelEntity?.height = self.height
                self.modelEntity?.name = "parchment"
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
