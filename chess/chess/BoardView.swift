//
//  BoardView.swift
//  chess
//
//  Created by Kin Der on 20.02.2022.
//

import UIKit

class BoardView: UIView {
 
   var chessEngine = ChessEngine()
    var change = true
    
 
    let ratio: CGFloat = 1
    var originX : CGFloat = -1
    var originY : CGFloat = -1
    var cellSide : CGFloat = -1
    
    var shadowPieces: Set<ChessPiece> = Set<ChessPiece> ()
    var chessDelegate: ChessDelegate? = nil
    
    var fromCol : Int? = nil
    var fromRow : Int? = nil
    
    var colorCol : Int = 0
    var colorRow : Int = 0
    
    var colorCol2 : Int = 0
    var colorRow2 : Int = 0
    
    var movingImage: UIImage? = nil
    var movingPieceX: CGFloat = -1
    var movingPieceY: CGFloat = -1
    
    var blackAtTop = true
    
    override func draw(_ rect: CGRect) {
        cellSide = bounds.width * ratio / 8
        originX = bounds.width * (1 - ratio) / 2
        originY = bounds.height * (1 - ratio) / 2
        drawBoard()
        drawPieces()
        
     
    }
    
    
    
  
  
        
       
   
    

 
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
      
        let first = touches.first!
        



        
        let fingerLocation = first.location(in: self)
     
        
   
        
        
    
        
        
        let toCol : Int = p2p(Int((fingerLocation.x - originX) / cellSide))
        let toRow : Int = p2p(Int((fingerLocation.y - originY) / cellSide))
        print(" Столб - \(toCol) , Ряд - \(toRow)")
        
        
        
        
        
        
        
      //исправляет баг, когда фигура не ставится на собственное место
        
        if  let fromCol = fromCol, let fromRow = fromRow, fromCol == toCol && fromRow == toRow {
            chessDelegate?.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: fromCol, toRow: fromRow)
   
      
        }
        
        else if
            let fromCol = fromCol, let fromRow = fromRow, fromCol != toCol || fromRow != toRow {
          
            chessDelegate?.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
           
            
            
        
            
        }
        
       
        movingImage = nil
        fromCol = nil
         fromRow =  nil
        
    }
    
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let first = touches.first!
//
//        let fingerLocation = first.location(in: self)
//        movingPieceX = fingerLocation.x
//        movingPieceY = fingerLocation.y
//        setNeedsDisplay()
//
//
//
//    }
  
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isMultipleTouchEnabled = true
     
        if  let first = touches.first {
        
        
        let fingerLocation = first.location(in: self)


         fromCol = p2p(Int((fingerLocation.x - originX) / cellSide))
         fromRow  = p2p(Int((fingerLocation.y - originY) / cellSide))
            
            colorCol = p2p(Int((fingerLocation.x - originX) / cellSide))
            colorRow  = p2p(Int((fingerLocation.y - originY) / cellSide))
            
            
           
      
       
            //перемещение, дает картинку фигуры во время перемещения
        if let fromCol = fromCol, let fromRow = fromRow, let movingPiece = chessDelegate?.pieceAt(col: fromCol, row: fromRow) {
            
            
            movingImage = UIImage(named: movingPiece.imageName)
            

           
           
       

          //исправляет баг, когда фигура не ставится на собственное место
          
        }
        }
        if fromCol == fromCol && fromRow == fromRow  && chessEngine.pieceAt(col: fromCol!, row: fromRow!) != nil {
         if  let first = touches.first {
         
         
         let fingerLocation = first.location(in: self)
         let toCol : Int = p2p(Int((fingerLocation.x - originX) / cellSide))
         let toRow : Int = p2p(Int((fingerLocation.y - originY) / cellSide))
         print(" Столб - \(toCol) , Ряд - \(toRow)")
             chessEngine.movePiece(fromCol: fromCol!, fromRow: fromRow!, toCol: toCol, toRow: toCol)
         
         
         
         
         
       //исправляет баг, когда фигура не ставится на собственное место
         
         if  let fromCol = fromCol, let fromRow = fromRow, fromCol == toCol && fromRow == toRow {
             chessDelegate?.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: fromCol, toRow: fromRow)
    
       
         }
         
         else if
             let fromCol = fromCol, let fromRow = fromRow, fromCol != toCol || fromRow != toRow {
           
             chessDelegate?.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
            
             
             
         
             
         }
         
        
         movingImage = nil
         fromCol = nil
          fromRow =  nil
         
        }
       
        
        
  
        
       
        
    }
    }
 
    func drawPieces () {
      
        for piece in shadowPieces where fromCol != piece.col || fromRow != piece.row {
//            if fromCol == piece.col && fromRow == piece.row {
//                continue
//            }
            let pieceImage = UIImage(named: piece.imageName)
           
            
            
            
            
            pieceImage?.draw(in: CGRect(x: originX + CGFloat(p2p(piece.col)) * cellSide, y: originY + CGFloat(p2p(piece.row)) * cellSide, width: cellSide, height: cellSide))
        }
        movingImage?.draw(in: CGRect(x: movingPieceX - cellSide/2 , y: movingPieceY - cellSide/2, width: cellSide, height: cellSide))
    }
    
    
    
    
    
    
    
    func drawBoard () {
        for row in 0..<4 {
        for col in 0..<4 {
            
            drawSqure(col: col * 2, row: row * 2, color: UIColor(red: 0.8026387095, green: 0.8026387095, blue: 0.8026387095, alpha: 1), piece: false)
            drawSqure(col: 1 + col * 2, row: row * 2, color: UIColor.lightGray, piece: false)
            drawSqure(col: 1 + col * 2, row: 1 +  row * 2, color: UIColor(red: 0.8026387095, green: 0.8026387095, blue: 0.8026387095, alpha: 1), piece: false)
            drawSqure(col: col * 2, row: 1 +  row * 2, color: UIColor.lightGray, piece: false)
            drawSqure(col: colorCol, row: colorRow, color: .gray, piece: true)
            
        }
          

            
        }
        
       
    }
    func drawSqure(col: Int, row: Int, color: UIColor, piece: Bool) {
        let path = UIBezierPath(roundedRect: CGRect(x: originX + CGFloat(col) * cellSide, y: originY  + CGFloat(row) * cellSide, width: cellSide, height: cellSide), cornerRadius: 10)
        color.setFill()
         path.fill()
        if piece == true {
          

            
            chessEngine.movePiece(fromCol: fromCol ?? 0, fromRow: fromRow ?? 0 , toCol: fromCol ?? 3, toRow: fromRow ?? 3)
        }
    }
    func p2p(_ coordinate: Int) -> Int{   // p2p: peer 2 peer
        return blackAtTop ? coordinate : 7 - coordinate
        
    }
}


