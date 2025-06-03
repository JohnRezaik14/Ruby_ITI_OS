class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_article, only: %i[show edit update destroy report]
  before_action :authorize_user!, only: %i[edit update destroy]

  # GET /articles
  def index
    @articles = Article.published.includes(:user).order(created_at: :desc)
  end

  # GET /articles/1
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = current_user.articles.build(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy!
    respond_to do |format|
      format.html { redirect_to articles_path, status: :see_other, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /articles/1/report
  def report
    if @article.user != current_user
      @article.increment!(:reports_count)
      # Archiving handled in model callback
      flash[:notice] = "Article reported."
    else
      flash[:alert] = "You cannot report your own article."
    end
    redirect_to articles_path
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def authorize_user!
      redirect_to articles_path, alert: "Not authorized." unless @article.user == current_user
    end

    def article_params
      params.require(:article).permit(:body, :image)
    end
end
