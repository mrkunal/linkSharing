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
      LinkResource resource=LinkResource.findById(params['resourceId'])
        [resource:resource,topics:top]


    }

    def save()
    {
        String userName= "${session["userName"]}"
        User user=User.findByUserName(userName)
        LinkResource resourceAlready =LinkResource.findById(params['resourceId'])
        if(resourceAlready==null) {
            LinkResource linkResource = new LinkResource()
            linkResource.topic = Topic.findById(params['topic'])
            linkResource.url = params['url']
            linkResource.createdBy = user
            linkResource.description = params['description']
            if (!linkResource.validate()) {
                flash.message = "Error while Sharing"
                redirect(controller: "linkResource", action: "create")
            } else {
                linkResource.save(failOnError: true)
                Resource resource = linkResource
                new ReadingItem(resource: resource, isRead: true, user: user).save()
                flash.message = "Link Resource Successfully Shared"
                redirect(controller: "linkResource", action: "create")
            }
        }
        else
        {   resourceAlready.url = params['url']
            resourceAlready.description = params['description']
            if (!resourceAlready.validate()) {
                flash.message = "Error while Sharing"
                redirect(controller: "linkResource", action: "create")
            }
            else{
            resourceAlready.save(failOnError: true,flush: true)
                flash.message = "Changes Successfully Made"
                redirect(controller: "linkResource", action: "create")


            }

        }
    }

}
