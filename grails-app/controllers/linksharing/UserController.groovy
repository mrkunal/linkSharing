package linksharing

class UserController {

    def list() {

        int userCount
        if (session['admin'] == false) {
            flash.message = "Not Accessible"
            redirect(controller: 'home', action: 'dashboard')
            return false
        }
        List<User> users
        if (params['sort'] == null || params['search'] == null) {
            users= User.createCriteria().list() {

                eq('admin', false)
            }
            userCount=User.createCriteria().count{

                eq('admin', false)
            }


        } else {
            String sort = params['sort']
            String search = "%" + params['search'] + "%"
            //StringBuilder search=new StringBuilder("%"+ search1+ "%")


            if (sort == 'active') {
                users = User.createCriteria().list() {
                    or {
                        ilike('firstName', search)
                        ilike('lastName', search)
                        ilike('email', search)
                        ilike('userName', search)

                    }
                    eq("admin", false)
                    eq("active", true)

                }
                userCount = User.createCriteria().count {
                    or {
                        ilike('firstName', search)
                        ilike('lastName', search)
                        ilike('email', search)
                        ilike('userName', search)

                    }
                    eq("admin", false)
                    eq("active", true)

                }

            } else if (sort == 'inactive') {
                users = User.createCriteria().list() {
                    or {
                        ilike('firstName', search)
                        ilike('lastName', search)
                        ilike('email', search)
                        ilike('userName', search)

                    }

                    eq("admin", false)
                    eq("active", false)

                }
                userCount= User.createCriteria().count {
                    or {
                        ilike('firstName', search)
                        ilike('lastName', search)
                        ilike('email', search)
                        ilike('userName', search)

                    }

                    eq("admin", false)
                    eq("active", false)

                }
            } else {
                users = User.createCriteria().list() {
                    or {
                        ilike('firstName', search)
                        ilike('lastName', search)
                        ilike('email', search)
                        ilike('userName', search)
                    }
                    eq("admin", false)

                }
               userCount= User.createCriteria().count{
                   or {
                        ilike('firstName', search)
                        ilike('lastName', search)
                        ilike('email', search)
                        ilike('userName', search)
                    }
                    eq("admin", false)

                }
            }


        }
       // render userCount
        [users: users ,totalUser: userCount]

    }
    /*def userFilter()
    {     params.max = params.max ?: 1
        if (session['admin'] == false) {
            flash.message = "Not Accessible"
            redirect(controller: 'home', action: 'dashboard')
            return false
        }
        List<User> users
        if (params['sort'] == null || params['search'] == null) {
            users = User.createCriteria().list(params) {

                eq('admin', false)
            }


        } else {
            String sort = params['sort']
            String search = "%" + params['search'] + "%"
            //StringBuilder search=new StringBuilder("%"+ search1+ "%")


            if (sort == 'active') {
                users = User.createCriteria().list(params) {
                    or {
                        ilike('firstName', search)
                        ilike('lastName', search)
                        ilike('email', search)
                        ilike('userName', search)

                    }
                    eq("admin", false)
                    eq("active", true)

                }
            } else if (sort == 'inactive') {
                users = User.createCriteria().list(params) {
                    or {
                        ilike('firstName', search)
                        ilike('lastName', search)
                        ilike('email', search)
                        ilike('userName', search)

                    }

                    eq("admin", false)
                    eq("active", false)

                }
            } else {
                users = User.createCriteria().list(params) {
                    or {
                        ilike('firstName', search)
                        ilike('lastName', search)
                        ilike('email', search)
                        ilike('userName', search)
                    }
                    eq("admin", false)

                }
            }


        }
render(template: 'userList',model:[users:users])
    }
*/


    def search() {

        render(view: "list", model: [user: user])


    }

    def access() {
        String userName = params['active']
        User user = User.findByUserName(userName)
        if (user.active == true) {
            user.active = false
        } else {
            user.active = true
        }
        user.save(flush: true)
        [user: User.findAllByAdmin(false)]
        redirect(controller: 'user', action: 'list')

    }

    def profile() {
        User user = User.findByUserName(session['userName'])

        int subscription_total = Subscription.countByUser(user)
        int topic_total = Topic.countByCreatedBy(user)
        List<Topic> topics = Topic.findAllByCreatedBy(user)
        [user: user, topic_total: topic_total, subscription_total: subscription_total, topics: topics]

    }

    def updateInfo() {
        User user = User.findByUserName(session['userName'])

        user.firstName = params['firstName']
        user.lastName = params['lastName']
        user.userName = params['userName']
        boolean photoType = true
        def file = request.getFile('pic')
        if (!file.empty) {
            photoType = false
            if (params?.photo?.getContentType() == 'image/jpeg' ||
                    params?.photo?.getContentType() == 'image/gif' ||
                    params?.photo?.getContentType() == 'image/png' ||
                    params?.photo?.getContentType() == 'image/bmp'
            ) {
                photoType = true
            }
        }
        if ((!user.validate() && photoType == false)) {
            flash.message = "Error while validating the fields." + params + errors
            redirect(controller: "home", action: "dashboard")
        } else {

            if (!file.empty) {
                user.photoName = file.contentType
                user.photo = file.getBytes()
            }

            user.save(failOnError: true, flush: true)
            flash.message = "Profile Updated Successfully"
            session['userName'] = user.userName
            redirect(controller: "home", action: "dashboard")
        }

    }

    def changePassword() {
        if (params['password'] != params['confirmPassword']) {
            flash.message = "Password Not Match"
            redirect(controller: "user", action: "profile")
        } else {
            User user = User.findByUserName(session['userName'])
            user.password = params['password'].encodeAsMD5()
            user.save(flush: true)
            flash.message = "Password Changed Successfully"
            redirect(controller: "home", action: "dashboard")
        }

    }

    def show() {
        User showUser = User.findById(params['uid'])
        User user = User.findByUserName(session['userName'])
        List<Topic> topics = Topic.findAllByCreatedByAndVisibility(showUser, Visibility.PUBLIC)

        List<Resource> posts

        if (user.admin == true || user == showUser) {
            posts = Resource.createCriteria().list()
                    {

                        eq('createdBy', showUser)
                        order('lastUpdated', 'desc')

                    }
        } else {
            posts = Resource.createCriteria().list()
                    {

                        eq('createdBy', showUser)
                        order('lastUpdated', 'desc')
                        'topic'
                                {
                                    eq('visibility', Visibility.PUBLIC)
                                }
                    }

        }
        [showUser: showUser, posts: posts, user: user, topics: topics]

    }


}
