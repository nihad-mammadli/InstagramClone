//
//  NotificationService.swift
//  InstagramClone
//
//  Created by Nihad on 03.09.24.
//

import Foundation
import FirebaseCore
import FirebaseAuth

struct NotificationService {
    
    static func uploadNotification(toUid uid: String, fromUser: User,
                                   type: NotificationType, post: Post? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard uid != currentUid else { return }
        
        let docRef = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").document()
        
        var data: [String: Any] = ["timestamp": Timestamp(date: Date()), 
                                   "uid": currentUid,
                                   "id": docRef.documentID,
                                   "type": type.rawValue,
                                   "userProfileImageUrl": fromUser.profileImageURL,
                                   "username": fromUser.username]
        
        if let post = post {
            data["postId"] = post.postId
            data["postImageUrl"] = post.imageUrl
        }
        
        docRef.setData(data)
    }
    
    static func fetchNotification(completion: @escaping([Notification]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let notifications = documents.map({ Notification(dictionary: $0.data())})
            completion(notifications)
        }
    }
    
}
