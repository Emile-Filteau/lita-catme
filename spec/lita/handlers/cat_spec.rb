require "spec_helper"

describe Lita::Handlers::Cat do
  describe '.fetch' do
    context 'whith no argument', vcr: { cassette_name: 'fetch_cat' } do
      it 'instantiate one cat object' do
        expect(described_class).to receive(:new).once
        described_class.fetch
      end

      it 'returns an array containing one cat' do
        cats = described_class.fetch
        expect(cats.length).to eq(1)
        expect(cats.first.url).to eq("https://24.media.tumblr.com/tumblr_m0mjqs3zeu1r6b7kmo1_500.jpg")
      end
    end

    context 'with cout argument set', vcr: { cassette_name: 'fetch_multiple_cats' } do
      it 'instantiate the right amount of cats' do
        expect(described_class).to receive(:new).exactly(10).times
        described_class.fetch(count: 10)
      end

      it 'returns an array containing the right amount Cat' do
        cats= described_class.fetch(count: 10)

        expect(cats.length).to eq(10)
        cats.each { |cat| expect(cat.url).to match(URI.regexp) }
      end
    end

    context 'with category argument set to valid value', vcr: { cassette_name: 'fetch_with_category' } do
      it 'instaniate one cat object' do
        expect(described_class).to receive(:new).once
        described_class.fetch(category: 'boxes')
      end

      it 'returns an array containing one cat in the given category' do
        cats = described_class.fetch(category: 'boxes')
        expect(cats.length).to eq(1)
        expect(cats.first.url).to eq("https://28.media.tumblr.com/tumblr_lwa29aW9RO1r0mbi6o1_500.jpg")
      end
    end

    context 'with category argument set to invalid value' do
      it 'instaniate no cat object' do
        expect(described_class).to receive(:new).never
        described_class.fetch(category: 'foobar')
      end

      it 'returns an empty array' do
        expect(described_class.fetch(category: 'foobar')).to eq([])
      end
    end
  end
end
