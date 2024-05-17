//
//  JournalEntry.swift
//  JRNL
//
//  Created by 박지혜 on 5/10/24.
//

import UIKit
import MapKit

class JournalEntry: NSObject, MKAnnotation {
    // MARK: - Properties
    let date: Date
    let rating: Int
    let entryTitle: String
    let entryBody: String
    let photo: UIImage?
    let latitude: Double?
    let longitude: Double?
    
    // MARK: Initialization
    // nil일 수도 있기 때문에 옵셔널 지정
    init?(rating: Int, title: String, body: String, photo: UIImage? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        // 데이터 정합성(validation) 체크 - 해당하면 생성이 안됨
        if title.isEmpty || body.isEmpty || rating < 0 || rating > 5 {
            return nil
        }
        self.date = Date()
        self.rating = rating
        self.entryTitle = title
        self.entryBody = body
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var coordinate: CLLocationCoordinate2D {
        guard let lat = latitude,
              let long = longitude else {
            return CLLocationCoordinate2D() // 위도, 경도가 없으면 초기값으로 설정
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
//    var title: String? {
//        date.formatted(.dateTime.year().month().day())
//    }
//    
//    var subtitle: String? {
//        entryTitle
//    }
}

// MARK: - Sample data
struct SampleJournalEntryData {
    var journalEntries: [JournalEntry] = []
    
    // mutating은 수정하는 것이 아니라 메모리 공간을 생성하여 그쪽으로 옮김
    mutating func createSampleJournalEntryData() {
        let photo1 = UIImage(systemName: "sun.max")
        let photo2 = UIImage(systemName: "cloud")
        let photo3 = UIImage(systemName: "cloud.sun")
        guard let journalEntry1 = JournalEntry(rating: 5, title: "Good", body: "Today is good day", photo: photo1) else {
            fatalError("Unable to instantiate journalEntry1")
        }        
        guard let journalEntry2 = JournalEntry(rating: 0, title: "Bad", body: "Today is bad day", photo: photo2, latitude: 37.3318, longitude: -122.0312) else {
            fatalError("Unable to instantiate journalEntry2")
        }
        guard let journalEntry3 = JournalEntry(rating: 3, title: "Ok", body: "Today is ok day", photo: photo3) else {
            fatalError("Unable to instantiate journalEntry3")
        }
        
        journalEntries += [journalEntry1, journalEntry2, journalEntry3]
    }
}
