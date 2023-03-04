//
//  UseCase.swift
//  notebook
//
//  Created by Ярослав Дроздов on 12.02.2023.
//

import Foundation
import SwiftUI

struct UpdateRecordUseCase {
    @AppStorage("tasks") var tasks: [Record] = []

    func execute(record: Record) {
        if tasks.contains(where: { it in it.id == record.id }) {
            tasks = tasks.map { it in if it.id == record.id { return record } else { return it } }
        } else {
            tasks.append(record)
        }
    }
}

struct DeleteRecordUseCase {
    @AppStorage("tasks") var tasks: [Record] = []

    func execute(record: Record) {
        tasks.removeAll { it in it.id == record.id }
    }
}

final class ModelData: ObservableObject {
    @AppStorage("tasks") private var tasks: [Record] = []
    
    @Published private var listSelectedRecords: [Int] = []
    
    var isSelectedTasks: Bool {
        !listSelectedRecords.isEmpty
    }
    
    var leftSide: [(record: Record, isSelected: Bool)] {
        tasks.enumerated().filter {
            $0.offset % 2 == 0
        }.map { it in
            (
                it.element, listSelectedRecords.contains { it2 in it2 == it.element.id }
            )
        }
    }
    
    var rightSide: [(record: Record, isSelected: Bool)] {
        tasks.enumerated().filter {
            $0.offset % 2 == 1
        }.map { it in
            (
                it.element, listSelectedRecords.contains { it2 in it2 == it.element.id }
            )
        }
    }
    
    func deleteSelected() {
        tasks.removeAll { it in listSelectedRecords.contains { it2 in it2 == it.id } }
    }
    
    func selectRecord(record: Record) {
        if listSelectedRecords.contains(where: { it in it == record.id }) {
            listSelectedRecords.removeAll { it in it == record.id }
        } else {
            listSelectedRecords.append(record.id)
        }
    }
    
    func selectAll() {
        listSelectedRecords = tasks.map { it in it.id }
    }
    
    func cancelSelect() {
        listSelectedRecords = []
    }
}
