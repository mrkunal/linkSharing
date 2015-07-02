package linksharing

class SubscriptionController {

    User reqUser
    Topic topic

    def subscribe()
    {
        render params
    }
    def unSubscribe()
    {
        render params
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

    [topic:topic,reqUser:reqUser]
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
            subscription.save()
            flash.message="Successfully Subscribed"
            redirect(controller: 'login',action: 'index')

        }
    }

    def list()
    {


    }

}
