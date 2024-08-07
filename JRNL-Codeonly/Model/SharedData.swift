//
//  SharedData.swift
//  JRNL-Codeonly
//
//  Created by 박지혜 on 5/17/24.
//

import UIKit

class SharedData {
    static let shared = SharedData()
    private var journalEntries: [JournalEntry]

    private init() {
        journalEntries = []
    }

    func numberOfJournalEntries() -> Int {
        journalEntries.count
    }

    func getJournalEntry(index: Int) -> JournalEntry {
        journalEntries[index]
    }

    func getAllJournalEntries() -> [JournalEntry] {
        let readOnlyJournalEntries = journalEntries
        return readOnlyJournalEntries
    }

    func addJournalEntry(newJournalEntry: JournalEntry) {
        journalEntries.append(newJournalEntry)
    }

    func removeJournalEntry(index: Int) {
        journalEntries.remove(at: index)
    }

    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadJournalEntriesData() {
        // load는 save된 데이터를 가져오기 때문에 디렉토리 존재 여부를 검사하지 않아도 됨
        let fileURL = getDocumentDirectory().appendingPathComponent("journalEntriesData.json")
        do {
            let data = try Data(contentsOf: fileURL)
            let journalEntriesData = try JSONDecoder().decode([JournalEntry].self, from: data)
            journalEntries = journalEntriesData
        } catch {
            print("Failed to read JSON data: \(error.localizedDescription)")
        }
    }
    
    func saveJournalEntriesData() {
        let pathDirectory = getDocumentDirectory()
        try? FileManager.default.createDirectory(at: pathDirectory, withIntermediateDirectories: true)
        let fileURL = pathDirectory.appendingPathComponent("journalEntriesData.json")
        let json = try? JSONEncoder().encode(journalEntries)
        do {
            try json!.write(to: fileURL)
        } catch {
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }

}
