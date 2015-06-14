package linksharing

class Gorm2exerciseController {

    /* GORM2 Exercises


­ Subscription in user dashboard will show the top 5 subscription on the basis of recently
added resource in it. (Page 4 of the document)
­ Use criteria to show the Inbox to the user.
­ User criteria to show the subscribed topics of the user and count of post and subscription of
the topic ( Page 7 of the Document)

  */



/*­ Subscription in user dashboard will show the top 5 subscription on the basis of recently
added resource in it. (Page 4 of the document)
  */

    def query1()
    {
        User u=User.last();
	 List<Subscription> subscriptions =Subscription.findAllByUser(u,[offset:0,max:5,sort:"topic.lastUpdated",order:"desc"])
		render "${subscriptions}"
      
  
 }
  
/*­ Use criteria to show the Inbox to the user.  */
def query2() {
    User u = User.last()
    List<Topic> top = Subscription.createCriteria().list() {   // First Extracting Subscribed Topics of User
        projections { property("topic") }
        eq('user', u)
    }
    List<Resource> readedResource=Resource.createCriteria().list() {   // Second Searching Resources Of the Topics

        inList ('topic', top )
        order("lastUpdated","desc")
    }
     //render "${top}"
    render "${readedResource}"
}

    /*­ User criteria to show the subscribed topics of the user and count of post and subscription of
the topic ( Page 7 of the Document) */
    def query3()
    {
        User u = User.last()
        List<Topic> top = Subscription.createCriteria().list() {    // Extracting Topics From user
            projections { property("topic") }
            eq('user', u)
        }
   def count1
        top.each{ i->                                            // Each Topic Counting Subscribers
            count1 =Subscription.createCriteria().get{
             projections { rowCount() }

              eq("topic",i)

            }

            render " <br/> Topic: ${i}"+" Total Subscription :${count1}"
        }


        top.each{ i->
            def  count2 =Resource.createCriteria().get{                        //Each Topic Counting Posts or Resources
                projections { rowCount() }

                eq("topic",i)

            }

            render " <br/> Topic: ${i}"+ " Total Resources :${count2}"
        }


    }



}