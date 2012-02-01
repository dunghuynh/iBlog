class ArticlesController < ApplicationController
  # only index and show are accessible for non-authenticated users
  before_filter :authenticate_user!, :except => [:index, :show, :featured]
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.where(:state => ['3', '4'])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  def featured
    @articles = Article.where(:state => ['4'])

    respond_to do |format|
      format.html { render 'index'}
      format.json { render json: @articles }
    end
  end

  def myarticles
    @myarticles = current_user.articles.all
    respond_to do |format|
      format.html
      format.json { render json: @myarticles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = current_user.articles.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = current_user.articles.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = current_user.articles.find(params[:id])

    if @article.state > 2
      params[:article].delete(:title)
      params[:article].delete(:teaser)
    end

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = current_user.articles.find(params[:id])

    # only draft, submitted or rejected articles can be deleted by the user
    if @article.state < 3
      @article.destroy
    else
      flash[:error] = 'The article could not be deleted.'
    end

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :ok }
    end
  end

  def submit
    @article = current_user.articles.find(params[:id])

    # submit only if article is currently in draft or rejected state
    if [0,2].include?(@article.state)
      @article.state = 1
      @article.submitted = Time.now

      if @article.save
        flash[:notice] = 'Your article was successfully submitted for approval.'
      else
        flash[:error] = 'There was an error while submitting your article.'
      end
    else
      flash[:error] = 'This article can not be submitted.'
    end

    respond_to do |format|
      format.html { redirect_to(:action => 'myarticles') }
      format.json { head :ok }
    end
  end

  protected
    def record_not_found
      flash[:error] = 'The article you requested could not be found.'
      redirect_to error_404_url
    end
end
