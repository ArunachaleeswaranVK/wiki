class ArticlesController < ApplicationController
    
    before_action :set_article, only: [:show,:edit,:update,:destroy]
    before_action :authenticate_user!, except: [:show,:index]
    
    def index
        
        if  params[:search]
            @articles = Article.search(params[:search]).order("created_at DESC")
        elsif params[:category]
            @category_id = Category.find_by(name: params[:category]).id
            @articles = Article.where(category_id: @category_id).order("created_at DESC")
        else
            @articles = Article.all.order('created_at DESC') 
        end
        
    end
    
    def show
        
    end
    
    def new
        @article = current_user.articles.build
    end
    
    def create
        @article = current_user.articles.build(article_params)
        if @article.save
            redirect_to root_path
        else
            render "new"
        end    
    end
    
    def edit
        
    end
    
    def update
        
        if @article.update(article_params)
            redirect_to @article
        else
            render "edit"
        end    
    end
    
    def destroy
        @article.destroy
        
        redirect_to root_path
    end 
    
    private
    
    def set_article
       @article = Article.find(params[:id]) 
    end    
    
    def article_params
       params.require(:article).permit(:title, :content, :category_id)
    end    
end
