package linksharing

class UserController {
def scaffold= true

def list()
{
    List<User> user=User.findAllByAdmin(false)
 [user:user]


}

    def search()
    {
        String sort=params['sort']
        List<User> user

        String search="%"+params['search']+"%"
        //StringBuilder search=new StringBuilder("%"+ search1+ "%")


        if(sort=='active') {
            user = User.createCriteria().list {
                or {
                    ilike('firstName',search)
                    ilike('lastName', search)
                    ilike('email', search)
                    ilike('userName', search)

                }
                eq("admin",false)
                eq("active",true)

            }
        }
        else if(sort=='inactive')
        {   user = User.createCriteria().list {
            or {
                ilike('firstName',search)
                ilike('lastName', search)
                ilike('email', search)
                ilike('userName', search)

            }

            eq("admin",false)
            eq("active",false)

        }
        }
        else{
            user = User.createCriteria().list {
                or {
                    ilike('firstName',search)
                    ilike('lastName', search)
                    ilike('email', search)
                    ilike('userName', search)
                }
                eq("admin",false)

            }
        }
        render(view:"list" ,model: [user:user])


    }
    def access()
    {
        String userName=params['active']
        User user=User.findByUserName(userName)
        if(user.active==true)
        { user.active=false}
        else
        {user.active=true}
        user.save(flush: true)
        [user:User.findAllByAdmin(false)]
        redirect(controller: 'user',action: 'list')

    }

}
