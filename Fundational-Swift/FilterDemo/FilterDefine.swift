//
//  FilterDefine.swift
//  FilterDemo
//
//  Created by 孙超杰 on 2017/3/2.
//  Copyright © 2017年 Chaojie Sun. All rights reserved.
//

import UIKit

// 定义Filter类型为一个函数
typealias Filter = (CIImage) -> CIImage

// 构建滤镜
//func myFilter(/*parameters*/) -> Filter

// 模糊滤镜
func blur(radius: Double) -> Filter {
    return { image in
        let parameters = [
            kCIInputRadiusKey: radius,
            kCIInputImageKey: image
            ] as [String : Any]
        guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters) else {fatalError()}
        guard let outputImage = filter.outputImage else {fatalError()}
        return outputImage
    }
}

// 颜色叠层（固定颜色+定义合成滤镜）

// 生产固定颜色的滤镜
func colorGenerator(color: UIColor) -> Filter {
    return { _ in
        let c = CIColor(color: color)
        let parameters = [kCIInputColorKey: c]
        guard let filter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: parameters) else {fatalError()}
        guard let outputImage = filter.outputImage else {fatalError()}
        return outputImage
    }
}

// 定义合成滤镜
func compositeSourceOver(overlay: CIImage) -> Filter {
    return { image in
        let parameters = [
            kCIInputBackgroundImageKey: image,
            kCIInputImageKey: overlay
        ]
        guard let filter = CIFilter(name: "CISourceOverCompositing", withInputParameters: parameters) else {fatalError()}
        guard let outputImage = filter.outputImage else {fatalError()}
        let cropRect = image.extent
        return outputImage.cropping(to: cropRect)
    }
}

// 最后的合成
func colorOverlay(color: UIColor) -> Filter {
    return { image in
        let overlay = colorGenerator(color: color)(image)
        return compositeSourceOver(overlay: overlay)(image)
    }
}

// 定义一个用于组合滤镜的函数
func composeFilter(filter1: @escaping Filter, _ filter2: @escaping Filter) -> Filter {
    return { image in filter2(filter1(image))}
}

// 自定义运算符
// 为了让代码更具有可读性， 我们可以再进一步， 为组合滤镜引入运算符
// 诚然， 随意自定义运算符并不一定对提升代码可读性有帮助。不过，在图像处理库中， 滤镜的组合式一个反复背讨论的问题， 所以引入运算符极有意义

precedencegroup FilterCopositivePrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}

infix operator >>>: FilterCopositivePrecedence
func >>>(filter1: @escaping Filter, filter2: @escaping Filter) -> Filter {
    return {image in filter2(filter1(image))}
}
