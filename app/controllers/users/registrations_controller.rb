class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: [:quick_delete]

  # 第7章: CSRF（現在有効）：
  # 「確認ダイアログが面倒」という理由だけで、退会処理をGETリクエストで
  # 実行できるようにしてしまっている。RailsのCSRFトークン検証は
  # 標準でGETを対象外としているため、skip_before_actionすら書かずに
  # 検証をすり抜けてしまう。さらにSameSite=Lax Cookieも、トップレベルの
  # GETナビゲーションにはCookieを送ってしまうため防御にならない。
  def quick_delete
    resource = current_user
    resource.destroy
    sign_out(resource)

    redirect_to root_path, notice: "退会が完了しました。ご利用ありがとうございました。"
  end
end
