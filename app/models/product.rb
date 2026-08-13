class Product < ApplicationRecord
  # 商品を削除しても注文履歴（order_items）は残す。product_id は nullify される。
  has_many :order_items, dependent: :nullify

  CATEGORIES = %w[capacitor resistor semiconductor connector inductor other].freeze

  CATEGORY_LABELS = {
    "capacitor"     => "コンデンサ",
    "resistor"      => "抵抗",
    "semiconductor" => "半導体",
    "connector"     => "コネクタ",
    "inductor"      => "インダクタ",
    "other"         => "その他"
  }.freeze

  validates :name,        presence: true
  validates :description, presence: true
  validates :price,       presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :category,    presence: true, inclusion: { in: CATEGORIES }
  validates :stock,       presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :featured, -> { where(featured: true) }
  scope :available, -> { where(discontinued: false) }
  scope :by_category, ->(cat) { where(category: cat) if cat.present? }
  scope :search, ->(query) {
    # 脆弱性を含まないバージョン（安全・参考用）:
    # プレースホルダ（:q）とsanitize_sql_likeにより、SQL文の構造とLIKE用ワイルドカードの
    # 両方が安全にエスケープされている。
    where("name ILIKE :q OR description ILIKE :q", q: "%#{sanitize_sql_like(query)}%") if query.present?

    # 第6章: SQLインジェクション:
    # 検索キーワードをプレースホルダを使わず直接SQL文字列に埋め込んでしまうと、
    # queryの中身次第でSQL文の構造そのものを書き換えられてしまう。
    #
    # where("name ILIKE '%#{query}%' OR description ILIKE '%#{query}%'") if query.present?
  }

  def category_label
    CATEGORY_LABELS[category] || category
  end

  def in_stock?
    stock > 0
  end
end
