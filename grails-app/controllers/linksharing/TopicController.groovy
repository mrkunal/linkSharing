package linksharing

class TopicController {

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

    def show()
    {
        Topic topic=Topic.findById(params['topicId'])
        User user=User.findByUserName(session['userName'])
        if(topic==null||topic.visibility==Visibility.PRIVATE && Subscription.findByUserAndTopic(user,topic)==null && user.admin==false)
        {
            flash.message="Access Problem"
            redirect(controller: 'home',action: 'dashboard')
            return false

        }
        else
        {

            List<User> users =Subscription.createCriteria().list([max:10]) {
                projections{
                    property('user')
                }
                eq('topic',topic)

            }
            List<Resource> resources=Resource.findAllByTopic(topic,[max:10])

            [user: user,topic:topic,resources:resources,users:users]

        }

    }
    def search()
    {
        render params

    }



}
