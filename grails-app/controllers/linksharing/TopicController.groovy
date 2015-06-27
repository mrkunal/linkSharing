package linksharing

class TopicController {
def scaffold=true

def create()
{

}

    def save()
    {
        Topic topic = new Topic(params)
        String userName= "${session["userName"]}"
        User user=User.findByUserName(userName)
        topic.createdBy=user
        topic.save(failOnError: true)
        new Subscription(topic:topic,seriousness:Seriousness.SERIOUS,user:user).save(failOnError: true,flush:true)
        flash.message="Topic Created Successfully"
        redirect(controller: "home",action: "dashboard")
    }




}
