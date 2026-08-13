module ProductsHelper
  # 検索結果の見出しを組み立てる
  def search_result_heading(query, category)
    parts = []
    parts << "「#{query}」" if query.present?
    parts << Product::CATEGORY_LABELS[category] if category.present?

    # 脆弱性を含まないバージョン（安全・参考用）:
    # Railsの<%= %>による自動エスケープに任せる場合は、
    # .html_safeを呼ばずに通常の文字列としてそのまま返せばよい。
    "#{parts.join(' / ')}の検索結果"

    # 第5章: XSS:
    # 検索キーワードをカギカッコで装飾して見せたかったために .html_safe を呼び、
    # 自動エスケープを無効化してしまっている。
    # この結果、params[:query]に含まれるHTMLタグやスクリプトが
    # そのままブラウザ上で解釈・実行されてしまう（反射型XSS）。
    #
    # "#{parts.join(' / ')}の検索結果".html_safe
  end
end
