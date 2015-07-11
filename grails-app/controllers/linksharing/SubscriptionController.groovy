package linksharing

class SubscriptionController {

    User reqUser
    Topic topic

  /*  def subscribeAndUnsubscribe()
    {
        Topic topic=Topic.findById(params['topicId'])
        User user=User.findByUserName(session['userName'])
        Subscription subscription=Subscription.findByUserAndTopic(user,topic)

        if(subscription==null) {
            subscription = new Subscription(user: user, topic: topic, seriousness: Seriousness.SERIOUS).
                    save(failOnError: true, flush: true)
            render "Unsubscribe"
        }
        else if(subscription.topic.createdBy!=user)
        { subscription.delete(flush: true)
            render "Subscribe"
        }
    }*/


      def subscribeAndUnsubscribe()
      {
          Topic topic=Topic.findById(params['topicId'])
          User user=User.findByUserName(session['userName'])
          Subscription subscription=Subscription.findByUserAndTopic(user,topic)

          if(subscription==null) {
              subscription = new Subscription(user: user, topic: topic, seriousness: Seriousness.SERIOUS).
                      save(failOnError: true, flush: true)

          }
          else if(subscription.topic.createdBy!=user)
          { subscription.delete(flush: true)

          }

    render(template: '/home/trendingsub',model: [user:user,topic: topic])

   }
   def seriousnessChange()
   {
       Topic topic=Topic.findById(params['topicId'])
       User user=User.findByUserName(session['userName'])
       Subscription subscription=Subscription.findByUserAndTopic(user,topic)
       if(subscription!=null) {
           if(params['seriousness']== 'Casual')
           subscription.seriousness=Seriousness.CASUAL
           else if(params['seriousness']== 'Serious')
               subscription.seriousness=Seriousness.SERIOUS
            else if(params['seriousness']== 'Very Serious')
               subscription.seriousness=Seriousness.VERYSERIOUS
           subscription.save(failOnError: true, flush: true)
       }

   }
    def visibilityChange()
    {

        Topic topic=Topic.findById(params['topicId'])
        User user=User.findByUserName(session['userName'])

        if(topic!=null&&(user==topic.createdBy||user.admin==true)) {
            if(params['visibility']== 'Public')
                topic.visibility=Visibility.PUBLIC
            else if(params['visibility']=='Private')
                topic.visibility=Visibility.PRIVATE

            topic.save(failOnError: true, flush: true)
        }

    }

def permission() {
    String s=request.queryString

    String key=s.substring(0,s.indexOf('='))
    char[] val=s.substring(s.indexOf('=')+1,s.length()).decodeBase64()

    String content=val.toString()
    String topicId=content.substring(0,content.indexOf('^'))
    String email=content.substring(content.indexOf('^')+1,content.length())

    topic=Topic.findById(topicId)
    // render "Id"+topic+"  email "+email
    reqUser=User.findByEmail(email)

    Subscription sub=Subscription.findWhere('topic':topic,'user':reqUser)

     if(topic==null)
    {
        flash.message="Topic Does Not Exist"
        redirect(controller:'login',action: 'index')
    }
     else if(reqUser==null)
    {
        flash.message="You Need To be registered first "
        redirect(controller:'login',action: 'index')
    }
     else if (sub!=null)
    {   flash.message="Already Subscribed To this Topic"
        redirect(controller: 'login',action: 'index')}
     else{
        Subscription subscription=new Subscription(topic:topic,user:reqUser,seriousness:Seriousness.SERIOUS)
        subscription.save()
        flash.message="Successfully Subscribed"
        redirect(controller: 'login',action: 'index')
    }

}
    def proceed(){

        Subscription subscription=new Subscription(params)
        subscription.user=reqUser
        subscription.topic=topic

        if(!subscription.validate())
        { flash.message=" Some Exception Occurred"+params+subscription
            redirect(controller: 'login',action: 'index')
        }
        else
        {

        }
    }

    def list()
    {


    }


}
