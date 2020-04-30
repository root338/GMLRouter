//
//  GMLRouterResult.swift
//  GMLRouter
//
//  Created by apple on 2020/4/28.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

//MARK:- Success
/// 路由结果
public struct GMLRouterResult {
    
}

//MARK:- Failure
/// 路由错误结果
public enum GMLRouterError : Error {
    /// 没有找到
    case notFound
    /// 缺少参数
    case missingParameters(error: Error)
    
}
