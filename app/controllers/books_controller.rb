class BooksController < ApplicationController
    before_action :find_book, only: [:show, :edit, :update, :destroy]
    before_action :require_admin_user, only: [:edit, :create, :update, :destroy]

    def index
        @books = Book.all.order('created_at DESC')
    end

    def new
        @book = Book.new
        @Categories = Category.all.map{ |c| [c.name, c.id] }
    end

    def show
    end
    
   

    def create
        @book = Book.new(book_params)
        @book.Category_id = params[:Category_id]
        if @book.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit

    end

    def update
        if @book.update(book_params)
            redirect_to book_path (@book)
        else
            render 'edit'
        end  
    end

    def destroy
        @book.destroy
        redirect_to root_path
    end

    



    private
    def book_params
        params.require(:book).permit(:title, :description, :author, :category_id)
    end

    def find_book
        @book = Book.find(params[:id])
    end
    def require_admin_user
        if current_user != current_user.admin?
            flash[:alert] = "Can't perform this operation"
            redirect_to root_path
        end
    end
end
