//
//  ViewController.swift
//  FilterDemo
//
//  Created by 孙超杰 on 2017/3/2.
//  Copyright © 2017年 Chaojie Sun. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "https://www.objc.io/images/covers/16.jpg")!
        let image = CIImage(contentsOf: url)!
        
        let blurRadius = 5.0
        let overlayColor = UIColor.red.withAlphaComponent(0.2)
        
        let imageView = UIImageView()
        imageView.frame = CGRect(origin: CGPoint.zero, size: view.bounds.size)
        // 实现方式一
        //        let blurredImage = blur(radius: blurRadius)(image)
        //        let overlaidImage = colorOverlay(color: overlayColor)(blurredImage)
        //        imageView.image = UIImage(ciImage: overlaidImage)
        
        // 实现方式二
        //        let result = colorOverlay(color: overlayColor)(blur(radius: blurRadius)(image))
        //        imageView.image = UIImage(ciImage: result)
        
        // 实现方式三（在定义composeFilters自定义组合滤镜函数之后)
        //        let myFilter1 = composeFilter(filter1: blur(radius: blurRadius), colorOverlay(color: overlayColor))
        //        let result1 = myFilter1(image)
        //        imageView.image = UIImage(ciImage: result1)
        
        
        // 实现方式四 (在自定义>>>操作符之后)
        let myFilter2 = blur(radius: blurRadius)>>>colorOverlay(color: overlayColor)
        let result2 = myFilter2(image)
        imageView.image = UIImage(ciImage: result2)
        
        view.addSubview(imageView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
