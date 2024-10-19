-- MySQL dump 10.13  Distrib 5.7.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: music_share_platform
-- ------------------------------------------------------
-- Server version	5.7.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cla`
--

DROP TABLE IF EXISTS `cla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cla` (
  `hao` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cla`
--

INSERT INTO `cla` VALUES (1),(2),(3);

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_time` date DEFAULT NULL,
  `discuss_id` int(11) DEFAULT NULL,
  `message` text,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comment_discuss_1` (`discuss_id`),
  KEY `fk_comment_user_1` (`user_id`),
  CONSTRAINT `fk_comment_discuss_1` FOREIGN KEY (`discuss_id`) REFERENCES `discuss` (`id`),
  CONSTRAINT `fk_comment_user_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` VALUES (1,'2024-10-17',1,'whitout knowing what for',4),(2,'2024-10-17',1,'不太常见',1),(3,'2024-10-17',1,'关注永雏塔菲',4),(4,'2024-10-17',1,'我曾看遍人间百态纷纭，酸甜苦辣人生，\r\n化最后黄土白骨一捧。\r\n人啊 总在失去之时才 珍惜曾拥有的种种，\r\n叹大梦一场空。',4);

--
-- Table structure for table `comment_like`
--

DROP TABLE IF EXISTS `comment_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment_like` (
  `user_id` int(11) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  UNIQUE KEY `unique_discuss_user` (`comment_id`,`user_id`),
  KEY `fk_comment_like_user_1` (`user_id`),
  CONSTRAINT `fk_comment_like_comment_1` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`),
  CONSTRAINT `fk_comment_like_user_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_like`
--

INSERT INTO `comment_like` VALUES (1,1),(4,2),(4,4);

--
-- Table structure for table `discuss`
--

DROP TABLE IF EXISTS `discuss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discuss` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `discuss_img` text,
  `discuss_time` date DEFAULT NULL,
  `discuss_main` text,
  `publicer_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_discuss_user_1` (`publicer_id`),
  CONSTRAINT `fk_discuss_user_1` FOREIGN KEY (`publicer_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discuss`
--

INSERT INTO `discuss` VALUES (1,'这是第一个话题','/files/1729061510683.jpg','2024-10-16','在一个遥远的地方，有一座美丽的山峰，山峰上长满了各种奇怪的树木。这些树木有着五彩斑斓的叶子，每当微风吹过，树叶就会发出悦耳的声音。山脚下有一条清澈的小溪，溪水潺潺流淌，仿佛在诉说着古老的故事。\n                    <br>\n                    小溪边住着一位老者，他每天都会来到溪边垂钓。他的鱼竿上挂着一条金色的鱼线，每当鱼儿咬钩时，鱼线就会闪烁出耀眼的光芒。老者的鱼篓里装满了各种奇异的鱼，有的鱼身上长满了彩色的斑点，有的鱼尾巴像彩虹一样美丽。\n                    <br>\n                    有一天，一只小松鼠跑到了老者的身边，它好奇地看着老者钓鱼。老者笑了笑，从鱼篓里拿出一条小鱼递给小松鼠。小松鼠接过鱼，高兴地跳了起来，然后迅速爬上了树梢。树上的小鸟们看到了这一幕，纷纷飞下来围观，它们叽叽喳喳地叫着，好像在议论着什么。\n                    <br>\n                    不远处的草地上，一群小兔子正在玩耍。它们蹦蹦跳跳地追逐着彼此，偶尔停下来啃食着草地上的嫩草。草地上还开着许多五颜六色的小花，花朵散发着淡淡的香气，引来了许多蝴蝶和蜜蜂。蝴蝶在花丛中翩翩起舞，蜜蜂则忙着采集花蜜。\n                    <br>\n                    突然，天空中飘来了一朵乌云，乌云遮住了阳光，天色变得阴沉起来。一阵风吹过，树叶沙沙作响，小溪里的水也变得湍急起来。老者赶紧收拾好鱼竿，带着鱼篓回到了家中。小松鼠也躲进了树洞里，小兔子们则躲进了草丛中。\n                    <br>\n                    不久后，天空中下起了大雨，雨水滴答滴答地落在屋顶上，形成了一首美妙的乐曲。雨停后，天空中出现了一道彩虹，彩虹横跨在山峰之上，显得格外壮观。小松鼠从树洞里探出头来，小兔子们也从草丛中钻了出来，它们一起欣赏着美丽的彩虹。\n                    <br>\n                    夜晚降临，月光洒在山峰上，一切都变得宁静而祥和。老者坐在家门口，看着满天的星星，心中充满了无限的感慨。他想起了年轻时的往事，那些美好的回忆如同电影一般在他的脑海中回放。他闭上眼睛，静静地享受着这份宁静。\n                    <br>\n                    第二天清晨，太阳从东方升起，金色的阳光洒在大地上，一切都显得生机勃勃。老者又来到了小溪边，开始了新的一天。小松鼠和小兔子们也出来活动了，它们在草地上嬉戏着，享受着美好的一天。\n                    <br>\n                    在这个美丽的地方，每一天都充满了奇迹和惊喜。无论是晴天还是雨天，无论是白天还是黑夜，这里的一切都充满了生机和活力。人们在这里生活得快乐而幸福，每一天都是那么美好。',4),(2,'这是第二个话题呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀','/files/1729054882248.jpg','2024-10-16','这是呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀第二个话题这是第二个话题这是第二个话题这是第二个话题这是第二个话题这是第二个话题这是第二个话题这是第二个话题这是第二个话题这是第二个话题这是第二个话题',4),(3,'这是第三个话题','/public/images/image.jpg','2024-10-18','啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊',4),(4,'这是第四个','/public/images/image.jpg','2024-10-18','一月又一月一月又一月呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀呀',4),(5,'这是第五个','/public/images/image.jpg','2024-10-18','少时诵诗书少时诵诗书是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒',4),(6,'这是第六个','/public/images/image.jpg','2024-10-18','这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个这是第六个',4);

--
-- Table structure for table `discuss_dislike`
--

DROP TABLE IF EXISTS `discuss_dislike`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discuss_dislike` (
  `discuss_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  UNIQUE KEY `unique_discuss_user` (`discuss_id`,`user_id`),
  KEY `fk_discuss_dislike_user_1` (`user_id`),
  CONSTRAINT `fk_discuss_dislike_discuss_1` FOREIGN KEY (`discuss_id`) REFERENCES `discuss` (`id`),
  CONSTRAINT `fk_discuss_dislike_user_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discuss_dislike`
--

INSERT INTO `discuss_dislike` VALUES (1,4);

--
-- Table structure for table `discuss_like`
--

DROP TABLE IF EXISTS `discuss_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discuss_like` (
  `discuss_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  UNIQUE KEY `unique_discuss_user` (`discuss_id`,`user_id`),
  KEY `fk_discuss_like_user_1` (`user_id`),
  CONSTRAINT `fk_discuss_like_discuss_1` FOREIGN KEY (`discuss_id`) REFERENCES `discuss` (`id`),
  CONSTRAINT `fk_discuss_like_user_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discuss_like`
--

INSERT INTO `discuss_like` VALUES (2,4),(4,4);

--
-- Table structure for table `songs`
--

DROP TABLE IF EXISTS `songs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `songs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `public_time` datetime DEFAULT NULL,
  `song_img` text,
  `song_name` varchar(255) DEFAULT NULL,
  `song_url` varchar(255) DEFAULT NULL,
  `ar_name` varchar(255) DEFAULT NULL,
  `lrc` text,
  `song_des` text,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_songs_user_1` (`user_id`),
  CONSTRAINT `fk_songs_user_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `songs`
--

INSERT INTO `songs` VALUES (1,'2024-10-16 10:17:09','https://p1.music.126.net/fSz_hPtCd84F3HlaZvZD5w==/109951166716430253.jpg?param=260y260','独学画伯','http://music.163.com/song/media/outer/url?id=1902537944.mp3','日高大地','作词 : 日高大地<br>作曲 : SHIDO<br>感覚で 蹴り込んだ  俺も行けるだろうか<br>正直に綴る文字が薄れかすれてきた<br>現実はどこにある  鉛筆はここにある<br>書き殴るlyric note それが俺のリアル<br>答えのある問いばかり いつも問いてきてる<br>間違いを探す神経も研いできてる<br>制限時間なんて もうとっくに切ってる<br>それでも 俺はまだマイクを握ってる<br>何よりの証明  いつまでも正面<br>ばかり向いた少年が ここにまたも挑戦<br>下降線の可能性の上で1人遊んで<br>生と性と聖と誠を背負い選手宣誓<br>決定的1点  全面的否定<br>されたとこでそれがあってこその俺の人生<br>1ページ目めくる  2ページ目綴る<br>3ページ目締める  それでこそがlyric<br>また明くる日  あいつからのkey<br>lifeならばreal  俺は俺でいい<br>見えなくなる木  消えなくなる火<br>俺韋駄天kids  お前バーゲン品<br>正体不明でありもなお歌う世界に<br>いつまで経っても 物語は欠陥品<br>one love , one peace  書き綴る意味<br>独学の直線  ブレていかないうちに<br>痛みを増す一文  細くなった真実<br>1つ2つ 3つ 攻め立ててる西軍<br>テレビの前正座して計算する限界<br>突破したボーダー その瞬間 燃えそうだ<br>墓穴掘ってボケに飛ばす言葉それはmessage<br>高揚するテンションでも心だけは冷静に<br>他人からの目線とか他人からの名声とか<br>気にしたらそこで終わり 俺の価値は俺次第<br>5秒前の事も忘れてるのに<br>もうちょっと先を欲しがってる病気<br>秒針と長針は常に紙一重<br>たまに来るチャンス  絶対に摑み取れ<br>神はもう死んだ  仮眠はもう終わりだ<br>時代の歯車が寄ってきたらまずは<br>腰を入れチャック閉め瞬きは厳禁<br>初心に振り返る  アルファベットAB<br>また明くる日  あいつからのkey<br>lifeならばreal  俺は俺でいい<br>見えなくなる木  消えなくなる火<br>俺韋駄天kids  お前バーゲン品<br>正体不明でありもなお歌う世界に<br>いつまで経っても 物語は欠陥品<br>one love , one peace  書き綴る意味<br>独学の直線  ブレていかないうちに<br>最大の魅力は 音楽に感情<br>それを声で伝える  出来てこそのart<br>ラッパーの存在が 少しずつ下がってる<br>原因作ったお前が 1番分かってるだろ<br>これ以上 俺に言わせるな<br>真剣なステージでこれ以上ニヤけるな<br>いつか来るその日のため下げっぱなの口角<br>叩き上げlocal  核心の独白<br>また明くる日  あいつからのkey<br>lifeならばreal  俺は俺でいい<br>見えなくなる木  消えなくなる火<br>俺韋駄天kids  お前バーゲン品<br>正体不明でありもなお歌う世界に<br>いつまで経っても 物語は欠陥品<br>one love , one peace  書き綴る意味<br>独学の直線  ブレていかないうちに<br>また明くる日  あいつからのkey<br>lifeならばreal  俺は俺でいい<br>見えなくなる木  消えなくなる火<br>俺韋駄天kids  お前バーゲン品<br>正体不明でありもなお歌う世界に<br>いつまで経っても 物語は欠陥品<br>one love , one peace  書き綴る意味<br>独学の直線  ブレていかないうちに<br>','以下省略200字',4),(2,'2024-10-16 11:10:45','https://p2.music.126.net/awlXZt_5TjQNsPulsCFlSg==/109951168956448367.jpg?param=260y260','繋がリー世','http://music.163.com/song/media/outer/url?id=2087103540.mp3','無骨onsalary','作词 : 無骨onsalary<br>作曲 : WELCOME脳<br>出る杭は「打たれる」なんて昔の話<br>今は「抜かれる」<br>それはまるで親知らず<br>「痛い」ってだけでほら嫌う<br>糸に必ず限りあるように<br>独りにしてほしい時も多い<br>だから鍵かける玄関<br>暇もなく繋がり合う電波<br>六畳一間が雑踏<br>孤独になれない環境<br>開くiPhone　見るかストーリー<br>部屋ン中　他人が素通り<br>してるような感覚　頭錯乱<br>人叩くバカ感情はアンジャッシュ<br>電源ぶっちぎった正午<br>だがすぐに手元、スマホが「どうもｗ」<br>おい、オレにいいねをよこせ<br>オレにいいねをよこせ<br>どれがイケてる？どれが盛れてる？<br>いいねいいねいいねいいね<br>おい、オレにフォロワーをよこせ<br>オレの生活をみんな見てくれ<br>1個じゃ足りねェサブ垢作って<br>サイコーいいね気にしてく人生<br>中学の頃にスマホゲット<br>そっから常に空にならんポケット<br>そこに違和感感じたから<br>映えねェ部屋独り詩を製造<br>けど結局やめらんねェ<br>まだ抗ってる毎日<br>だがバカげたあの頃戻りたくねェな<br>いいねの奴隷、思い返せば<br>あん時友達といても齧ったスクリーン<br>気にした写真写り<br>「会ってる時間？大切にしないｗ<br>だってどーせ後でLINEするしｗ」<br>久しく樊籠の裏に在るも<br>復た自然に反るを得た<br>明日には消える即席のアート<br>じゃないストーリー＝足跡で圧倒<br>この曲で自分を戒める<br>けどオマエにも刺さる気がしてる<br>他人事で済ますなよ<br>まあ耳、塞ぎたくなるか<br>艱難辛苦に圧し殺されど<br>自己との対話からは逃げるな<br>安いポエムで他人にシェアすんな<br>沈黙こそが人を作るんだ<br>孤独だからBeReal<br>自分信じた分がオレらの品になる<br>インスタントな繋がりはいらねェ<br>ふやけた麵じゃ腹が満たされねェ<br>写真映えする観光名所より<br>カバンの中一冊の名書<br>それ持って牧場で読書<br>まさにオレの性に合うロケーション<br>なあ「時間経つとそこに芽が<br>\"出てくる思い\"」こそが\"思い出\"だ<br>写真アップして終わりじゃなくて<br>胸にしまって育てろ<br>オレもう<br>ねェんだよいいねや暴露に興味<br>カスを非表示　やる文字通り<br>枕頭の書はカミュの『異邦人』<br>心臓、鼓動、覚悟、自尊心<br>','以下省略200字',4),(6,'2024-10-16 11:19:56','https://p1.music.126.net/cGTKkFl5qcXIDYPo7PrmDA==/109951168431655039.jpg?param=260y260','雪 Distance','http://music.163.com/song/media/outer/url?id=2026224214.mp3','Capper / 罗言 ','                                                                                                                                    <div id=\"lyric-content\" class=\"bd bd-open f-brk f-ib\" data-song-id=\"2026224214\" data-third-copy=\"false\" ,=\"\" copy-from=\"\">作词 : Capper/罗言<br>作曲 : Capper/罗言<br>编曲 : IOF<br>混音 : 刘城函<br>母带 : 张步若 @RSS<br><br>你说我自以为是<br>可怜像扑火飞蛾<br>任凭无用的勇敢将我淹没<br>这漩涡深不见底<br>蜕去勉强的外壳<br>你充满防备的样子不像我<br><br><div id=\"flag_more\" class=\"\">会不会太久<br>久到这结果<br>明明我想要却不敢对你说<br>我好想放手<br>却幻想太多<br>悲叹你不是世上另一个我<br><br>我愿把胸膛解剖<br>公开脆弱的结构<br>有在跳动的血肉<br>别再只丢我骨头<br><br>在这么冷的天<br>别离我那么远<br>再靠近我一点<br><br>可是雪啊 飘进双眼<br>看不见你皎白的谎言<br>心甘情愿囚禁在深渊<br>舔舐着伤口和刀尖<br><br>可是雪啊 飘进双眼<br>看不见你皎白的谎言<br>心甘情愿囚禁在深渊<br>烧一捧雪花做硝烟<br><br>为什么抿下嘴唇尝起来像铁锈<br>神经的恐慌和不安哪个会先走<br>我怕这沼泽死水就要将我淹没<br>求你能拉住我 就算只有几分钟<br><br>快要变成玩偶<br>可以随意玩弄<br>别管我感受<br>想要和你联手<br><br>我愿把胸膛解剖<br>公开脆弱的结构<br>有在跳动的血肉<br>别再只丢我骨头<br><br>在这么冷的天<br>别离我那么远<br>再靠近我一点<br><br>可是雪啊 飘进双眼<br>看不见你皎白的谎言<br>心甘情愿囚禁在深渊<br>舔舐着伤口和刀尖<br><br>可是雪啊 飘进双眼<br>看不见你皎白的谎言<br>心甘情愿囚禁在深渊<br>烧一捧雪花做硝烟<br></div><div class=\"crl\"><a id=\"flag_ctrl\" href=\"javascript:void(0)\" class=\"s-fc7\">收起<i class=\"u-icn u-icn-70\"></i></a></div></div>\r\n                                    \r\n                                    \r\n                                    ','                                                                                                                                   以下省略200字  \r\n\r\n课上不写                 \r\n                                    \r\n                                    ',4),(7,'2024-10-16 17:18:14','/public/images/image.jpg','精卫','http://music.163.com/song/media/outer/url?id=1951069525.mp3','30年前，50年后','                                            <div id=\"lyric-content\" class=\"bd bd-open f-brk f-ib\" data-song-id=\"1951069525\" data-third-copy=\"false\" ,=\"\" copy-from=\"\">作词 : 30年前，50年后<br>作曲 : 30年前，50年后<br>编曲 : GAXILLIC<br>（每个身体，情不自禁）<br>是现在我所有期待<br>所有的爱<br>为什么不明白<br>说的话为什么不记得<br>为什么不记得<br>（愿生命绽放再盛开）<br>你与我<br>先谈养心殿<br>后拜瀑淋身<br><div id=\"flag_more\" class=\"\">闲暇闻几页<br>臭读几篇书<br>也罢<br>至填没在大海<br>（似我的哀）<br>可它为什么不记得<br>为什么不记得<br>它到底用什么灌溉<br>用什么来爱<br>用什么方式<br>用什么去对待<br>春华是秋实模特<br>掩饰过的<br>延伸向海<br>她们总是过客<br>我猜我猜想<br>周围有伴侣生长<br>无法放弃<br>无法兑奖<br>可是她的对象<br>想给我一巴掌<br>反正我没劝退<br>梦里都是假象<br>我只是太想要份爱<br>想要份爱<br>我只是太想被好好对待<br>但是呢我心中的意义<br>难道我身上贴着过去过去<br>可是呢<br>我心中的海<br>填满不回来<br>回来<br>（流文弄我琉璃百盏死得一归相信一回）劝你相信一回<br>（用我们中国话来说是你不对（是我不对）<br>啦啦啦啦啦啦<br>混音：楚杰<br>出品：网易音乐人×青云LAB<br>网易云音乐X中国数字音乐基地 联合出品<br></div></div>\r\n                                    ','以下省略200字',4),(9,'2024-10-16 17:51:14','https://p2.music.126.net/ixIs5kkukgNYMmeDsc35_g==/29686813955450.jpg?param=130y130','天下','https://music.163.com/song/media/outer/url?id=191254.mp3','张杰','<div id=\"lyric-content\" class=\"bd bd-open f-brk f-ib\" data-song-id=\"191254\" data-third-copy=\"false\" ,=\"\" copy-from=\"\">作词 : 周毅<br>作曲 : 刘迦宁<br>烽烟起寻爱似浪淘沙<br>遇见她如春水映梨花<br>挥剑断天涯相思轻放下<br>梦中我痴痴牵挂<br>顾不顾将相王侯<br>管不管万世千秋<br>求只求爱化解<br>这万丈红尘纷乱永无休<br>爱更爱天长地久<br>要更要似水温柔<br>谁在乎谁主春秋<br><div id=\"flag_more\" class=\"\">一生有爱何惧风飞沙<br>悲白发留不住芳华<br>抛去江山如画换她笑面如花<br>抵过这一生空牵挂<br>心若无怨爱恨也随她<br>天地大情路永无涯<br>只为她袖手天下<br>顾不顾将相王侯<br>管不管万世千秋<br>求只求爱化解<br>这万丈红尘纷乱永无休<br>爱更爱天长地久<br>要更要似水温柔<br>谁在乎谁主春秋<br>一生有爱何惧风飞沙<br>悲白发留不住芳华<br>抛去江山如画换她笑面如花<br>抵过这一生空牵挂<br>心若无怨爱恨也随她<br>天地大情路永无涯<br>只为她袖手天下<br>一生有爱何惧风飞沙<br>悲白发留不住芳华<br>抛去江山如画换她笑面如花<br>抵过这一生空牵挂<br>心若无怨爱恨也随她<br>天地大情路永无涯<br>只为她袖手天下<br>烽烟起寻爱似浪淘沙<br>遇见她如春水映梨花<br>挥剑断天涯相思轻放下<br>梦中我痴痴牵挂<br></div><div class=\"crl\"><a id=\"flag_ctrl\" href=\"javascript:void(0)\" class=\"s-fc7\">收起<i class=\"u-icn u-icn-70\"></i></a></div></div>','省略500字',4),(10,'2024-10-16 17:51:14','https://p2.music.126.net/xUAfdMHdXhu3BmO4g8nOYA==/109951163573311341.jpg?param=130y130','出山','https://music.163.com/song/media/outer/url?id=1313354324.mp3','花粥','<div id=\"lyric-content\" class=\"bd bd-open f-brk f-ib\" data-song-id=\"1313354324\" data-third-copy=\"false\" ,=\"\" copy-from=\"\">作词 : 花粥<br>作曲 : 花粥<br>制作人 : 花粥<br><br>在夜半三更过天桥从来不敢回头看<br>白日里是车水马龙此时脚下是忘川<br>我独自走过半山腰山间野狗来作伴<br>层林尽染百舸流秋风吹过鬼门关<br>一瞬三年五载 品粗茶 食淡饭<br>六界八荒四海 无人与我来叫板<br>人间荒唐古怪 竹林外 有书斋<br>匿于此地畅快 偏来者不善善者不来<br>是我装模作样在瞎掰<br><div id=\"flag_more\" class=\"\">还是他们本就心怀鬼胎<br>有人不知悔改 迷雾中混淆黑白<br>在情怀里市侩 旁人不敢来拆穿<br>看似时来运转 实则在顶风作案<br>曲终又人散 这一出还有谁在围观<br>在凡尘修炼二十载听闻水能滴石穿<br>帝王豪杰风云变幻敌不过桑田沧海<br>我不关心谁的江山只眷恋两小无猜<br>兴风作浪不稀罕只身固守峨眉山<br>一瞬三年五载 品粗茶 食淡饭<br>六界八荒四海 无人与我来叫板<br>人间荒唐古怪 竹林外 有书斋<br>匿于此地畅快 偏来者不善善者不来<br>是我装模作样在瞎猜<br>还是他们本就心怀鬼胎<br>有人不知悔改 迷雾中混淆黑白<br>在情怀里市侩 旁人不敢来拆穿<br>看似时来运转 实则在顶风作案<br>待曲终又人散 这一出还有谁在围观<br>静悄悄配唠唠叨叨<br>随便瞧瞧我凑凑热闹<br>客串也别太潦草<br>吃的生蚝要蘸个酱料<br>悄悄你唠唠叨叨<br>随便瞧瞧你凑的热闹<br>听到你做个记号<br>请装进书包别四处招摇<br>有人迷途知返<br>便是苦尽甘来<br>一瞬三年五载<br>这曲终又人散<br><br>合作音乐人：王胜娚<br>音乐制作：BachBeats<br>录音师：种旭<br>混音／母带处理：钻石狗音乐工作室（北京）<br>专辑封面设计：姜小海<br></div><div class=\"crl\"><a id=\"flag_ctrl\" href=\"javascript:void(0)\" class=\"s-fc7\">收起<i class=\"u-icn u-icn-70\"></i></a></div></div>','省略500字',4),(11,'2024-10-16 17:58:14','https://p1.music.126.net/I0pSpFUrHAU1rVbK_wxDAg==/17799993742328340.jpg?param=130y130','轮回','https://music.163.com/song/media/outer/url?id=416384874.mp3','呦猫UNEKO','<div id=\"lyric-content\" class=\"bd bd-open f-brk f-ib\" data-song-id=\"416384874\" data-third-copy=\"false\" ,=\"\" copy-from=\"\">作词 : 浓缩排骨<br>作曲 : 我是爱音乐的徐梦圆<br>繁星坠落<br>划破天空星辰在灼烧<br>因果之间<br>劫后成灰粉饰了谁的祈祷<br>生活天旋地转<br>突如其来的已知、未知、谜团在绕<br>风在笑<br>埋在时间的犄角<br>藏在阴影的误导<br>误以太平的世界却诸行无道<br>万物 苍老<br><div id=\"flag_more\" class=\"f-hide\">不改不朽的容貌<br>谁难过 谁对错<br>由不得谁说分晓<br>逐鹿 王朝<br>由天而落的城堡<br>迷雾重重<br>将过往都缠绕<br>赞扬 歌颂 祈祷<br>传说幻灭<br>真相 如此 可笑<br>云火烧<br>善恶 生死 哭号<br>所谓正邪之间勾心斗角<br>人道 世道 天道<br>六道轮回 不为人知 不为人晓<br>雀跃于刀尖舞蹈<br>繁星坠落<br>划破天空星辰在灼烧<br>因果之间<br>劫后成灰粉饰了谁的祈祷<br>生活天旋地转<br>突如其来的已知、未知、谜团在绕<br>风在笑<br>埋在时间的犄角<br>藏在阴影的误导<br>误以太平的世界却诸行无道<br>万物 苍老<br>不改不朽的容貌<br>谁难过 谁对错<br>由不得谁说分晓<br>逐鹿 王朝<br>由天而落的城堡<br>迷雾重重<br>将过往都缠绕<br>赞扬 歌颂 祈祷<br>传说幻灭<br>真相 如此 可笑<br>云火烧<br>善恶 生死 哭号<br>所谓正邪之间勾心斗角<br>人道 世道 天道<br>六道轮回 不为人知 不为人晓<br>雀跃于刀尖舞蹈<br></div><div class=\"crl\"><a id=\"flag_ctrl\" href=\"javascript:void(0)\" class=\"s-fc7\">展开<i class=\"u-icn u-icn-69\"></i></a></div></div>','省略500字',4),(12,'2024-10-16 18:18:14','https://p1.music.126.net/Ro0p-IZzFMmQ_nwW9yuNzg==/109951163265343789.jpg?param=130y130','旁观者S的独白 ','https://music.163.com/song/media/outer/url?id=555261881.mp3','玄觞','<div id=\"lyric-content\" class=\"bd bd-open f-brk f-ib\" data-song-id=\"555261881\" data-third-copy=\"false\" ,=\"\" copy-from=\"\">作词 : 素昭<br>作曲 : 江楼<br>编曲：简吟<br>和声编唱：阿南sara【辣耳朵工作室】<br>题字：零雨其蒙蒙<br>混音：Mr鱼<br>策划：苏别久【十年言心】<br>美工：竹醉【十年言心】<br>pver：南MISAO<br>曲绘：影子【弧光工作室】<br>鸣谢：果子狸<br><br><br><div id=\"flag_more\" class=\"f-hide\">人们在古老的壁画上，<br>默默地永生，<br>默默地死去。<br><br>沉睡在古老壁画上，<br>是死去的时代信仰。<br>他也曾渴望过寻常，<br>看情人眼中月光，<br>白鸽落在摇篮，肩上停诗行。<br><br>匆匆 来敬 南国 坟冢，<br>冷酒 洒满 北地 隆冬。<br>寒鸦 撕裂 不朽 传颂，<br>潦倒 之人 谁敢 称梦？<br><br>她又看见某个安宁黄昏，看见林下春风，<br>像每个儿时纯粹的梦。<br>人啊 总在老去之时才 遗憾这仓促的一生，<br>和遗憾的初衷。<br><br><br><br>苏醒在古老壁画上，<br>是岁月的更迭沧桑。<br>在高楼林立下流浪，<br>叹小城世态炎凉，<br>千百万种活法，生命的模样：<br><br>衣衫 褴褛  行囊 空空，<br>微如 蝼蚁  无人 与共。<br>纸醉 金迷  酒绿 灯红，<br>万千 宠爱  无上 尊荣。<br><br>我曾看遍人间百态纷纭，酸甜苦辣人生，<br>化最后黄土白骨一捧。<br>人啊 总在失去之时才 珍惜曾拥有的种种，<br>叹大梦一场空。<br><br>终又看见某个黄昏，看见林下春风，<br>像每个儿时眼中的梦。<br>而那些 至死不渝的初衷 曾牢牢握在掌中，<br>像最灿烂星空。<br><br>终又梦见那片壮阔云海，看见万顷桃红，<br>掀起心底的暴雨山洪。<br>默默 死去或默默永生 至少也曾心怀孤勇，<br>与之温暖相拥。<br><br>旁观者S的独白<br>演唱：玄觞<br>作词：素昭<br>作曲：江楼<br>编曲：简吟<br>和声编唱：阿南sara【辣耳朵工作室】<br>题字：零雨其蒙蒙<br>混音：Mr鱼<br>策划：苏别久【十年言心】<br>美工：竹醉【十年言心】<br>pver：南MISAO<br>曲绘：影子【弧光工作室】<br>鸣谢：果子狸<br></div><div class=\"crl\"><a id=\"flag_ctrl\" href=\"javascript:void(0)\" class=\"s-fc7\">展开<i class=\"u-icn u-icn-69\"></i></a></div></div>','省略500字',4),(13,'2024-10-16 18:20:14','https://p1.music.126.net/C46EsA5gsbTPWjOFNLXlTA==/109951163023120938.jpg?param=130y130','不老梦','https://music.163.com/song/media/outer/url?id=421137682.mp3','银临','<div id=\"lyric-content\" class=\"bd bd-open f-brk f-ib\" data-song-id=\"421137682\" data-third-copy=\"false\" ,=\"\" copy-from=\"\">等不到鬓雪相拥<br>重饮渭水畔那一盏虔诚<br><div id=\"flag_more\" class=\"\">终究是绸缪青冢<br>替我将灞桥柳供奉<br><br>来世再漱月鸣筝<br>也许还能道声久别珍重<br>天意总将人捉弄<br>怎奈何身不由己情衷<br><br>于万人中万幸得以相逢<br>刹那间澈净明通<br>成为我所向披靡的勇气和惶恐<br>裂山海 堕苍穹<br><br>爱若执炬迎风<br>炽烈而哀恸<br>诸般滋味皆在其中<br>韶华宛转吟诵<br>苍凉的光荣<br>急景凋年深情难共<br><br>倏忽天地琉璃灯<br>光阴过处徒留皎月几盅<br>温柔了十方春冬<br>眷你眉目在我眼瞳<br><br>彼时击节讴新声<br>唱彻白首之约抱柱之盟<br>摩肩人步履匆匆<br>多少相遇能有始有终<br><br>若要忘却年少轻狂的痛<br>从此后分赴西东<br>不如作蜉蝣麻衣霜染淋漓死生<br>恣朝暮 彀长空<br><br>卸去人间妆红<br>我终于读懂<br>痴心熬尽才可倾城<br>唯有亘古寒峰<br>能安葬浮生<br>至死不渝的一场梦<br><br>天光落笔波折<br>岁月都干涸<br>只剩别离来不及说<br>宁愿折心沐火<br>舍不得勘破<br>是你唇边夜雨清荷<br></div><div class=\"crl\"><a id=\"flag_ctrl\" href=\"javascript:void(0)\" class=\"s-fc7\">收起<i class=\"u-icn u-icn-70\"></i></a></div></div>','省略500字',4),(14,'2024-10-16 18:22:14','https://p2.music.126.net/9vTBShJtX57oUFEXaMGGMA==/109951168592691789.jpg?param=130y130','I Don\'t Wanna Wake Up','https://music.163.com/song/media/outer/url?id=490637523.mp3','Makoto / Karina Ramage','<div id=\"lyric-content\" class=\"bd bd-open f-brk f-ib\" data-song-id=\"490637523\" data-third-copy=\"false\" ,=\"\" copy-from=\"\">作词 : Makoto Shimizu/Karina Ramage/Phillip Holloway<br>作曲 : Makoto Shimizu/Karina Ramage/Phillip Holloway<br>You can turn the lights out<br>你可以把灯关上<br>You can turn the lights out<br>你可以把灯关上<br>You, you can turn the lights out<br>你，你可以把灯关上<br>You can turn the lights out<br>你可以把灯关上<br><div id=\"flag_more\" class=\"\">You can turn the lights out<br>你可以把灯关上<br>I, I can do this all night long<br>我，我可以整晚都做这件事<br>And feel the music touch me when there<br>音乐在那里触动着我<br>And I, want you, ooh, alone<br>我想要与你一起，但我只是孤身一人<br>And I, want you, ooh, alone<br>我想要与你一起，但我只是孤身一人<br>Alone<br>只是孤身一人<br>Alone<br>只是孤身一人<br>You know I don\'t want this<br>你知道我并不想这样<br>You know I don\'t want this night to end in me to go without you<br>你知道我不想整夜无你孤身一人<br>I don\'t wanna wake up<br>我不想醒来<br>I don\'t want to wake up without you and pretend you never were there<br>我不想孤身一人醒来假装你从未来过<br>At night, when everything is beautiful<br>今夜，所有事物都如此美丽<br>And you don\'t want the night to ever end<br>你也不想让这个夜晚永远结束<br>And I just can\'t help<br>我只是有点情不自禁<br>I just can\'t help myself<br>我只是有些不由自主<br>I need you and I don\'t want to pretend<br>我需要你，我不想再去伪装<br>\'Cuz I, want you, ooh, alone<br>因为我想要与你一起而不是孤身一人<br>And I, want you, ooh, alone<br>我想要与你一起而不是孤身一人<br>\'Cuz I, want you, ooh, alone<br>因为我想要与你一起而不是孤身一人<br>And I, want you, ooh, alone<br>我想要与你一起而不是孤身一人<br>alone<br>但我最终还是孤身一人<br></div><div class=\"crl\"><a id=\"flag_ctrl\" href=\"javascript:void(0)\" class=\"s-fc7\">收起<i class=\"u-icn u-icn-70\"></i></a></div></div>','省略500字',4);

--
-- Table structure for table `std`
--

DROP TABLE IF EXISTS `std`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `std` (
  `hao` int(11) DEFAULT NULL,
  `name` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `std`
--

INSERT INTO `std` VALUES (1,21),(2,31),(1,3),(1,44),(2,5);

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `avatar` text,
  `des` text,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

INSERT INTO `user` VALUES (1,'东雪莲','/files/1728974480851.jpg','骂谁罕见','GFhWqsXuZCUT+bH0Kmy2Zg=='),(4,'永雏塔菲','/files/1728959980251.jpg','骂谁唐氏','GFhWqsXuZCUT+bH0Kmy2Zg=='),(5,'我是超级牛马','/public/vite.svg',NULL,'GFhWqsXuZCUT+bH0Kmy2Zg=='),(6,'我是傻逼','/public/vite.svg',NULL,'GFhWqsXuZCUT+bH0Kmy2Zg=='),(7,'绫地宁宁','/public/vite.svg',NULL,'CTEc0MoxyOKTYkXeZvXabA==');
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-19 12:58:00
