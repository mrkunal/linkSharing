package linksharing

class HomeController {

    def index() {
        int u= "${session["user_id"]}"
        if(u!=null)
        {
            redirect(action:"dashboard")
        }
        else{redirect(controller: "login",action: "index")}

    }

     def inbox()
    {



    }

 def dashboard()
  { String user= "${session["userName"]}"
      User u=User.findByUserName(user)

      List<Topic> top = Subscription.createCriteria().list() {   // First Extracting Subscribed Topics of User
          projections { property("topic") }
          eq('user', u)
      }
      List<Resource> AllResource=Resource.createCriteria().list() {   // Second Searching Resources Of the Topics

          inList ('topic', top )
          order("lastUpdated","desc")
      }

      List<Resource> readResource=ReadingItem.createCriteria().list {
          projections{
              property('resource')
          }
          eq('user',u)
          inList('resource',AllResource)

      }
      Set rs=AllResource.toSet()
      Set rr=readResource.toSet()

      Set resource=rs-rr
       [resources:resource,user:u]
//
//      render " Top :${top}"
//      render "All Resource :${AllResource}"
//
//      render "<h1>Read Resource </h1>:${readResource}"
//render "${r}"
  }
}
