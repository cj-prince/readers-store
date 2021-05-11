class AdminController < ApplicationController
    
    before_action :require_admin_user

    def index
        @books = Book.all    

        @borrows = Borrow.all
    end

    def show
        @borrow = Borrow.find(params[:id])
    end

    def approved
        @borrow.book_id = @book.id
        @borrow.user_id = current_user.id
        
    end

    def blacklist
        
    end

    private


    

    def require_admin_user
        unless current_user.admin?
            flash[:alert] = "Can't perform this operation"
            redirect_to root_path
        end
    end
end
