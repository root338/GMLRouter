//
//  GMLRouterProtocol.swift
//  GMLRouter
//
//  Created by apple on 2020/4/28.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

/// 路由服务需要的服务
public protocol GMLRouterService {
    /// 路由的名字
    var name: String { get }
    
    /// 处理路由任务
    /// - Parameters:
    ///   - task: 处理的任务
    ///   - shouldHandleRelyTask: 是否处理指定任务的前提依赖任务（如果不处理则任务失败），有可能调用多次
    ///   - result: 处理结果
    /// - Returns: 返回结果 (YES 处理完成， NO 处理失败，nil 不能处理)
    func handle(task: GMLRouterTask, shouldHandleRelyTask isShould: ((GMLRouterTask) -> Bool)?, result: GMLRouterCompletion) -> Bool?
}
