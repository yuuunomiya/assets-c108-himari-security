class User < ApplicationRecord
  # 脆弱性を含まないバージョン（安全・参考用）:
  # :lockable を含めると、config/initializers/devise.rbのmaximum_attempts
  # （既定10回）を超えて連続でログインに失敗したアカウントを自動的にロックし、
  # ブルートフォース攻撃（パスワードの総当たり）を大幅に困難にする。
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable, :lockable

  # 第9章: ブルートフォース攻撃（現在有効）:
  # :lockable を外してしまっているため、ログイン試行の回数に一切制限がない。
  # 攻撃者は同じメールアドレスに対してパスワードを無制限に総当たりできてしまう。
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy

  def admin?
    admin
  end
end
