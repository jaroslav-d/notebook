//
//  ContentView.swift
//  notebook
//
//  Created by Ярослав Дроздов on 05.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var modelData = ModelData()
    
    var body: some View {
        VStack {
            Text("Notes").font(.title)
            ListRecordsView().environmentObject(modelData)
        }
        .padding()
        .toolbar {
            ToolbarItemGroup {
                toolbarItems
            }
        }
    }
    
    var toolbarItems : some View {
        HStack {
            if modelData.isSelectedTasks {
                Image(systemName: "trash").onTapGesture {
                    modelData.deleteSelected()
                }.help("Delete selected")
                Divider().frame(height: 15)
                Image(systemName: "checklist.checked.rtl").onTapGesture {
                    modelData.selectAll()
                }.help("Select all")
                Image(systemName: "xmark.circle").onTapGesture {
                    modelData.cancelSelect()
                }.help("Cancel select")
                Divider().frame(height: 15)
            }
            NavigationLink {
                TaskDetail()
            } label: {
                Image(systemName: "plus").help("Add record")
            }
        }.frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct ListRecordsView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                LazyVStack(spacing: 0) {
                    ForEach(modelData.leftSide, id: \.record.id) { item in
                        ItemListView(record: item.record, isSelected: item.isSelected)
                    }
                }
                LazyVStack(spacing: 0) {
                    ForEach(modelData.rightSide, id: \.record.id) { item in
                        ItemListView(record: item.record, isSelected: item.isSelected)
                    }
                }
            }
        }
    }
}

struct ItemListView : View {
    
    var record: Record
    var isSelected: Bool
    @State var isOpenRecordDetail = false
    
    @EnvironmentObject var modelData: ModelData
    
    private let deleteUseCase = DeleteRecordUseCase()
    
    var body: some View {
        ZStack {
            NavigationLink(
                "",
                destination: TaskDetail(record: record),
                isActive: $isOpenRecordDetail
            )
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(isSelected ? .blue : .gray)
                .shadow(radius: 3)
            Text("\(record.title) \r\n \(record.content)")
                .frame(maxWidth: .infinity)
        }
        .padding(
            EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        )
        .simultaneousGesture(
            LongPressGesture().onEnded { _ in
                deleteUseCase.execute(record: record)
            }
        )
        .simultaneousGesture(
            TapGesture().onEnded {
                modelData.selectRecord(record: record)
            }
        )
        .simultaneousGesture(
            TapGesture(count: 2).onEnded {
                isOpenRecordDetail.toggle()
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView().toolbarItems
            ContentView()
        }
    }
}
