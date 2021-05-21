class BorrowsController < ApplicationController
    before_action :find_book, only: [:new, :edit]
    before_action :find_borrow, only: [:edit, :update, :approve, :deny, :destroy]
    before_action :require_current_user
   
    def index
        @borrows = Borrow.all
    end    


    def new
        @borrow = @book.borrows.new()
    end
   
    def create
        @borrow = Borrow.new(borrow_params)
        @borrow.user = current_user
        if @borrow.save
            redirect_to current_user&.admin? ? borrows_path : book_path(@borrow.book)
        else
            render new
        end
    
    end

    def edit
       
    end

    def update
        if @borrow.update(borrow.params)
            redirect_to current_user&.admin? ? borrows_path : book_path(@borrow.book)
        else
            render 'edit'
        end
    end

    def approve
        @borrow.update(status: :approved)
        redirect_to borrows_path
    end
    
    def deny
        @borrow.update(status: :denied)
        redirect_to borrows_path
    end  

    def destroy
        @borrow.destroy
        redirect_to book_path(@book)
    end

    def return
        @book = Book.find(params[:id])
        invalid_return = false
        if @book.destroy && (@book.user_id != current_user.id)
            invalid_return = true
        end
        @book.destroy = false
        @book.user_id = nil
        if !invalid_return && @book.save!
            redirect_to @book, notice: 'Book was successfully returned.'
        else
            redirect_to root_path notice:  "Invalid Action!"
        end	
    end

    

    private

    def borrow_params
        params.require(:borrow).permit(:start_date, :end_date, :comment, :user_id, :book_id)
    end

    def find_book
        @book = Book.find(params[:book_id])
    end

    def find_borrow
        @borrow = Borrow.find(params[:id])
    end

    def require_current_user
        unless current_user
            flash[:alert] = "Can't perform this operation"
            redirect_to root_path
        end
    end

    def require_admin_user
        unless current_user&.admin?
            flash[:alert] = "Can't perform this operation unless you're an Admin"
            redirect_to root_path
        end
    end    

   
end
