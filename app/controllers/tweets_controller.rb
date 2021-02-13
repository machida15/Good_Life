class TweetsController < ApplicationController

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    @tweet.save
    redirect_to tweets_path
  end

  def index
    @tweets = Tweet.page(params[:page]).reverse_order
    # @user = User.find(params[:id])
  end

  def show
    @tweet = Tweet.find(params[:id])
    @tweet_comment = TweetComment.new
  end

  def edit
     @tweet = Tweet.find(params[:id])
     if @tweet.user != current_user
      redirect_to tweet_path, alert: '不正なアクセスです。'
     end
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet), notice: "レシピを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:image, :body)
  end

end
