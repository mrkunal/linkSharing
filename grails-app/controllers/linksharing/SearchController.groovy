package linksharing

class SearchController {
SupportService supportService
    def index() {}

    User user

    def find()
    { List<Resource> resourceList
        def trendingTopics=supportService.trending_topic()
        def topPost=supportService.topPost(new Date()-365)
        user=User.findByUserName(session['userName'])
        def subscribedTopics=supportService.subscribedTopics(user)
        String searchFor="%"+params['search'].toString().trim()+"%"

        if(user!=null && user.admin==false) {
            if(params['search'].toString().trim().length()==0)
            { flash.message="Required Some Text" }
            else {
                resourceList = Resource.createCriteria().list {

                    'topic' {
                        ilike('name', searchFor)
                    }

                    or {
                        'topic'
                                {
                                    eq('visibility', Visibility.PUBLIC)
                                }
                        inList('topic', subscribedTopics)
                    }
                    order('lastUpdated', 'desc')

                }
            }
        }
        else if(user!=null && user.admin==true)
        {
            resourceList = Resource.createCriteria().list {

                'topic'{
                    ilike('name',searchFor)
                }
                order('lastUpdated','desc')

            }

        }


    [resource:resourceList,trendingTopics:trendingTopics,topPost:topPost,user:user,searchFor:params['search']]

        //render( controllerName:'user' ,template:"inbox",model: [resources: resourceList] )
    }
}
