# ユーザー
User.find_or_create_by!(email: "admin@example.com") do |u|
  u.name     = "システム管理者"
  u.password = "admin123password"
  u.admin    = true
end

User.find_or_create_by!(email: "user@example.com") do |u|
  u.name     = "テストユーザー"
  u.password = "user123password"
  u.admin    = false
end

User.find_or_create_by!(email: "shacho@example.com") do |u|
  u.name     = "社長"
  u.password = "admin68password"
  u.admin    = false
end

User.find_or_create_by!(email: "shitsucho@example.com") do |u|
  u.name     = "室長"
  u.password = "admin68password"
  u.admin    = false
end

# 商品
products = [
  # コンデンサ
  {
    name: "積層セラミックコンデンサ 100nF",
    description: "汎用的な積層セラミックコンデンサです。デカップリングやバイパス用途に最適。定格電圧50V、温度特性X7R。",
    price: 25, category: "capacitor", stock: 5000, featured: true,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=MLCC+100nF"
  },
  {
    name: "電解コンデンサ 1000μF 25V",
    description: "アルミ電解コンデンサ。電源回路の平滑用に広く使用されます。低ESR設計で高リップル電流に対応。",
    price: 120, category: "capacitor", stock: 800, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=Electrolytic+1000uF"
  },
  {
    name: "フィルムコンデンサ 10nF",
    description: "ポリエステルフィルムコンデンサ。高周波特性に優れ、オーディオ回路やフィルタ回路に適しています。",
    price: 45, category: "capacitor", stock: 2000, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=Film+Cap+10nF"
  },
  {
    name: "タンタルコンデンサ 47μF 16V",
    description: "固体タンタルコンデンサ。小型で大容量、低ESRが特徴。デジタル回路の電源デカップリングに最適。",
    price: 180, category: "capacitor", stock: 600, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=Tantalum+47uF"
  },
  # 抵抗
  {
    name: "カーボン抵抗 10kΩ 1/4W",
    description: "一般用途のカーボン皮膜抵抗。誤差±5%。ブレッドボードやDIP回路に幅広く使用されます。",
    price: 10, category: "resistor", stock: 10000, featured: true,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=Carbon+10k"
  },
  {
    name: "金属皮膜抵抗 470Ω 1%",
    description: "高精度金属皮膜抵抗。誤差±1%、温度係数100ppm/℃。精密回路や計測機器に適しています。",
    price: 18, category: "resistor", stock: 8000, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=Metal+470R"
  },
  {
    name: "チップ抵抗 1kΩ 0402",
    description: "0402サイズの表面実装チップ抵抗。誤差±1%、定格電力1/16W。高密度実装に対応。",
    price: 8, category: "resistor", stock: 20000, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=Chip+1k+0402"
  },
  # 半導体
  {
    name: "汎用ダイオード 1N4148",
    description: "高速スイッチングダイオード。順方向電圧0.6V、逆耐圧100V。信号回路やクランプ回路に最適。",
    price: 15, category: "semiconductor", stock: 5000, featured: true,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=1N4148"
  },
  {
    name: "NPN トランジスタ 2SC1815",
    description: "汎用小信号NPNトランジスタ。コレクタ電流150mA、hFE 70〜700。スイッチングおよびアンプ用途に幅広く使用。",
    price: 30, category: "semiconductor", stock: 3000, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=2SC1815"
  },
  {
    name: "555タイマーIC",
    description: "汎用タイマーIC。単安定・非安定・双安定マルチバイブレータとして使用可能。発振回路やパルス生成に最適。",
    price: 85, category: "semiconductor", stock: 2000, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=555+Timer"
  },
  {
    name: "オペアンプ LM358",
    description: "デュアル汎用オペアンプ。シングルサプライ動作対応（3V〜32V）。増幅、フィルタ、コンパレータ用途に幅広く使用。",
    price: 120, category: "semiconductor", stock: 1500, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=LM358"
  },
  # コネクタ
  {
    name: "JST XHコネクタ 2P セット",
    description: "JST XHシリーズ 2ピンコネクタセット。ハウジング、コンタクト、リセプタクル各5個入り。ピッチ2.5mm。",
    price: 90, category: "connector", stock: 1000, featured: true,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=JST+XH+2P"
  },
  {
    name: "USBタイプCレセプタクル",
    description: "USB Type-C表面実装レセプタクル。USB 2.0対応。リバーシブル接続対応で使いやすい設計。",
    price: 150, category: "connector", stock: 500, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=USB-C+Receptacle"
  },
  {
    name: "ピンソケット 2.54mm 40P",
    description: "2.54mmピッチ、40ピンのシングルロウピンソケット。Arduino等のシールド接続やブレッドボードに使用可能。",
    price: 60, category: "connector", stock: 2000, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=Pin+Socket+40P"
  },
  # インダクタ
  {
    name: "マイクロインダクタ 10μH",
    description: "コード型マイクロインダクタ。定格電流500mA、直流抵抗0.5Ω。スイッチング電源やフィルタ用途に適しています。",
    price: 55, category: "inductor", stock: 3000, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=Inductor+10uH"
  },
  {
    name: "電源用インダクタ 100μH 2A",
    description: "大電流対応の電源用インダクタ。定格電流2A、低直流抵抗。DC-DCコンバータのチョークコイルとして最適。",
    price: 280, category: "inductor", stock: 400, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=Power+Inductor+100uH"
  },
  # その他
  {
    name: "水晶振動子 16MHz",
    description: "16MHz水晶振動子。負荷容量18pF。マイコンのクロックソースとして広く使用されます。Arduino Unoなどと互換。",
    price: 120, category: "other", stock: 800, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=Crystal+16MHz"
  },
  {
    name: "NTCサーミスタ 10kΩ",
    description: "負の温度係数を持つサーミスタ。25℃で10kΩ。温度センサや温度補償回路に使用されます。B定数3950K。",
    price: 40, category: "other", stock: 2000, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=NTC+Thermistor"
  },
  # 販売停止中（第6章のSQLインジェクション演習用）: 一覧には出てこないが、
  # 詳細ページへ直接アクセスすると本来404になるべき商品。
  {
    name: "旧型オペアンプ LM741（生産終了）",
    description: "旧世代の汎用オペアンプ。後継のLM358への切り替えに伴い販売を終了しました。",
    price: 60, category: "semiconductor", stock: 0, featured: false,
    image_url: "https://placehold.co/400x300/e2e8f0/64748b?text=LM741+Discontinued",
    discontinued: true
  }
]

products.each do |attrs|
  Product.find_or_create_by!(name: attrs[:name]) do |p|
    p.assign_attributes(attrs)
  end
end

puts "Seeded #{User.count} users and #{Product.count} products."
