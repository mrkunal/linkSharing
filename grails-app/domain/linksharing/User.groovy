package linksharing

class User {

  String email
  String userName
  String password
  String passwordConfirm
  String firstName
  String lastName
  byte[] photo
  Boolean admin=false
  Boolean active=false
  Date dateCreated
  Date lastUpdated

  static hasMany=[topic:Topic,subscription:Subscription,readingItem:ReadingItem,
                  resource:Resource,resourceRating:ResourceRating]
  static constraints = {
    email(email:true,blank:false,unique:true,nullable:false)
    password(password:true,nullable:false,blank:false)
    passwordConfirm(password:true)
    passwordConfirm validator:{val,obj->
      obj.password==val
    }

  }



  String toString()
  { return userName }
}
