//
//  ChessEngineTest.swift
//  chessTests
//
//  Created by Kin Der on 20.02.2022.
//

import XCTest
@testable import chess





class ChessEngineTest: XCTestCase {

    func testPrintingEmtyGameBoard() {
        var game = ChessEngine()
        game.initializeGame()
        print(game)
    }
    func testPieceNotAllowedToGoOutOfTheBoard() {
        var game = ChessEngine()
        game.initializeGame()
       
        XCTAssertFalse(game.canMovePiece(fromCol: 0, fromRow: 7, toCol: -1, toRow: 7))
        XCTAssertFalse(game.canMovePiece(fromCol: 0, fromRow: 7, toCol: 8, toRow: 7))
        XCTAssertFalse(game.canMovePiece(fromCol: 0, fromRow: 7, toCol: 0, toRow: 8))
        XCTAssertFalse(game.canMovePiece(fromCol: 0, fromRow: 7, toCol: 0, toRow: -1))
    }
    func testAvoudCapturingOwnPieces() {
        var game = ChessEngine()
        game.initializeGame()
        XCTAssertFalse(game.canMovePiece(fromCol: 0, fromRow: 7, toCol: 0, toRow: 6))
        
    }
    /*
     0 1 2 3 4 5 6 7
   0 . . . . . . . .
   1 . . . . . . . .
   2 . . . . . . . .
   3 . . . . . . . .
   4 . . . . . . . .
   5 . x . . . . . .
   6 . . . . . . . .
   7 . n . . . . . .
     */
    func testKnightRules() {
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 1, row: 7, imageName: "", isWhite: true, rank: .knight))
        XCTAssertFalse(game.canMovePiece(fromCol: 1, fromRow: 7, toCol: 1, toRow: 5))
        print(game)
       
    }
    func testRockRules() {
        /*
         
          0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . . . . . . .
        3 . . . . . . . .
        4 . . . . . . . .
        5 . . . . . . . .
        6 o x . . . . . .
        7 r o . . . . . .
         */
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 0, row: 7, imageName: "", isWhite: true, rank: .rock))
        XCTAssertFalse(game.canMovePiece(fromCol: 0, fromRow: 7, toCol: 1, toRow: 6))
        print(game)
    }
/*
  0 1 2 3 4 5 6 7
0 . . . . . . . .
1 . . . . . . . .
2 . . . . . . . .
3 . . . . . . . .
4 . . x . . . . .
5 . . . . . . . .
6 . o . o . . . .
7 . . b . . . . .
  0 1 2 3 4 5 6 7
 */
    func testBishopRules() {
        var game = ChessEngine()
       
        game.pieces.insert(ChessPiece(col: 2, row: 7, imageName: "", isWhite: true, rank: .bishop))
   
        XCTAssertFalse(game.canMovePiece(fromCol: 2, fromRow: 7, toCol: 2, toRow: 4))
        /*
        0 1 2 3 4 5 6 7
      0 . . B . . B . .
      1 . P . P P . P .
      2 x . . x x . . x
      3 . . . . . . . .
      4 . . . . . . . .
      5 x . . x x . . x
      6 . p . p p . p .
      7 . . b . . b . .
        0 1 2 3 4 5 6 7
       */
        game.pieces.insert(ChessPiece(col: 1, row: 6, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 3, row: 6, imageName: "", isWhite: true, rank: .pawn))
        XCTAssertFalse(game.canMovePiece(fromCol: 2, fromRow: 7, toCol: 4, toRow: 5))
        
        XCTAssertFalse(game.canMovePiece(fromCol: 2, fromRow: 7, toCol: 4, toRow: 5))
        XCTAssertFalse(game.canMovePiece(fromCol: 2, fromRow: 7, toCol: 0, toRow: 5))
        
        
        
        game.pieces.insert(ChessPiece(col: 5, row: 7, imageName: "", isWhite: true, rank: .bishop))
        
        game.pieces.insert(ChessPiece(col: 6, row: 6, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 4, row: 6, imageName: "", isWhite: true, rank: .pawn))
        
       
        XCTAssertFalse(game.canMovePiece(fromCol: 5, fromRow: 7, toCol: 7, toRow: 5))
        XCTAssertFalse(game.canMovePiece(fromCol: 5, fromRow: 7, toCol: 3, toRow: 5))
        
        
        game.pieces.insert(ChessPiece(col: 2, row: 0, imageName: "", isWhite: false, rank: .bishop))
        
        game.pieces.insert(ChessPiece(col: 1, row: 1, imageName: "", isWhite: false, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 3, row: 1, imageName: "", isWhite: false, rank: .pawn))
        
        XCTAssertFalse(game.canMovePiece(fromCol: 2, fromRow: 0, toCol: 0, toRow: 2))
        XCTAssertFalse(game.canMovePiece(fromCol: 2, fromRow: 0, toCol: 4, toRow: 2))
        
        game.pieces.insert(ChessPiece(col: 5, row: 0, imageName: "", isWhite: false, rank: .bishop))
        
        game.pieces.insert(ChessPiece(col: 4, row: 1, imageName: "", isWhite: false, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 6, row: 1, imageName: "", isWhite: false, rank: .pawn))
        
        XCTAssertFalse(game.canMovePiece(fromCol: 5, fromRow: 0, toCol: 7, toRow: 2))
        XCTAssertFalse(game.canMovePiece(fromCol: 5, fromRow: 0, toCol: 3, toRow: 2))
        print(game)
        
        
        
    }
    
    func testKingRules() {
        /*
         0 1 2 3 4 5 6 7
       0 . . . . . . . .
       1 . . . . x . . .
       2 . . . . . . . .
       3 . . . k . x . .
       4 . . . . . . . .
       5 . . . . . . . .
       6 . . . . . . . .
       7 . . . . . . . .
         */
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 3, row: 3, imageName: "", isWhite: true, rank: .king))
        XCTAssertFalse(game.canMovePiece(fromCol: 3, fromRow: 3, toCol: 3, toRow: 3))
        XCTAssertFalse(game.canMovePiece(fromCol: 3, fromRow: 3, toCol: 5, toRow: 3))
        
        XCTAssertFalse(game.canMovePiece(fromCol: 3, fromRow: 3, toCol: 4, toRow: 1))

    }
    func testPawnRules() {
        /*
         0 1 2 3 4 5 6 7
       0 . . . . . . . .
       1 . . . . . . . .
       2 . . . . . . . .
       3 . . . . . . . .
       4 . . . . . o . .
       5 . . . . x o x .
       6 . . . . x p x .
       7 . . . . . . . .
         */
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 5, row: 6, imageName: "", isWhite: true, rank: .pawn))
        XCTAssertFalse(game.canMovePiece(fromCol: 5, fromRow: 6, toCol: 6, toRow: 5))
        XCTAssertTrue(game.canMovePiece(fromCol: 5, fromRow: 6, toCol: 5, toRow: 5))
        XCTAssertTrue(game.canMovePiece(fromCol: 5, fromRow: 6, toCol: 5, toRow: 4))
        
        
        /*
         0 1 2 3 4 5 6 7
       0 . . . . . . . .
       1 . . . . . . . .
       2 . . . . . . . .
       3 . . . . . . . .
       4 . . . . . x . .
       5 . . . . x n x .
       6 . . . . x p x .
       7 . . . . . . . .
         */
         game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 5, row: 6, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 5, row: 5, imageName: "", isWhite: true, rank: .knight))
        XCTAssertFalse(game.canMovePiece(fromCol: 5, fromRow: 6, toCol: 5, toRow: 4))
        
        /*
         0 1 2 3 4 5 6 7
       0 . . . . . . . .
       1 P . . . . . . .
       2 ? . . . . . . .
       3 . . . . . . . .
       4 . . . . . ? . .
       5 . . . . . ? ? .
       6 . . . . . p . .
       7 . . . . . . . .
         */
        
        
        /*
         0 1 2 3 4 5 6 7
       0 . . . . . . . .
       1 . . . . . P . .
       2 . . . . h . h .
       3 . . . . . . . .
       4 . . . . . . . .
       5 . . . . H . H .
       6 . . . . . p . .
       7 . . . . . . . .
         */
        game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 5, row: 6, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 6, row: 5, imageName: "", isWhite: false, rank: .knight))
        XCTAssertTrue(game.canMovePiece(fromCol: 5, fromRow: 6, toCol: 6, toRow: 5))
        game.pieces.insert(ChessPiece(col: 4, row: 5, imageName: "", isWhite: false, rank: .knight))
        XCTAssertTrue(game.canMovePiece(fromCol: 5, fromRow: 6, toCol: 4, toRow: 5))
        
        
        
    }
    func testEnPassant() {
        /*
         
          0 1 2 3 4 5 6 7
        0 . . . . . . . .
        1 . . . . . . . .
        2 . . x . . . . .
        3 . . P p . . . .
        4 . . . . . . . .
        5 . . . . . . . .
        6 . . . . . . . .
        7 . . . . . . . .
         */
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 3, row: 3, imageName: "", isWhite: true, rank: .pawn))
        game.pieces.insert(ChessPiece(col: 2, row: 3, imageName: "", isWhite: false, rank: .pawn))
        XCTAssertFalse(game.canMovePiece(fromCol: 3, fromRow: 3, toCol: 2, toRow: 2))
        print(game)
    }
    
    
}
