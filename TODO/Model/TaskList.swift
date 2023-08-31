//
//  TaskList.swift
//  TODO
//
//

import Foundation

struct TaskList {
    private static let standard = UserDefaults.standard
    private static let key = "TaskList"
    static func filterbyMenu(menu: TaskMenu) -> [Task] {
        return Self.taskList().filter{ $0.menu == menu }
    }
    static func completeList() -> [Task] {
        return Self.taskList().filter{ $0.isCompleted == true }
    }
    
    // 데이터 불러옥
    static func taskList() -> [Task] {
        if let encode = TaskList.standard.object(forKey: Self.key) as? Data ,
           let taskList = try? JSONDecoder().decode([Task].self, from: encode) {
            return taskList
        }
        return []
    }
    
    
    static func completeTask(task: Task, isCompleted: Bool) {
        var list = Self.taskList()
        for index in 0 ..< list.count {
            if list[index].id == task.id {
                list[index].isCompleted = isCompleted
            }
        }
        updateTaskList(list)
    }
    
    static func addTask(_ task: Task) {
        var taskList = Self.taskList()
        taskList.append(task)
        Self.updateTaskList(taskList)
    }
    
    static func updateTaskList(_ taskList : [Task] ) {
        if let encode = try? JSONEncoder().encode(taskList) {
            TaskList.standard.set(encode, forKey: Self.key)
        }
    }
    
    static func editTask(task: Task, title: String) {
        var list = Self.taskList()
        for index in 0 ..< list.count {
            if list[index].id == task.id {
                list[index].title = title
            }
        }
        updateTaskList(list)
    }
    static func editMenu(task: Task, menu: TaskMenu) {
        var list = Self.taskList()
        for index in 0 ..< list.count {
            if list[index].id == task.id {
                list[index].menu = menu
            }
        }
        updateTaskList(list)
    }
    static func deleteTask(task: Task) {
        var list = Self.taskList()
        list.removeAll(where: {$0.id == task.id})
        updateTaskList(list)
    }
}
