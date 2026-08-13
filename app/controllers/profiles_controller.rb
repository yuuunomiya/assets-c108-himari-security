class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(profile_params)
      redirect_to profile_path, notice: "プロフィールを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # 脆弱性を含まないバージョン（安全・参考用）:
  # 一般ユーザーが自分で変更してよい属性だけを許可する。
  #
  # def profile_params
  #   params.require(:user).permit(:name, :email)
  # end

  # 第8章: マスアサインメント:
  # admin をStrong Parametersで許可してしまっているため、フォームに
  # 存在しないuser[admin]パラメータを追加して送信するだけで、
  # 自分自身を管理者へ昇格できてしまう。
  def profile_params
    params.require(:user).permit(:name, :email, :admin)
  end
end
