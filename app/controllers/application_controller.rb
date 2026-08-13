class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # 新規登録時に name パラメータを許可する（Devise）
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # 新規登録フォームから name を受け取れるようにする。
  # admin など権限に関わる属性はここに追加しないこと。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # ログイン後のリダイレクト先。
  #
  # 脆弱性を含まないバージョン（安全・参考用）:
  # redirect_to パラメータを Rails の url_from で検証し、同一ホスト内のみ許可する。
  # これにより、ログインURLに細工した外部URLへ遷移させるオープンリダイレクトを防ぐ。
  def after_sign_in_path_for(resource)
    url_from(params[:redirect_to]) || stored_location_for(resource) || super
  end

  # 第9章: オープンリダイレクト:
  # redirect_to パラメータの中身を検証せずそのまま遷移先として使ってしまうと、
  # ログインURLに外部サイトを指定されたとき、ログイン成功後にその外部サイトへ
  # 誘導されてしまう（config/application.rbでaction_on_open_redirectも
  # 緩めてしまうと、Rails標準の安全機構にも守られなくなる）。
  #
  # def after_sign_in_path_for(resource)
  #   params[:redirect_to].presence || stored_location_for(resource) || super
  # end

  private

  def authenticate_admin!
    return if current_user&.admin?

    redirect_to root_path, alert: "管理者権限が必要です。"
  end

  def cart
    session[:cart] ||= {}
  end
  helper_method :cart

  # セッションのカートを Cart ドメインオブジェクトとして取得する。
  def current_cart
    Cart.from_session(cart)
  end
  helper_method :current_cart

  def cart_item_count
    cart.values.sum
  end
  helper_method :cart_item_count
end
