package linksharing

class ApplicationFilters {

    def filters = {
        all(controller:"login|assets", action: 'index|loginHandler|register|forgot' ,invert:"true") {
            before = {
                println("In Filter :: "+params)
                String user=session["userName"]
                /* if (!session["user_id"] && !actionName.equals('index')) {
                     println("Going to redirect from filter...")
                     redirect(controller:'login',action: 'index')
                     return false
                 }*/

                if(user==null){
                    println("User not found in session :: "+user)
                    flash.message="Please Login."
                    redirect(controller: 'login',action: 'index')
                    return false
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
