class FilmsController < ApplicationController
before_action :authenticate_user! , only: [:new, :create, :edit, :destroy, :update]

  def index
    @films = Film.all
  end

  def show
    @film = Film.find(params[:id])
    @reviews = @film.reviews
  end

  def new
    @film = Film.new
  end

  def create
    @film = Film.new(film_params)
    @film.user = current_user
    if @film.save
      current_user.faver!(@film)
      redirect_to films_path
    else
      render :new
    end
  end

  def edit
    @film = Film.find(params[:id])
  end

  def update
    @film = Film.find(params[:id])
    if @film.update(film_params)
      redirect_to films_path, notice:"更新成功"
    else
      render :edit
    end
   end

  def destroy
    @film = Film.find(params[:id])
    @film.destroy
    redirect_to films_path, alert:"删除成功"
  end

  def favor
    @film = Film.find(params[:id])

    if !current_user.is_favored?(@film)
      current_user.favor!(@film)
      flash[:notice] = "收藏成功!"
    else
      flash[:warning] = "你已经收藏了！"
    end

    redirect_to film_path(@film)
  end

  def dislike
    @film = Film.find(params[:id])

    if current_user.is_favored?(@film)
      current_user.dislike!(@film)
      flash[:alert] = "已经取消收藏！"
    else
      flash[:warning] = "你还没有收藏！"
    end

    redirect_to film_path(@film)

  end

  private

  def film_params
    params.require(:film).permit(:title, :description)
  end
end
