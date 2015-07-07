package linksharing

class LoginController {
    def mailService
     SupportService supportService
    def index() {

        //Only Public Topics Resource is to be visible in recent shares
        List<Topic> top =Topic.findAllByVisibility("PUBLIC")
        List<Resource> rlist=Resource.findAllByTopicInList(top,[sort:'lastUpdated',order: "desc",max: 5])
        List<Resource> topposts=supportService.topPost(new Date()-1)
        [resources:rlist,toppost:topposts]

    }
def topPostAjax()
{
    List<Resource> topposts
    if(params['sort']==null||params['sort']=='today')
        topposts=supportService.topPost(new Date()-1)
    else if(params['sort']=='week')
    { def date
        use (groovy.time.TimeCategory) {
            date = new Date() - 7.days
        }
        topposts=supportService.topPost(date)
    }
    else if(params['sort']=='month')
    { def date
        use (groovy.time.TimeCategory) {
            date = new Date() - 1.month
        }
        topposts=supportService.topPost(date)
    }
    else if(params['sort']=='year')
    { def date
        use (groovy.time.TimeCategory) {
            date = new Date() - 1.year
        }
        topposts=supportService.topPost(date)
    }
   render (template: 'recentShare',model:[resources: topposts])
}
    def loginHandler(){

        String email = params.get("email");
        String password = params.get("password")
        User user = User.findByEmail(email);

        if (user!=null && user.password == password.encodeAsMD5() && user.active==true) {
            session["userName"] = user.userName;
            //session["user_id"] = user.id;
            session["admin"]=user.admin
            flash.message="Successfully Login"
            redirect(controller: "home", action: "dashboard")
        } else {
            flash.message="UserId or Password Mismatch"
            redirect(controller: "login", action: "index")

        }


    }

    def register(UserCO userco)
    {
          User user=new User();
          bindData(user,userco)

            if ((!user.validate())||(userco.password!=userco.confirmPassword)) {
                flash.message="Error while validating the fields."
                redirect(controller:"login",action:"index")

            }
            else {

                user.password=user.password.encodeAsMD5()
                def file=request.getFile('pic')

                if(!file.empty) {
                    user.photoName = file.contentType
                    user.photo = file.getBytes()
                }

                    user.save(failOnError: true)
                    flash.message = "User Created Successfully"
                    redirect(controller: "login", action: "index")
                }
            }




    def show()
    {
        List<Resource> rlist=Resource.list([sort:'lastUpdated',order: "desc",max: 5])


        [resources:rlist]

    }




def forgot()
{

}
 def query()
{
 String email=params['email']
    User user=User.findByEmail(email)
    if(user==null)
    {   flash.message="Email ID Doesnt exist"
        redirect(action: "forgot")}

    else
    {


def password=new String()
        Random r=new Random()
        5.times{
            password+=r.nextInt(100)
        }


        mailService.sendMail {
            to "${email}"
            subject "Password Reset"
            body "Your New Password is :" + "${password}"
        }
        user.password=password.encodeAsMD5()
        user.save(flush: true)
        flash.message="password Sent"
        redirect(action:"forgot")}
     }

}

