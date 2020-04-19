//
//  ViewController.swift
//  SceneKit-Primitives
//
//  Created by MAC on 17/03/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
        
        sceneView.autoenablesDefaultLighting = true
        
        loadCampus()

    }
    
    func loadCampus() {
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/campus.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        let node = SCNNode()
        node.position = SCNVector3(0.0, 0.2, 0.0)
        sceneView.scene.rootNode.addChildNode(node)
        
        loadMainBuilding()
        loadSidewalks()
        loadGrass()
    }
    
    func loadMainBuilding() {
        
        let node = SCNNode()
        let geometry = SCNBox(width: 3.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        geometry.firstMaterial?.diffuse.contents = UIColor.brown
        node.geometry = geometry
        node.scale = SCNVector3(0.5, 0.5, 0.5)
        
        let position = SCNVector3(0.0, 0.0, 0.0)
        node.position = position
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func loadSidewalks() {
        let node = SCNNode()
        
        let geometry = SCNPlane(width: 3.5, height: 1.5)
        geometry.firstMaterial?.diffuse.contents = UIColor.gray
        geometry.firstMaterial?.isDoubleSided = true
        node.geometry = geometry
        node.eulerAngles = SCNVector3(-Float.pi / 2, 0.0, 0.0)
        
        let position = SCNVector3(0.0, -0.5, 0.0)
        node.position = position
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func loadGrass() {
        let node = SCNNode()
        
        let geometry = SCNPlane(width: 4.5, height: 2.0)
        geometry.firstMaterial?.diffuse.contents = UIColor.green
        geometry.firstMaterial?.isDoubleSided = true
        node.eulerAngles.x = -Float.pi / 2
        node.geometry = geometry
        
        let position = SCNVector3(0.0, -0.501, 0.0)
        node.position = position
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func loadTree() {
        let trunkNode = SCNNode()
        
        let trunkGeometry = SCNCylinder(radius: 0.05, height: 0.5)
        trunkGeometry.firstMaterial?.diffuse.contents = UIColor.brown
        trunkNode.geometry = trunkGeometry
        
        let trunkPosition = SCNVector3(2.0, -0.25, 0.75)
        trunkNode.position = trunkPosition
        
        sceneView.scene.rootNode.addChildNode(trunkNode)
        
        let crownNode = SCNNode()
        
        let crownGeometry = SCNSphere(radius: 0.2)
        crownGeometry.firstMaterial?.diffuse.contents = UIColor.green
        crownNode.geometry = crownGeometry
        
        let crownPosition = SCNVector3(0.0, 0.25, 0.0)
        crownNode.position = crownPosition
        
        trunkNode.addChildNode(crownNode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
