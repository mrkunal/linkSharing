package linksharing

class LinkResourceController {



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
            Resource resource=linkResource
            new ReadingItem(resource:resource, isRead: true, user: user).save()
            flash.message="Link Resource Successfully Shared"
            redirect(controller: "home", action: "dashboard")
        }
    }

}
