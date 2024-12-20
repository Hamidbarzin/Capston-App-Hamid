import Foundation

class UserManager {
    static let shared = UserManager()
    
    var activeUser: UserModel? {
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isActive == true")
        let result = try? DBManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
        return result?.last?.userModelAdopted
    }
    
    func addUserAndActive(_ user: UserModel) {
        let context = DBManager.shared.persistentContainer.viewContext
        let userDB = User(context: context)
        userDB.username = user.username
        userDB.fullname = user.fullName
        userDB.avatar = user.avatar
        userDB.email = user.email
        userDB.password = user.password
        userDB.phoneNumber = user.phoneNumber
        userDB.isActive = true
        DBManager.shared.saveContext()
    }
    
    func isUserExistAndLogin(username: String, password: String) -> Bool {
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        if let result = try? DBManager.shared.persistentContainer.viewContext.fetch(fetchRequest).first {
            result.isActive = true
            DBManager.shared.saveContext()
            return true
        } else {
            return false
        }
    }
    
    func logout() {
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isActive == true")
        let result = try? DBManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
        result?.forEach { $0.isActive = false }
        DBManager.shared.saveContext()
    }
}

// DB
extension User {
    var userModelAdopted: UserModel {
        UserModel(
            username: username ?? "",
            fullName: fullname ?? "",
            avatar: avatar,
            email: email ?? "",
            password: password ?? "",
            phoneNumber: phoneNumber ?? "",
            isActive: isActive
        )
    }
}
