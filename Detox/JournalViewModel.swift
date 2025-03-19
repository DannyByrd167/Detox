//
//  JournalViewModel.swift
//  Detox
//
//  Created by Danny Byrd on 3/15/25.
//

import Foundation

@Observable
class JournalViewModel: Codable {
    var hasCompletedEntry = false
    var feeling: Feeling?
    var response: String = ""
    var difficulty = 5.0
}
