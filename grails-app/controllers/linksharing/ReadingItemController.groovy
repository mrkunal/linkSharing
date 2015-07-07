package linksharing

class ReadingItemController {


    def readOrUnread()
    {   User user=User.findByUserName(session['userName'])
        Resource resource=Resource.findById(params['rid'])
        ReadingItem readingItem=ReadingItem.findByUserAndResource(user,resource)
        if(readingItem!=null)
        {   readingItem.delete(flush:true)
            render "Mark As Read"
        }
        else
        {   readingItem=new ReadingItem(user: user,resource: resource,isRead: true)
            readingItem.save(failOnError: true,flush: true)
            render "Mark As Unread"
        }

    }
}
