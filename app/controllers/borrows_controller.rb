class BorrowsController < ApplicationController
    before_action :find_book
    before_action :find_borrow, only: [:edit, :update, :destroy]
    before_action :require_current_user
   



    def new
        @borrow = Borrow.new
       
    end
   
    def create
    
        @borrow = Borrow.new(borrow_params)
        @borrow.book_id = @book.id
        @borrow.user_id = current_user.id
        if @borrow.save
            redirect_to book_path(@book)
        else
            render new
        end
    
    end

    def edit
       
    end

    def update
       

        if @borrow.update(borrow.params)
            redirect_to book_path(@book)
        else
            render 'edit'
        end
    end

    def destroy
        @borrow.destroy
        redirect_to book_path(@book)
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
        unless user_signed_in? && current_user
            flash[:alert] = "Can't perform this operation"
            redirect_to root_path
        end
    end

   
end
