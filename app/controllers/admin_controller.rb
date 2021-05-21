class AdminController < ApplicationController
    
    before_action :require_admin_user

    def index
        @books = Book.all    

        @borrows = Borrow.all
    end

    def show
        @borrow = Borrow.find(params[:id])
    end
        



    def blacklist
        @user = User.all
        unless @borrow.user_id.returned
            
        

    end
    def show_user
        @user = user.all
    end

    private


    

    def require_admin_user
        unless current_user.admin?
            flash[:alert] = "Can't perform this operation"
            redirect_to root_path
        end
    end
end
