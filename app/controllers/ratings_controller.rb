class RatingsController < ApplicationController
  before_filter :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def create
    @article = Article.find(params[:article_id])
    @rating = @article.ratings.build(params[:rating])
    @rating.user = current_user

    respond_to do |format|
      if @article.state > 2
        if @rating.save
          format.html { redirect_to(@article, :notice => 'Thank you for rating this article!') }
        else
          format.html { redirect_to(@article, :notice => 'There was an error saving your rating.') }
        end
      else
        format.html { redirect_to(@article, :notice => 'Rating are limited to published articles only.') }
      end
    end
  end

  def update
    @rating = current_user.ratings.find(params[:id])
    @article = Article.find(params[:article_id])

    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        format.html { redirect_to(@article, :notice => 'Thank you for updating your rating!') }
      else
        format.html { redirect_to(@article, :notice => 'There was an error saving your rating.') }
      end
    end
  end

  def destroy
    @rating = current_user.ratings.find(params[:id])
    @article = Article.find(params[:article_id])

    @rating.destroy

    respond_to do |format|
      format.html { redirect_to @article }
    end
  end

end
