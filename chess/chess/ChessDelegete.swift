//
//  ChessDelegete.swift
//  chess
//
//  Created by Kin Der on 20.02.2022.
//
import Foundation


protocol ChessDelegate  {
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int)
    func pieceAt(col: Int, row: Int) -> ChessPiece?
}
