//
//  GMLRouter.swift
//  GMLRouter
//
//  Created by apple on 2020/4/28.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

public class GMLRouter: NSObject {
    static var `default` = GMLRouter(name: "")
    /// 路由名字
    let name: String
    /// 父类路由
    weak private(set) var superRouter: GMLRouter?
    
    private lazy var routers = [String : GMLRouter]()
    private lazy var services = [String : GMLRouterService]()
    
    public init(name: String) {
        self.name = name
        super.init()
    }
}
//MARK:- 注册/取消 路由
public extension GMLRouter {
    func register(router: GMLRouter) -> GMLRouter? {
        guard isRegister(router: router) else {
            return nil
        }
        routers[router.name] = router
        router.superRouter = self
        return router
    }
    
    func remove(router: GMLRouter) -> GMLRouter? {
        guard let oldRouter = routers.removeValue(forKey: router.name) else {
            return nil
        }
        oldRouter.superRouter = nil
        return oldRouter
    }
    
    func register(service: GMLRouterService) {
        services[service.name] = service
    }
    
    func remove(service: GMLRouterService) -> GMLRouterService? {
        return services.removeValue(forKey: service.name)
    }
}

//MARK:- 寻址
public extension GMLRouter {
    
    /// 处理路由任务
    /// - Parameters:
    ///   - task: 处理的任务
    ///   - shouldHandleRelyTask: 是否处理指定任务的前提依赖任务（如果不处理则任务失败），有可能调用多次
    ///   - result: 处理结果
    /// - Returns: 返回结果 (YES 处理完成， NO 处理失败，nil 不能处理)
    func handle(task: GMLRouterTask, shouldHandleRelyTask isShould: ((GMLRouterTask) -> Bool)?, result: GMLRouterCompletion) -> Bool? {
        for (_, service) in services {// 注册的具体服务处理
            guard let result = service.handle(task: task, shouldHandleRelyTask: isShould, result: result) else {
                continue
            }
            return result
        }
        for (_, router) in routers {// 注册的子路由处理
            guard let result = router.handle(task: task, shouldHandleRelyTask: isShould, result: result) else {
                continue
            }
            return result
        }
        // 都无法处理向上传递
        return superRouter?.handle(task: task, shouldHandleRelyTask: isShould, result: result)
    }
}

extension GMLRouter {
    func isRegister(router: GMLRouter) -> Bool {
        if isExist(router: router) {
            return false
        }
        return self.superRouter?.isRegister(router: router) ?? true
    }
    
    func isExist(router: GMLRouter) -> Bool {
        return routers.keys.contains(router.name)
    }
    
    func isExist(service: GMLRouterService) -> Bool {
        return services.keys.contains(service.name)
    }
}
