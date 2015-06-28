package linksharing

class LoginController {
    def mailService

    def index() {

        //Only Public Topics Resource is to be visible in recent shares
        List<Topic> top =Topic.findAllByVisibility("PUBLIC")
        List<Resource> rlist=Resource.findAllByTopicInList(top,[sort:'lastUpdated',order: "desc",max: 5])


        List<Resource> Allresources=Resource.findAllByTopicInList(top)
        List<Resource> topposts=ResourceRating.createCriteria().list([max:5]) {
            projections{
                groupProperty("resource")
                sum("score",'sum')

            }
            order('sum','desc')
            inList('resource',Allresources)

        }*.getAt(0)


     /*   List score                            // can be used to show ratings score.
        List<Resource> topResource
         topposts.each{toppost->
             score<<toppost.last()
            topResource <<toppost.first()
         //   println t+"  "+ r
        }
         */

        [resources:rlist,toppost:topposts]

    }
    def loginHandler(){
   /*     User user = User.findByUserName(params.userName)
        if(user.password == params.password.toString().encodeAsMD5()){
  render "Verified User"
        }
        else {

            render "UnVerified User"
        } */
        String email = params.get("email");
        String password = params.get("password")
        User user = User.findByEmail(email);

        if (user?.password == password) {
            session["userName"] = user.userName;
            session["user_id"] = user.id;
            flash.message="Successfully Login"
            redirect(controller: "home", action: "index")
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
                flash.message="Error while validating the fields."+params+errors
                redirect(controller:"login",action:"index")

            }
            else {
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
        user.password=password
        user.save(flush: true)
        flash.message="password Sent"
        redirect(action:"forgot")}
     }

}

