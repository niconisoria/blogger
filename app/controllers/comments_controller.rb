class CommentsController < ApplicationController
    include CommentsHelper

    before_action :require_login, except: [:create]

    def create
        @comment = Comment.new(comment_params)
        @comment.article_id = params[:article_id]
        if @comment.save
          flash[:success] = "Comment successfully created"
          redirect_to article_path(@comment.article)
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end

end
