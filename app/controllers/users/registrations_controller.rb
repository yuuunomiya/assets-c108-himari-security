class Users::RegistrationsController < Devise::RegistrationsController
  # 脆弱性を含まないバージョン（安全・参考用）:
  # 退会は Devise 標準の registration_path への DELETE（button_to + CSRFトークン）で行う。
  # 特にコードなし。

  # 第7章: CSRF演習用（vuln/ch07-csrfブランチで有効化）：
  # 「確認ダイアログが面倒」という理由だけで、退会処理をGETリクエストで
  # 実行できるようにしてしまうと、RailsのCSRFトークン検証は
  # 標準でGETを対象外としているため、skip_before_actionすら書かずに
  # 検証をすり抜けてしまう。さらにSameSite=Lax Cookieも、トップレベルの
  # GETナビゲーションにはCookieを送ってしまうため防御にならない。
  #
  # before_action :authenticate_user!, only: [:quick_delete]
  #
  # def quick_delete
  #   resource = current_user
  #   resource.destroy
  #   sign_out(resource)
  #
  #   redirect_to root_path, notice: "退会が完了しました。ご利用ありがとうございました。"
  # end
end
