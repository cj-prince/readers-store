class BorrowsController < ApplicationController
    before_action :find_book
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

    private

    def borrow_params
        params.require(:borrow).permit(:start_date, :end_date, :comment)
    end

    def find_book
        @book = Book.find(params[:book_id])
    end
end
