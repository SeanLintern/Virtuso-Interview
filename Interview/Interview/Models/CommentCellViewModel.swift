//
//  CommentCellViewModel.swift
//  Interview
//
//  Created by Sean Lintern on 29/01/2021.
//

import Foundation

protocol CommentCellViewModel {
    var name: String {get}
    var email: String {get}
    var body: String {get}
    var id: Int {get}
}

extension Comment: CommentCellViewModel {}
