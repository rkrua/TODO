//
//  Task.swift
//  TODO
//
//

import Foundation

struct Task : Codable {
    var id: Int
    var title: String
    var isCompleted: Bool
    var menu: TaskMenu
}
enum TaskMenu : String,Codable,CaseIterable {
    case work
    case study
    
    func toIndex() -> Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
    static func menu(from index: Int) -> Self? {
        Self.allCases.indices ~= index ? Self.allCases[index] : nil
    }
}
