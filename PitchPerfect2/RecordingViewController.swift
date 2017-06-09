//
//  RecordingViewController.swift
//  PitchPerfect2
//
//  Created by Admin on 06/06/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController , AVAudioRecorderDelegate {

    @IBOutlet weak var tapToRecord: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    
    @IBOutlet weak var pauseRecording: UIButton!
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseRecording.isEnabled=false
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recrodAudio(_ sender: Any) {
        tapToRecord.text="Is recording"
        recordingButton.isEnabled=false
        pauseRecording.isEnabled=true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String;
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord,with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder( url: filePath!,settings: [:])
        audioRecorder.delegate=self
        audioRecorder.isMeteringEnabled=true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }

    @IBAction func stopRecording(_ sender: Any) {
        tapToRecord.text="Tap to Record"
        recordingButton.isEnabled=true
        pauseRecording.isEnabled=false
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag {
            performSegue(withIdentifier: "recordAudio", sender: audioRecorder.url)
        }
        else {
            print("error")
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recordAudio" {
            let playSoundVc = segue.destination as! playRecordSoundViewController
            let recordedAudioUrl = sender as! URL
            playSoundVc.recordedAudioURL = recordedAudioUrl
            
            
        }
    }
}

