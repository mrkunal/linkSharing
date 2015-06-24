package linksharing
import org.springframework.web.multipart.commons.CommonsMultipartFile

class LoginController {

    def index() {


        List<Resource> rlist=Resource.list([sort:'lastUpdated',order: "desc",max: 5])


        List<Resource> toppost=ResourceRating.createCriteria().list {
  projections{ property("resource")
             sum("score")}

            groupProperty("resource")
        }
        [resources:rlist,toppost:toppost]

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

}

