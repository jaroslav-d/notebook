//
//  TaskDetail.swift
//  notebook
//
//  Created by Ярослав Дроздов on 10.01.2023.
//

import SwiftUI
import Foundation


struct TaskDetail : View {
    
    @State var record = Record()
    
    private let updateUseCase = UpdateRecordUseCase()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("New note")
            TextField("Input title for record", text: $record.title)
            TextEditor(text: $record.content)
        }.toolbar {
            ToolbarItemGroup {
                if (!record.title.isEmpty || !record.content.isEmpty) {
                    Button("Save") {
                        updateUseCase.execute(record: record)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct TaskDetail_Preview : PreviewProvider {
    static var previews: some View {
        TaskDetail()
    }
}
