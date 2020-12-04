work = Category.create(name: "仕事・仕事術")
work_1 = work.children.create(name: "効率")
work_1.children.create([{name: "ツール"},{name: "マインド"},{name: "その他"}])
work_2 = work.children.create(name: "IT・メディア")
work_2.children.create([{name: "通信"},{name: "IT"},{name: "ソフトウェア"},{name: "インターネット"},{name: "テレビ"},{name: "その他"}])
work_3 = work.children.create(name: "時短術")
work_3.children.create([{name: "道具"},{name: "考え方"},{name: "その他"}])

# 資格・検定
licence = Category.create(name: "資格・検定")
licence_1 = licence.children.create(name: "仕事")
licence_1.children.create([{name: "マーケティング"},{name: "ビジネス"},{name: "その他"}])
licence_2 = licence.children.create(name: "趣味")
licence_2.children.create([{name: "料理"},{name: "ライフスタイル"},{name: "その他"}])

# 道具・材料
tools = Category.create(name: "道具・材料")
tools_1 = tools.children.create(name: "仕事")
tools_1.children.create([{name: "スマホ"},{name: "タブレット"},{name: "その他"}])
tools_2 = tools.children.create(name: "趣味")
tools_2.children.create([{name: "アウトドア"},{name: "インドア"},{name: "その他"}])

# 本・音楽・ゲーム
book_music_game = Category.create(name: "本・音楽・ゲーム")
book_music_game_1 = book_music_game.children.create(name: "本")
book_music_game_1.children.create([{name: "文学/小説"},{name: "人文/社会"},{name: "ノンフィクション/教養"},{name: "地図/旅行ガイド"},{name: "ビジネス/経済"},{name: "健康/医学"},{name: "コンピュータ/IT"},{name: "趣味/スポーツ/実用"},{name: "住まい/暮らし/子育て"},{name: "アート/エンタメ"},{name: "洋書"},{name: "絵本"},{name: "参考書"},{name: "その他"}])
book_music_game_2 = book_music_game.children.create(name: "漫画")
book_music_game_2.children.create([{name: "全巻セット"},{name: "少年漫画"},{name: "少女漫画"},{name: "青年漫画"},{name: "女性漫画"},{name: "同人誌"},{name: "その他"}])
book_music_game_3 = book_music_game.children.create(name: "CD")
book_music_game_3.children.create([{name: "邦楽"},{name: "洋楽"},{name: "アニメ"},{name: "クラシック"},{name: "K-POP/アジア"},{name: "キッズ/ファミリー"},{name: "その他"}])
book_music_game_4 = book_music_game.children.create(name: "DVD/ブルーレイ")
book_music_game_4.children.create([{name: "外国映画"},{name: "日本映画"},{name: "アニメ"},{name: "TVドラマ"},{name: "ミュージック"},{name: "お笑い/バラエティ"},{name: "スポーツ/フィットネス"},{name: "キッズ/ファミリー"},{name: "その他"}])
book_music_game_5 = book_music_game.children.create(name: "レコード")
book_music_game_5.children.create([{name: "邦楽"},{name: "洋楽"},{name: "その他"}])
book_music_game_6 = book_music_game.children.create(name: "テレビゲーム")
book_music_game_6.children.create([{name: "家庭用ゲーム本体"},{name: "家庭用ゲームソフト"},{name: "携帯用ゲーム本体"},{name: "携帯用ゲームソフト"},{name: "PCゲーム"},{name: "その他"}])

# 健康
health = Category.create(name: "健康")
health_1 = health.children.create(name: "運動")
health_1.children.create([{name: "ランニング"},{name: "ストレッチ"},{name: "その他"}])
health_2 = health.children.create(name: "食生活")
health_2.children.create([{name: "お肉"},{name: "野菜"},{name: "魚"},{name: "その他"}])

# 料理
cook = Category.create(name: "料理")
cook_1 = cook.children.create(name: "和食")
cook_1.children.create([{name: "素材"},{name: "調味料"},{name: "隠し味"},{name: "その他"}])
cook_2 = cook.children.create(name: "洋食")
cook_2.children.create([{name: "素材"},{name: "調味料"},{name: "隠し味"},{name: "その他"}])

# その他
others = Category.create(name: "その他")
others_1 = others.children.create(name: "豆知識")
others_1.children.create([{name: "すべて"}])
others_2 = others.children.create(name: "その他")
others_2.children.create([{name: "すべて"}])
