import linksharing.*
class BootStrap {
BootstrapService bootstrapService
    def init = { servletContext ->
bootstrapService.init()
    }
    def destroy = {
    }
   

}

