# test/minitest.rb
#
# Minitest
#

require 'minitest/reporters'
require 'minitest/autorun'
Minitest::Reporters.use!

require '../models/models.rb'

class BookTest < Minitest::Test
  def test_shelf_all_find
    Book.shelf("./books")
    books = Book.all
    assert_equal 2, books.size
    assert_equal 'testbook2', books[0].code
    assert_equal 'testbook3', books[1].code
    assert_equal 'これは２冊目のタイトルです', books[0].title
    assert_equal 'これは第3版のタイトルです', books[1].title

    books2 = Book.find('第3')
    assert_equal 1, books2.size
    assert_equal 'testbook3', books2[0].code
    assert_equal 'これは第3版のタイトルです', books2[0].title
  end

  def test_new
    book = Book.new('testbook', 'testbook.md')
    assert_equal 'testbook', book.code
    #assert_equal 'testbook_cover.jpg', book.cover
    assert_equal 'これは本のタイトルです', book.title
    assert_equal '名無し', book.author
    assert_equal 2021, book.date.year
    assert_equal 'これはリード文です。一応、複数行になってもくっつけられます。',
                 book.lead
    assert_equal 1, book.scene(1).no
    assert_equal "最初のシーン", book.scene(1).title
    assert_equal ["とりあえず寝る", 2], book.scene(1).choices[0]
  end
end

class SceneTest < Minitest::Test
  def test_new
    body = <<EOS
これはサンプルボディ。
どこまでも続くよ。

第二パラグラフです。
これで終わり。

---
* [第一選択肢](3)
* [第二選択肢](4)

EOS

    testbody = <<EOS
これはサンプルボディ。
どこまでも続くよ。

第二パラグラフです。
これで終わり。

EOS

    scene = Scene.new(5, "テストシーン", body)
    assert_equal 5, scene.no
    assert_equal "テストシーン", scene.title
    assert_equal testbody, scene.body
    assert_equal 2, scene.choices.size
    assert_equal ["第一選択肢", 3], scene.choices[0]
    assert_equal [], scene.errors
  end

  def test_body_html
    body = <<EOS
これはサンプルボディ。
どこまでも続くよ。

* 行きは良い良い
* 帰りは怖い

第二パラグラフです。
これで終わり。

---
* [第一選択肢](3)
* [第二選択肢](4)

EOS

    testbody = <<EOS
<p>これはサンプルボディ。
どこまでも続くよ。</p>

<ul>
  <li>行きは良い良い</li>
  <li>帰りは怖い</li>
</ul>

<p>第二パラグラフです。
これで終わり。</p>

EOS

    scene = Scene.new(5, "テストシーン", body)
    assert_equal testbody, scene.body_html

  end

end

class ImageTest < Minitest::Test
  def test_exist?
    Image.set_dir(".")
    assert_equal true, Image.exist?('testbook')
    assert_equal true, Image.exist?('testbook', 1)
    assert_equal false, Image.exist?('testbook', 2)
  end

  def test_file
    Image.set_dir(".")
    body = Image.file("testbook")
    assert_equal File.size("./testbook_cover.jpg"), body.size

  end
end
