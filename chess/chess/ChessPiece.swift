//
//  ChessPiece\.swift
//  chess
//
//  Created by Kin Der on 20.02.2022.
//


import Foundation

struct ChessPiece: Hashable{
    let col : Int
    let row : Int
    let imageName : String
    let isWhite: Bool
    let rank: ChessRank
}
