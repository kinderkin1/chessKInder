//
//  ViewController.swift
//  chess
//
//  Created by Kin Der on 20.02.2022.
//


import UIKit
import MultipeerConnectivity


class ViewController: UIViewController {
   var reseter = false
    var peerID: MCPeerID!
    var session: MCSession!
    var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser!
    var numberOfTaps = 0
    
    var chessEngine : ChessEngine = ChessEngine()
    
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var boardView: BoardView!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
     
        
        
        peerID = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        
        
        boardView.chessDelegate = self
        
        chessEngine.initializeGame()
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
        
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "gt-chess")
        nearbyServiceAdvertiser.delegate = self
        nearbyServiceAdvertiser.startAdvertisingPeer()
        

    }
   
    @IBAction func advertise(_ sender: Any) {
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "gt-chess")
        nearbyServiceAdvertiser.delegate = self
        nearbyServiceAdvertiser.startAdvertisingPeer()
        
        
    }
    
    @IBAction func join(_ sender: Any) {
        boardView.blackAtTop = !boardView.blackAtTop
        let browser = MCBrowserViewController(serviceType: "gt-chess", session: session)
        browser.delegate = self
        present(browser, animated: true)
        boardView.setNeedsDisplay()
        
    }
    
    
    @IBAction func reset(_ sender: Any) {
        infoLabel.text = "White"
        chessEngine.initializeGame()
        reseter = !reseter
    
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
    }
}















extension ViewController : MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
    }
    
    
}
extension ViewController : MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }
    
    
}
extension ViewController : MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            print("not connected: \(peerID.displayName)")
        case .connecting:
            print("connecting: \(peerID.displayName)")
        case .connected:
                        print("connected: \(peerID.displayName)")
        @unknown default:
            fatalError()
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("received data")
        
        if let move = String(data: data, encoding: .utf8) {
            let moveArr = move.components(separatedBy: ":")
    
          if  let fromCol : Int = Int(moveArr[0]), let fromRow : Int = Int(moveArr[1]), let toCol : Int = Int(moveArr[2]), let toRow : Int = Int(moveArr[3])
            {
              DispatchQueue.main.async {
                  self.updateMove(fromCol: fromCol, fromRow: fromRow, toCol:toCol, toRow: toRow)
              
          }
           
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("received data")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {

    }
    
    
}

extension ViewController: ChessDelegate  {
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
      
        updateMove(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        let move: String = "\(fromCol):\(fromRow):\(toCol):\(toRow)"
        if let data = move.data(using: .utf8) {
          try?   session.send(data, toPeers: session.connectedPeers, with: .reliable)
        }
    }
    
    func updateMove(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int)  {
        chessEngine.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
        
        if chessEngine.whitesTurn {
            infoLabel.text = "White"
        }
        
        else {
            infoLabel.text = "Black"
        }
       
    }
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        return chessEngine.pieceAt(col: col, row: row)
    }
}
