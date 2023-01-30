//
//  ChessEngine.swift
//  chess
//
//  Created by Kin Der on 20.02.2022.
import Foundation

struct ChessEngine {
    
  
    var whitesTurn: Bool = true
    
    var pieces: Set<ChessPiece> = Set<ChessPiece> ()
    
    
    
    mutating func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int)  {
//        if pieceAt(col: fromCol, row: fromRow) == nil {
//            return
//
      
        if !canMovePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow ) {
            return
        }
        guard let candidate = pieceAt(col: fromCol, row: fromRow)   else {
            return
        }
        
        
        
        if   let target = pieceAt(col: toCol, row: toRow) {
            //не позволяет вставать на свои фигуры
            if target.isWhite == candidate.isWhite {
                return
            }
            pieces.remove(target)
        }
        
        pieces.remove(candidate)
        pieces.insert(ChessPiece(col: toCol, row: toRow, imageName: candidate.imageName, isWhite: candidate.isWhite, rank: candidate.rank))
        
        
        
        whitesTurn = !whitesTurn
        
    }
    func canMovePiece(fromCol: Int, fromRow: Int, toCol : Int, toRow: Int) -> Bool {
        if toCol < 0 || toCol > 7 || toRow < 0 || toRow  > 7 {
            return false
        }
     
        guard let candidate = pieceAt(col: fromCol, row: fromRow)
        else {
            return false
        }
        if let target = pieceAt(col: toCol, row: toRow) , target.isWhite == candidate.isWhite {
            return false
        }
        if candidate.isWhite != whitesTurn {
            return false
        }
      
        
        switch candidate.rank {
            
        case .knight:  return canMoveKnight(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
            
        case .rock : return canMoveRock(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        case .bishop : return canMoveBishop(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        case .queen : return canMoveQueen(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        case .king : return canMoveKing(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        case .pawn : return canMovePawn(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        }

        
    }
    func canMoveKing (fromCol: Int, fromRow: Int, toCol : Int, toRow: Int) -> Bool {
        let deltaCol = abs(fromCol - toCol)
        let deltaRow = abs(fromRow - toRow )
        return (deltaCol == 1 || deltaRow == 1) && deltaCol + deltaRow < 3
    }
    
    
    func canMovePawn (fromCol: Int, fromRow: Int, toCol : Int, toRow: Int) -> Bool {
        
       
          
        
        guard let movingPawn = pieceAt(col: fromCol, row: fromRow) else {
            return false
        }
        if movingPawn.isWhite{
            
        
        if fromRow == 6  && toCol == fromCol {
            if pieceAt(col: fromCol, row: 5) == nil {
                return toRow == 5 || toRow == 4 && pieceAt(col: fromCol, row: 4) == nil
            } 
            
        }
             if fromRow < 5  && toCol == fromCol || fromRow == 5 && toCol == fromCol {
                 if pieceAt(col: fromCol, row: toRow) == nil {
                    return fromRow == toRow + 1
                 }
                
                
            }
            if pieceAt(col: fromCol - 1, row: fromRow - 1) != nil  && pieceAt(col: fromCol + 1, row: fromRow - 1) != nil {
                return fromRow == toRow + 1 && fromCol == toCol + 1 || fromRow == toRow + 1 && fromCol == toCol - 1
            }
            if  pieceAt(col: fromCol - 1, row: fromRow - 1) != nil  {
               
                return fromRow == toRow + 1 && fromCol == toCol + 1
            
                  
              }
            if pieceAt(col: fromCol + 1, row: fromRow - 1) != nil  {
                return fromRow == toRow + 1 && fromCol == toCol - 1
                
                
            }
           
   
            
            
//            if pieceAt(col: fromCol + 1, row: fromRow )?.rank == ChessRank.pawn   {
//                return fromRow == toRow + 1 && fromCol == toCol - 1
//
//
//                
//            }
            
            
            
            
            
            
            
          
            return false
            
            
           
        }
        
        
        
        
        
        
        
        
        
            else {
                if fromRow == 1  && toCol == fromCol {
                    if pieceAt(col: fromCol, row: 2) == nil {
                        return toRow == 2 || toRow == 3 && pieceAt(col: fromCol, row: 3) == nil
                    }
                    
                }
                     if fromRow > 2  && toCol == fromCol || fromRow == 2 && toCol == fromCol {
                         if pieceAt(col: fromCol, row: toRow) == nil {
                            return fromRow == toRow - 1
                         }
                        
                        
                    }
              //  fromRow + 1 && fromCol + 1
                
                if pieceAt(col: fromCol - 1, row: fromRow + 1) != nil && pieceAt(col: fromCol + 1, row: fromRow + 1) != nil  {
                    return fromRow == toRow - 1 && fromCol == toCol + 1 || fromRow == toRow - 1 && fromCol == toCol - 1
                }
                
                if  pieceAt(col: fromCol - 1, row: fromRow + 1) != nil  {
                   
                    return fromRow == toRow - 1 && fromCol == toCol + 1
                
                      
                  }
                if pieceAt(col: fromCol + 1, row: fromRow + 1) != nil  {
                    return fromRow == toRow - 1 && fromCol == toCol - 1
                    
                    
                }
               
                
                    
                    return false
                
            }
        
        
       
    }
    
    func canMoveQueen (fromCol: Int, fromRow: Int, toCol : Int, toRow: Int) -> Bool {
        guard emtyBetween(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow )
    else {
        return false
    }
        
        return canMoveBishop(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow) || canMoveRock(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
    }
    func canMoveBishop(fromCol: Int, fromRow: Int, toCol : Int, toRow: Int) -> Bool {

      
            guard emtyBetween(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow )
        else {
            return false
        }
        
         
        return abs(fromCol - toCol) == abs(fromRow - toRow )
    }
    
    func canMoveKnight(fromCol: Int, fromRow: Int, toCol : Int, toRow: Int) -> Bool {
        
        return  abs(fromCol - toCol) == 1  && abs(fromRow - toRow) == 2 || abs(fromRow - toRow) == 1  && abs(fromCol - toCol) == 2
            
   
    }
    
    
    
    
    
    func canMoveRock(fromCol: Int, fromRow: Int, toCol : Int, toRow: Int) -> Bool {
        guard emtyBetween(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow) else {
            return false
        }
        return fromCol == toCol || fromRow == toRow
        
    
    }
    
    
    
    
    func emtyBetween(fromCol: Int, fromRow: Int, toCol : Int, toRow: Int) -> Bool {
        
        if fromRow == toRow { //horizontal
            let minCol = min(fromCol, toCol)
            let maxCol = max(fromCol, toCol)
            if maxCol - minCol < 2 {
                return true
            }
            for  i in minCol + 1 ... maxCol - 1 {
                if pieceAt(col: i, row: fromRow) !=  nil {
                    return false
                }
            }
            return true
            
        } else if fromCol == toCol { //vertical
            let minRow = min(fromRow, toRow)
            let maxRow = max(fromRow, toRow)
            if maxRow - minRow < 2 {
                
                return true
            }
            
            for  i in minRow + 1 ... maxRow - 1 {
                if pieceAt(col: fromCol, row: i) !=  nil {
                    return false
                }
            }
            return true
        }
        
        
        
        
        
        
        
        
        
     
    else if abs(fromCol - toCol) == abs(fromRow - toRow ) //diagonal
    { //top left to bottom right
        
        let minRow = min(fromRow, toRow)
        let maxRow = max(fromRow, toRow)
        let minCol = min(fromCol, toCol)
        let maxCol = max(fromCol, toCol)
        
        
        if fromRow - toRow == fromCol - toCol {
       
        if maxCol - minCol < 2 {
            return true
        }
        for  i in 1 ..< abs(fromCol - toCol){
            if pieceAt(col: minCol + i, row: minRow + i) !=  nil {
                return false
            }
        }
        return true
        }
        //bottom left to top right
        else {
            
            if maxCol - minCol < 2 {
                return true
            }
                for  i in 1 ..< abs(fromCol - toCol) {
                if pieceAt(col: minCol + i, row: maxRow - i) !=  nil {
                    return false
                }
            }
            return true
            
        }
   }
        return false
    }
    
    
    
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        for piece in pieces {
            if col == piece.col && row == piece.row {
                return piece
            }
            
            }
        return nil
        }
  
    
    
    mutating func initializeGame() {
        whitesTurn = true
        
        
        pieces.removeAll()
        pieces.insert(ChessPiece(col: 0, row: 0, imageName: "rockB", isWhite: false, rank: .rock))
        pieces.insert(ChessPiece(col: 7, row: 0, imageName: "rockB", isWhite: false, rank: .rock))
        pieces.insert(ChessPiece(col: 0, row: 7, imageName: "rock", isWhite: true, rank: .rock))
        pieces.insert(ChessPiece(col: 7, row: 7, imageName: "rock", isWhite: true, rank: .rock))
        
        pieces.insert(ChessPiece(col: 1, row: 0, imageName: "knightB", isWhite: false, rank: .knight))
        pieces.insert(ChessPiece(col: 6, row: 0, imageName: "knightB", isWhite: false, rank: .knight))
        pieces.insert(ChessPiece(col: 1, row: 7, imageName: "knight", isWhite: true, rank: .knight))
        pieces.insert(ChessPiece(col: 6, row: 7, imageName: "knight", isWhite: true, rank: .knight))
        
        pieces.insert(ChessPiece(col: 2, row: 0, imageName: "bishopB", isWhite: false, rank: .bishop))
        pieces.insert(ChessPiece(col: 5, row: 0, imageName: "bishopB", isWhite: false, rank: .bishop))
        pieces.insert(ChessPiece(col: 2, row: 7, imageName: "bishop", isWhite: true, rank: .bishop))
        pieces.insert(ChessPiece(col: 5, row: 7, imageName: "bishop", isWhite: true, rank: .bishop))
        
        pieces.insert(ChessPiece(col: 3, row: 0, imageName: "queenB", isWhite: false, rank: .queen))
        pieces.insert(ChessPiece(col: 3, row: 7, imageName: "queen", isWhite: true, rank: .queen))
        
        pieces.insert(ChessPiece(col: 4, row: 0, imageName: "kingB", isWhite: false, rank: .king))
        pieces.insert(ChessPiece(col: 4, row: 7, imageName: "king", isWhite: true, rank: .king))
        
        pieces.insert(ChessPiece(col: 0, row: 1, imageName: "pawnB", isWhite: false, rank: .pawn))
        pieces.insert(ChessPiece(col: 1, row: 1, imageName: "pawnB", isWhite: false, rank: .pawn))
        pieces.insert(ChessPiece(col: 2, row: 1, imageName: "pawnB", isWhite: false, rank: .pawn))
        pieces.insert(ChessPiece(col: 3, row: 1, imageName: "pawnB", isWhite: false, rank: .pawn))
        pieces.insert(ChessPiece(col: 4, row: 1, imageName: "pawnB", isWhite: false, rank: .pawn))
        pieces.insert(ChessPiece(col: 5, row: 1, imageName: "pawnB", isWhite: false, rank: .pawn))
        pieces.insert(ChessPiece(col: 6, row: 1, imageName: "pawnB", isWhite: false, rank: .pawn))
        pieces.insert(ChessPiece(col: 7, row: 1, imageName: "pawnB", isWhite: false, rank: .pawn))
        
        pieces.insert(ChessPiece(col: 0, row: 6, imageName: "pawn", isWhite: true, rank: .pawn))
        pieces.insert(ChessPiece(col: 1, row: 6, imageName: "pawn", isWhite: true, rank: .pawn))
        pieces.insert(ChessPiece(col: 2, row: 6, imageName: "pawn", isWhite: true, rank: .pawn))
        pieces.insert(ChessPiece(col: 3, row: 6, imageName: "pawn", isWhite: true, rank: .pawn))
        pieces.insert(ChessPiece(col: 4, row: 6, imageName: "pawn", isWhite: true, rank: .pawn))
        pieces.insert(ChessPiece(col: 5, row: 6, imageName: "pawn", isWhite: true, rank: .pawn))
        pieces.insert(ChessPiece(col: 6, row: 6, imageName: "pawn", isWhite: true, rank: .pawn))
        pieces.insert(ChessPiece(col: 7, row: 6, imageName: "pawn", isWhite: true, rank: .pawn))
    }
}
extension ChessEngine : CustomStringConvertible {
    var description: String {
        var desc = ""
        
        
        desc += "  0 1 2 3 4 5 6 7\n"
        for row in 0..<8 {
            desc += "\(row)"
            for col in 0..<8 {
                if let piece = pieceAt(col: col, row: row) {
                    switch piece.rank {
                    case .king : desc += piece.isWhite ?  " k" : " K"
                    case .queen:
                        desc += piece.isWhite ?  " q" : " Q"
                    case .bishop:
                        desc += piece.isWhite ?  " b" : " B"
                    case .rock:
                        desc += piece.isWhite ?  " r" : " R"
                    case .knight:
                        desc += piece.isWhite ?  " n" : " N"
                    case .pawn:
                        desc += piece.isWhite ?  " p" : " P"
                    }
                } else  {
                    desc += " ."
                }
          
    
        }
        desc += "\n"
        }
        return desc
    }
}
