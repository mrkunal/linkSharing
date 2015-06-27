package linksharing

class LinkResourceController {


    static scaffold=true

    def create()
    {
        String userName= "${session["userName"]}"
     User  user=User.findByUserName(userName)

        List<Topic> top = Subscription.createCriteria().list() {   // First Extracting Subscribed Topics of User
            projections { property("topic") }
            eq('user', user)
        }
        [topics:top]

    }

    def save()
    {
        String userName= "${session["userName"]}"
       User user=User.findByUserName(userName)

        LinkResource linkResource=new LinkResource()
        linkResource.topic=Topic.findById(params['topic'])
        linkResource.url=params['url']
        linkResource.createdBy=user
        linkResource.description=params['description']
        if(!linkResource.validate()) {
            flash.message="Error while Sharing"
            redirect(controller: "home", action: "dashboard")
        }
        else {
            linkResource.save(failOnError: true)
            redirect(controller: "home", action: "dashboard")
        }
    }

}
