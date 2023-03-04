//
//  notebookTests.swift
//  notebookTests
//
//  Created by Ярослав Дроздов on 05.01.2023.
//

import XCTest
@testable import notebook

final class notebookTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUpdateRecordUseCaseOne() throws {
        let usecase = UpdateRecordUseCase()
        let beforeCount = usecase.tasks.count
        let record = Record()
        usecase.execute(record: record)
        usecase.execute(record: record)
        assert(beforeCount + 1 == usecase.tasks.count)
    }

    func testUpdateRecordUseCaseTwo() throws {
        let usecase = UpdateRecordUseCase()
        let beforeCount = usecase.tasks.count
        var record = Record()
        usecase.execute(record: record)
        record.title = "something"
        usecase.execute(record: record)
        assert(beforeCount + 1 == usecase.tasks.count)
    }

    func testUpdateRecordUseCaseTre() throws {
        let usecase = UpdateRecordUseCase()
        let beforeCount = usecase.tasks.count
        let recordOne = Record(id: 0)
        usecase.execute(record: recordOne)
        let recordTwo = Record(id: 1)
        usecase.execute(record: recordTwo)
        assert(beforeCount + 2 == usecase.tasks.count)
    }

    func testDeleteRecordUseCaseOne() throws {
        let usecase = DeleteRecordUseCase()
        let beforeCount = usecase.tasks.count
        let recordOne = Record(id: 0)
        usecase.execute(record: recordOne)
        let recordTwo = Record(id: 1)
        usecase.execute(record: recordTwo)
        assert(beforeCount - 2 == usecase.tasks.count)
    }

}
