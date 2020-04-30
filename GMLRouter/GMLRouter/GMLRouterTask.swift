//
//  GMLRouterTask.swift
//  GMLRouter
//
//  Created by apple on 2020/4/28.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation
/// 路由任务
public protocol GMLRouterTask {
    var routerName: String? { get }
    var serviceName: String? { get }
    
}

///// 路由单个任务对象
//struct GMLRouterTaskItem: GMLRouterTask {
//
//}
///// 路由多个任务对象，存在依赖关系的任务集合
//struct GMLRouterTaskContainer : GMLRouterTask {
//
//}
