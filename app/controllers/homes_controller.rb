class HomesController < ApplicationController

  def index
  end

  def about
  end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'サンプル'
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to tweets_path, notice: 'ゲストユーザーとしてログインしました。'
  end

end
