class BooksController < ApplicationController
    before_action :find_book, only: [:show, :edit, :update, :destroy]
    before_action :require_admin_user, only: [:edit, :create, :update, :destroy]

    def index
        if params[:search]
            search_books
        end
        if params[:category].blank?
            @books = Book.paginate(page: params[:page], per_page: 8).order('created_at DESC')
        else
            @category_id = Category.find_by(name: params[:category]).id
            @books = Book.where(:category_id => @category_id).order('created_at DESC')
        end
    end

    def new
        @book =  Book.new
        @Categories = Category.all.map{ |c| [c.name, c.id] }
    end

    def show
        @book = Book.find(params[:id])
    end
    
   

    def create
        @book = Book.new(book_params)
        
        if @book.save
            redirect_to root_path
        else
            flash[:error] = @book.errors.full_messages.join(", ")
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

    def search_books
        if @book = Book.all.find{|book| book.author.include?(params[:search])}
            redirect_to book_path(@book)
        end
    end




    private
    def book_params
        params.require(:book).permit(:title, :description, :author, :category_id, :book_img)
    end

    def find_book
        @book = Book.find(params[:id])
    end

    def require_admin_user
        unless current_user && current_user.admin?
            flash[:alert] = "Can't perform this operation"
            redirect_to root_path
        end
    end
end
