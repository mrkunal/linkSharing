package linksharing

class ReadingItemController {


    def markAsRead()
    {
        User user=User.findByUserName(session['userName'])
        Resource resource=Resource.findById(params['resource'])
        if(user!=null && resource!=null)
        {  ReadingItem readingItem=new ReadingItem(user: user,resource: resource,isRead: true)
            readingItem.save(failOnError: true,flush: true)
            redirect(controller:"home",action: "dashboard")
        }
        else
        {
            flash.message="Some Error Occured."
            redirect(controller:"home",action: "dashboard")
        }

    }

    def markAsUnread()
    {
        User user=User.findByUserName(session['userName'])
        Resource resource=Resource.findById(params['resource'])
         ReadingItem readingItem=ReadingItem.findByUserAndResource(user,resource)
    if(readingItem!=null)
    {   readingItem.delete()
        readingItem.save(flush:true)
        redirect(controller:"home",action: "dashboard")
        }
        else
        {
            flash.message="Some Error Occured."
            redirect(controller:"home",action: "dashboard")
        }

    }

}
