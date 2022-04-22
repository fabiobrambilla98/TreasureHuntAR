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
    
    struct SizeStruct {
        var width: Float = 0.2
        var height: Float = 0.2
    }
    
    init(modelName: String) {
        super.init(name: modelName)
        
        if #available(iOS 15.0, *) {
            
            textureRequest = TextureResource.loadAsync(named: modelName, in: nil).sink { (error) in
                print(error)
            } receiveValue: { (texture) in
                
                guard let image = UIImage(named: modelName, in: nil, with: nil) else {
                    return
                }
                
                let size = self.adjustSize(baseSize: SizeStruct(width: 0.2, height: 0.2), imageSize: SizeStruct(width: Float(image.size.width), height: Float(image.size.height)))
                
                self.width = size.width
                self.height = size.height
                
                let mesh = MeshResource.generateBox(width: size.width, height: size.height, depth: 0)
                var material = UnlitMaterial()
                
                material.color = .init(tint: .white.withAlphaComponent(0.99),
                                       texture: MaterialParameters.Texture(texture))
                
                self.modelEntity = ModelEntity(mesh: mesh, materials: [material])
                self.modelEntity?.name = "parchment"
            }
            
        } else {
            return
        }
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //base : x = k : y
    //baseX : imageX = BaseY : imageY
    private func adjustSize(baseSize: SizeStruct, imageSize: SizeStruct) -> SizeStruct {
        
       
        
        if(imageSize.width >= imageSize.height) {
            return SizeStruct(width: baseSize.width, height: ((baseSize.height * imageSize.height) / imageSize.width))
            
            
            
        } else {
            return SizeStruct(width: ((baseSize.width * imageSize.width) / imageSize.height), height: baseSize.height)
        }
        
    }
    
}
