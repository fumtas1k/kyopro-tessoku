# frozen_string_literal: true

require_relative '../lib/aho_corasick'

RSpec.describe AhoCorasick do
  describe '#match' do
    it '典型例: ushers に含まれるパターンを検出できる' do
      ac = AhoCorasick.new
      %w[he she his hers].each { ac.insert(_1) }
      ac.build
      expect(ac.match('ushers')).to eq(%w[he she hers])
    end

    it '重なりと複数出現があってもユニークに検出する' do
      ac = AhoCorasick.new(%w[a ab bab bc bca c caa]).build
      expect(ac.match('abccab')).to eq(%w[a ab bc c])
    end

    it '明示したインデックスの挿入を尊重する' do
      ac = AhoCorasick.new
      ac.insert('z', 3)
      ac.insert('a', 0)
      ac.insert('za')
      ac.build
      expect(ac.match('za')).to eq(%w[a z za])
    end

    it '空文字列のテキストでは空配列を返す' do
      ac = AhoCorasick.new(%w[a ab]).build
      expect(ac.match('')).to eq([])
    end

    it 'パターン未登録の場合は空配列を返す' do
      ac = AhoCorasick.new.build
      expect(ac.match('anything')).to eq([])
    end

    it 'マルチバイト（UTF-8）文字でも動作する' do
      ac = AhoCorasick.new(%w[か かか]).build
      expect(ac.match('かかか')).to eq(%w[か かか])
    end

    it '多数の出現があっても結果は重複排除される' do
      ac = AhoCorasick.new(%w[a aa aaa]).build
      expect(ac.match('aaaaa')).to eq(%w[a aa aaa])
    end
  end
end
