# Be sure to restart your server when you modify this file.

# セッションCookieの属性を設定する。
#   httponly:  JavaScript からの document.cookie 読み取りを禁止し、XSS によるセッション窃取を緩和する
#   same_site: クロスサイトからのリクエストに Cookie を付与しない（CSRF の多層防御、第7章で体験済み）
#
# secure 属性（HTTPS でのみ Cookie を送信）はローカル開発（HTTP）では付与できないため
# ここでは指定していない。本番環境では config.force_ssl = true により secure Cookie が有効になる。
#
# 脆弱性を含まないバージョン（安全・参考用）:
#
# Rails.application.config.session_store :cookie_store,
#                                        key: "_millennium_parts_session",
#                                        httponly: true,
#                                        same_site: :lax

# 第9章: Cookie属性の設定不備（現在有効）:
# httponly を false にしてしまっているため、JavaScriptからdocument.cookieで
# セッションCookieの中身を読み取れてしまう。第5章のXSSと組み合わせると、
# 検索クエリに仕込んだスクリプトから直接セッションCookieを盗み出せてしまう。
Rails.application.config.session_store :cookie_store,
                                       key: "_millennium_parts_session",
                                       httponly: false,
                                       same_site: :lax
